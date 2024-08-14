import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class FlutterLocalNotification{

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('vitavibe_logo');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        selectNotification(response.payload);
      },
    );
  }

  Future<void> selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
      // Handle the notification tap action here
    }
  }

  Future<void> showNotification(int notificationId,String notificationTitle,notificationBody,) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'vita vibe 1.0',
      'vita vibe_channel',
      channelDescription: 'supplement assistant',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );


    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notificationTitle,
      notificationBody,
      notificationDetails,
      payload: 'payload',
    );
  }


  ///                               =>          For Schedule Notifications                                           ///


  Future<String> copyFileToInternalStorage(String externalFilePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final String internalFilePath = '${directory.path}/custom_sound.mp3';
    final File newFile = await File(externalFilePath).copy(internalFilePath);
    return newFile.path;
  }

  Future<void> requestPermissions() async {
    await Permission.storage.request();
  }


  Future<void> scheduleNotification({
      required String soundFilePath, required tz.TZDateTime scheduledDate}) async {

    final Uri soundUri = Uri.file(soundFilePath);
    final AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'vita vibe 1.0',
      'vita vibe_channel',
      channelDescription: 'supplement assistant',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    //  sound: FilePathAndroidNotificationSound(),
    );

    final NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    int id = 0;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id++,
      'scheduled title',
      'scheduled body',
      scheduledDate,
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Schedule daily at the same time
    );
  }


}
