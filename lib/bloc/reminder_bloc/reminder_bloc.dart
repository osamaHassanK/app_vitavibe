import 'dart:core';
import 'package:app_vitavibe/other/hive/id_generator/id_generator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:workmanager/workmanager.dart';
import '../../other/models/reminder_model.dart';
import '../../other/notification_service/notification_helper.dart';
import '../../other/notification_service/notification_service.dart';
part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final Box<Reminder> reminderBox = Hive.box<Reminder>('reminderBox');

  ReminderBloc() : super(ReminderState(index: 0, audioFilePath: '')) {
    on<ClickedOnDateEvent>(_onClickedOnDateEvent);
    on<TimeSelectedEvent>(_onTimeSelectedEvent);
    on<MedicineNameChanged>(_onMedicineNameChanged);
    on<DosageChanged>(_onDosageChanged);
    on<MedicineTypeChanged>(_onMedicineTypeChanged);
    on<WeekDaysSelected>(_onWeekDaysSelected);
    on<SaveReminderEvent>(_saveReminderMethod);
    on<AudioFileSelected>(_selectedSound);
    on<DeleteReminderEvent>(_deleteReminderMethod);
    on<FetchRemindersEvent>(_fetchRemindersEvent);
    add(FetchRemindersEvent());
  }

  void _fetchRemindersEvent(FetchRemindersEvent event, Emitter<ReminderState> emit) async {
    emit(state.copyWith(status: ReminderStatus.loading));

    try {
      // Fetch reminders from Hive
      final reminders = reminderBox.values.toList();

      // Update state with the list of reminders
      emit(state.copyWith(
        reminders: reminders,
        status: ReminderStatus.success,
      ));
    } catch (e) {
      debugPrint('Error fetching reminders: ${e.toString()}');
      emit(state.copyWith(
        status: ReminderStatus.error,
        errorMessage: 'Failed to fetch reminders. Please try again.',
      ));
    }
  }


  void _deleteReminderMethod(
      DeleteReminderEvent event, Emitter<ReminderState> emit) async {
    emit(state.copyWith(status: ReminderStatus.loading));

    try {
      // Get the reminder at the specified index
      final reminder = reminderBox.getAt(event.reminderIndex);
      if (reminder != null) {
        // Cancel the notification if notificationId is not null
        if (reminder.notificationId != null) {
          await AwesomeNotifications().cancelSchedule(reminder.notificationId!);
        }

        // Delete the reminder from Hive
        await reminderBox.deleteAt(event.reminderIndex);

        // Update state with the updated list of reminders
        final updatedReminders = List<Reminder>.from(state.reminders as Iterable)
          ..removeAt(event.reminderIndex);
        emit(state.copyWith(
          status: ReminderStatus.success,
          reminders: updatedReminders,
        ));
      } else {
        emit(state.copyWith(
          status: ReminderStatus.error,
          errorMessage: 'Reminder not found.',
        ));
      }
    } catch (e) {
      debugPrint('Error deleting reminder: ${e.toString()}');
      emit(state.copyWith(
          status: ReminderStatus.error,
          errorMessage: 'Failed to delete reminder. Please try again.'));
    }
  }




  void _selectedSound(AudioFileSelected event, Emitter<ReminderState> emit) {
    emit(state.copyWith(audioFilePath: event.audioPath));
  }

  void _saveReminderMethod(SaveReminderEvent event, Emitter<ReminderState> emit) async {
    emit(state.copyWith(status: ReminderStatus.loading));

    // Ensure IdGenerator is using a Box<int> for ID generation
    final idBox = await Hive.openBox<int>('idBox'); // Use a Box<int> for ID generation
    final idGenerator = IdGenerator(idBox);

    int uniqueNotificationId = DateTime.now().millisecondsSinceEpoch & 0x7FFFFFFF;

    try {
      // Create the Reminder object
      Reminder reminder = Reminder(
        reminderID: idGenerator.getNextId(), // Ensure this method works with your ID generator
        audioFilePath: state.audioFilePath,
        medicineName: state.medicineName,
        dosage: state.dosage,
        medicineType: state.medicineType,
        reminderTime: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          state.selectedTime.hour,
          state.selectedTime.minute,
        ),
        daysOfWeek: state.selectedWeekDays,
        notificationId: uniqueNotificationId,
      );

      // Save the reminder to Hive
      await reminderBox.add(reminder);

      // Debug print
      debugPrint('Reminder saved: ${reminder.toMap()}');

      // Schedule Notifications
     // for (var day in state.selectedWeekDays) {
      for (var day in reminder.daysOfWeek) {
        int dayIndex = dayToIndex(day);
        int interval = calculateInterval(reminder.reminderTime, dayIndex);

        // Debug print
        debugPrint('Scheduling notification for $day at interval: $interval seconds');

        // Make sure NotificationService is properly implemented
        await NotificationService.showNotification(
          title: 'Reminder: ${reminder.medicineName}',
          body: 'Time to take your medicine',
          scheduled: true,
          interval: interval,
          repeat: false,
        );

      }

      emit(state.copyWith(status: ReminderStatus.success));
    } catch (e) {
      debugPrint('Error saving reminder: ${e.toString()}');
      emit(state.copyWith(
          status: ReminderStatus.error,
          errorMessage: 'Failed to save reminder. Please try again.'));
    }
  }


  void _onClickedOnDateEvent(
      ClickedOnDateEvent event, Emitter<ReminderState> emit) {
    emit(state.copyWith(
      index: event.index,
      currentDate: event.selectedDate,
    ));
  }

  void _onTimeSelectedEvent(
      TimeSelectedEvent event, Emitter<ReminderState> emit) {
    emit(state.copyWith(
      selectedTime: event.selectedTime,
    ));
  }

  void _onMedicineNameChanged(
      MedicineNameChanged event, Emitter<ReminderState> emit) {
    emit(state.copyWith(medicineName: event.medicineName));
  }

  void _onDosageChanged(DosageChanged event, Emitter<ReminderState> emit) {
    emit(state.copyWith(dosage: event.dosage));
  }

  void _onMedicineTypeChanged(
      MedicineTypeChanged event, Emitter<ReminderState> emit) {
    emit(state.copyWith(medicineType: event.medicineType));
  }

  void _onWeekDaysSelected(
      WeekDaysSelected event, Emitter<ReminderState> emit) {
    emit(state.copyWith(selectedWeekDays: event.selectedDays));
  }


}





















// void _saveReminderMethod(
//     SaveReminderEvent event, Emitter<ReminderState> emit) async {
//   emit(state.copyWith(status: ReminderStatus.loading));
//
//   int generateTimestampBasedId() {
//     return DateTime.now().millisecondsSinceEpoch;
//   }
//
//   try {
//     Reminder reminder = Reminder(
//       reminderID: generateTimestampBasedId(),
//       audioFilePath: state.audioFilePath,
//       medicineName: state.medicineName,
//       dosage: state.dosage,
//       medicineType: state.medicineType,
//       reminderTime: DateTime(
//         DateTime.now().year,
//         DateTime.now().month,
//         DateTime.now().day,
//         state.selectedTime.hour,
//         state.selectedTime.minute,
//       ),
//       daysOfWeek: state.selectedWeekDays,
//     );
//
//     // Save to Hive
//     await reminderBox.add(reminder);
//
//     // Debug print
//     debugPrint('Reminder saved: ${reminder.toMap()}');
//
//     // Save to Firebase
//     await uploadReminder(
//       medicineName: state.medicineName,
//       dosage: state.dosage,
//       medicineType: state.medicineType,
//       selectedWeekDays: state.selectedWeekDays,
//       selectedTime: state.selectedTime,
//       audioFilePath: state.audioFilePath,
//     );
//
//     // Schedule Notifications
//     for (var day in state.selectedWeekDays) {
//       int dayIndex = dayToIndex(day);
//       int interval = calculateInterval(reminder.reminderTime, dayIndex);
//
//       // Debug print
//       debugPrint(
//           'Scheduling notification for $day at interval: $interval seconds');
//
//       await NotificationService.showNotification(
//         soundSource: state.audioFilePath,
//         title: 'Reminder: ${reminder.medicineName}',
//         body:
//         'Time to take your ${reminder.dosage} of ${reminder.medicineType}',
//         scheduled: true,
//         interval: interval,
//       );
//     }
//
//     emit(state.copyWith(status: ReminderStatus.success));
//   } catch (e) {
//     debugPrint('Error saving reminder: ${e.toString()}');
//     emit(state.copyWith(
//         status: ReminderStatus.error,
//         errorMessage: 'Failed to save reminder. Please try again.'));
//   }
// }