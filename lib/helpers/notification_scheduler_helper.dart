import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

class NotificationSchedulerHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('vitavibe_logo');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void schedulePeriodicNotification(

      { required Duration frequency, required Duration initialDelay,
        required String taskIdentifier,
      String? taskName,

      VoidCallback? onNotificationScheduled,
      Function(dynamic error)? onError}) {

    Workmanager()
        .registerPeriodicTask(
        taskIdentifier,
        taskName ?? taskIdentifier,
        initialDelay: initialDelay,
        frequency:frequency
    )
        .then((value) {
      return onNotificationScheduled?.call();
    }).catchError((error) {
      onError?.call(error);
    });

  }

  scheduleOneTimeNotification({ required String taskIdentifier,
    String? taskName,required DateTime scheduledTime,

    VoidCallback? onNotificationScheduled,
    Function(dynamic error)? onError
  }){
    Workmanager()
        .registerOneOffTask(
      taskIdentifier,
      taskName ?? taskIdentifier,
      initialDelay: scheduledTime.difference(DateTime.now()),
    )
        .then((value) {
      return onNotificationScheduled?.call();
    }).catchError((error) {
      onError?.call(error);
    });
  }



  Future<void> showPeriodicNotification() async{

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your_channel_id', 'Your Channel Name',
        icon: 'vitavibe_logo');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Reminder',
      'This is your daily reminder!',
      platformChannelSpecifics,
      payload: 'data',
    );

  }
}
