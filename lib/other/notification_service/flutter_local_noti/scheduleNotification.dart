// Future<void> scheduleNotification({
//   required String title,
//   required String body,
//   required DateTime scheduledDate,
//   String? soundPath,
//   Map<String, String>? payload,
// }) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   AndroidNotificationDetails(
//     'your_channel_id',
//     'your_channel_name',
//     'your_channel_description',
//     importance: Importance.max,
//     priority: Priority.high,
//     showWhen: true,
//     sound: soundPath != null
//         ? RawResourceAndroidNotificationSound(soundPath)
//         : null,
//   );
//
//   const NotificationDetails platformChannelSpecifics =
//   NotificationDetails(android: androidPlatformChannelSpecifics);
//
//   await flutterLocalNotificationsPlugin.schedule(
//     0,
//     title,
//     body,
//     scheduledDate,
//     platformChannelSpecifics,
//     payload: payload != null ? payload.entries.toString() : null,
//   );
// }
