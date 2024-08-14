part of 'reminder_bloc.dart';

class ReminderState extends Equatable {
  final int index;
  final DateTime currentDate;
  final TimeOfDay selectedTime;
  final String medicineName;
  final String dosage;
  final String medicineType;
  final List<String> selectedWeekDays;
  final ReminderStatus status;
  final String? errorMessage;
  final String audioFilePath;
  final List<Reminder>? reminders;

  ReminderState({
    DateTime? currentDate,
    required this.index,
    TimeOfDay? selectedTime,
    this.medicineName = '',
    this.dosage = '',
    this.medicineType = '',
    List<String>? selectedWeekDays,
    this.status = ReminderStatus.initial,
    this.errorMessage,
    required this.audioFilePath,
    this.reminders = const [],
  })  : currentDate = currentDate ?? DateTime.now(),
        selectedTime = selectedTime ?? TimeOfDay.now(),
        selectedWeekDays = selectedWeekDays ?? [];

  ReminderState copyWith({
    int? index,
    DateTime? currentDate,
    TimeOfDay? selectedTime,
    String? medicineName,
    String? dosage,
    String? medicineType,
    List<String>? selectedWeekDays,
    ReminderStatus? status,
    String? errorMessage,
    String? audioFilePath,
    List<Reminder>? reminders,
  }) {
    return ReminderState(
      audioFilePath: audioFilePath ?? this.audioFilePath,
      index: index ?? this.index,
      currentDate: currentDate ?? this.currentDate,
      selectedTime: selectedTime ?? this.selectedTime,
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      medicineType: medicineType ?? this.medicineType,
      selectedWeekDays: selectedWeekDays ?? this.selectedWeekDays,
      status: status ?? this.status,
      errorMessage: errorMessage,
      reminders: reminders ?? this.reminders,
    );
  }

  @override
  List<Object?> get props => [
    index,
    currentDate,
    selectedTime,
    medicineName,
    dosage,
    medicineType,
    selectedWeekDays,
    status,
    errorMessage,
    audioFilePath,
    reminders,
  ];
}

enum ReminderStatus {
  initial,
  loading,
  success,
  error,
}