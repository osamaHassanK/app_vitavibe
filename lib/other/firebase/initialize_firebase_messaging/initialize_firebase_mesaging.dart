
 //                         ==>                   Not use in project yet                   <==

import 'package:firebase_messaging/firebase_messaging.dart';
import '../../notification_service/notification_service.dart';

Future<void> initializeFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for notifications
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  // Listen for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received a message while in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
    NotificationService.showNotification(
        title: "Firebase", body: "${message.notification?.body}");
  });

  // Listen for messages when the app is opened from a notification
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message clicked!');
    // Handle the logic when a user clicks on the notification
    // Navigate to a specific screen or perform any action
  });
}
