// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final int typeId = 0;

  @override
  Reminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Reminder(
      reminderID: fields[6] as int? ?? 0,
      medicineName: fields[0] as String? ?? '',
      reminderTime: fields[1] as DateTime? ?? DateTime.now(),
      dosage: fields[2] as String? ?? '',
      medicineType: fields[3] as String? ?? '',
      daysOfWeek: (fields[4] as List?)?.cast<String>() ?? [],
      audioFilePath: fields[5] as String? ?? '',
      notificationId: fields[7] as int?, // Correctly handle nullable int
    );
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(8) // Update the number of fields to match the current model
      ..writeByte(0)
      ..write(obj.medicineName)
      ..writeByte(1)
      ..write(obj.reminderTime)
      ..writeByte(2)
      ..write(obj.dosage)
      ..writeByte(3)
      ..write(obj.medicineType)
      ..writeByte(4)
      ..write(obj.daysOfWeek)
      ..writeByte(5)
      ..write(obj.audioFilePath)
      ..writeByte(6)
      ..write(obj.reminderID)
      ..writeByte(7)
      ..write(obj.notificationId); // Correctly handle nullable int
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ReminderAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

