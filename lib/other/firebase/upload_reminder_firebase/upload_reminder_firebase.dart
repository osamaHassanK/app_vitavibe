import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../notification_service/notification_service.dart';
import '../add_notification/add_notification_firebase.dart';

Future<void> uploadReminder({
  required String medicineName,
  required String dosage,
  required String medicineType,
  required List<String> selectedWeekDays,
  required TimeOfDay selectedTime,
  required String audioFilePath,
}) async {
  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception("User is not logged in");
  }

  // Create a reference to the user's document
  final userDocRef =
      FirebaseFirestore.instance.collection('users').doc(user.uid);

  // Create a new document in the 'MedicineReminder' collection
  final reminderRef = userDocRef.collection('MedicineReminder').doc();

  // Prepare data
  final reminderData = {
    'audioFilePath' : audioFilePath,
    'medicineName': medicineName,
    'dosage': dosage,
    'medicineType': medicineType,
    'selectedWeekDays': selectedWeekDays,
    'selectedTime':
        '${selectedTime.hour}:${selectedTime.minute}', // Format time as string
    'createdAt': FieldValue
        .serverTimestamp(), // Timestamp for when the reminder was created
  };

  try {
    await reminderRef.set(reminderData);

    NotificationService.showNotification(
        title: "VitaVibe", body: "Reminder uploaded successfully");

    AddNotificationFirebase.addNotificationToFirebase(
        notification: "Reminder uploaded successfully");

    print("Reminder uploaded successfully");
  } catch (e) {
    print("Error uploading reminder: $e");
    NotificationService.showNotification(
        title: "Error", body: "$e");
    throw e; // Optionally rethrow the error for further handling
  }
}
