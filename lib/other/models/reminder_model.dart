import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class Reminder extends HiveObject {
  @HiveField(0)
  final String medicineName;

  @HiveField(1)
  final DateTime reminderTime;

  @HiveField(2)
  final String dosage;

  @HiveField(3)
  final String medicineType;

  @HiveField(4)
  final List<String> daysOfWeek;

  @HiveField(5)
  final String audioFilePath;

  @HiveField(6)
  final int reminderID;

  @HiveField(7)
  final int? notificationId;

  Reminder({
    required this.reminderID,
    required this.medicineName,
    required this.reminderTime,
    required this.dosage,
    required this.medicineType,
    required this.daysOfWeek,
    required this.audioFilePath,
    this.notificationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'notificationId' : notificationId,
      'medicineName': medicineName,
      'reminderTime': reminderTime,
      'dosage': dosage,
      'medicineType': medicineType,
      'daysOfWeek': daysOfWeek,
      'audioFilePath': audioFilePath,
      'reminderID': reminderID,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      medicineName: map['medicineName'],
      reminderTime: map['reminderTime'],
      dosage: map['dosage'],
      medicineType: map['medicineType'],
      daysOfWeek: List<String>.from(map['daysOfWeek']),
      audioFilePath: map['audioFilePath'],
      reminderID: map['reminderID'],
      notificationId: map['notificationId']
    );
  }
}
