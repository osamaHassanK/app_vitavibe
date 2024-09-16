part of 'reminder_bloc.dart';

@immutable
abstract class ReminderEvent extends Equatable {
  const ReminderEvent();
}

class ClickedOnDateEvent extends ReminderEvent {
  final DateTime selectedDate;
  final int index;

  ClickedOnDateEvent(this.selectedDate, this.index);

  @override
  List<Object?> get props => [selectedDate, index];
}

class TimeSelectedEvent extends ReminderEvent {
  final TimeOfDay selectedTime;

  TimeSelectedEvent(this.selectedTime);

  @override
  List<Object?> get props => [selectedTime];
}

class MedicineNameChanged extends ReminderEvent {
  final String medicineName;

  MedicineNameChanged(this.medicineName);

  @override
  List<Object?> get props => [medicineName];
}

class DosageChanged extends ReminderEvent {
  final String dosage;

  DosageChanged(this.dosage);

  @override
  List<Object?> get props => [dosage];
}

class MedicineTypeChanged extends ReminderEvent {
  final String medicineType;

  MedicineTypeChanged(this.medicineType);

  @override
  List<Object?> get props => [medicineType];
}

class WeekDaysSelected extends ReminderEvent {
  final List<String> selectedDays;

  WeekDaysSelected(this.selectedDays);

  @override
  List<Object?> get props => [selectedDays];
}

class SaveReminderEvent extends ReminderEvent{

  @override
  List<Object?> get props => [];
}

class AudioFileSelected extends ReminderEvent {
  final String audioPath;
  AudioFileSelected(this.audioPath);

  @override
  // TODO: implement props
  List<Object?> get props => [audioPath];
}

class LoadRemindersEvent extends ReminderEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class DeleteReminderEvent extends ReminderEvent {
  final int reminderIndex; // Assuming you use index for identification

  DeleteReminderEvent(this.reminderIndex);

  @override
  List<Object?> get props => [reminderIndex];
}

class FetchRemindersEvent extends ReminderEvent {
  @override
  List<Object?> get props => [];
}