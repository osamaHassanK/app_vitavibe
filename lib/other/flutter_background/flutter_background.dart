import 'package:app_vitavibe/other/notification_service/flutter_local_noti/init_function.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_background/flutter_background.dart';

class RunAppInBackground {

  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Vita vibe Running in Background",
    notificationText: "Background notification for keeping the Vita vibe app running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );

  Future<void> initialize() async {
    await FlutterBackground.initialize(androidConfig: androidConfig);
  }

  Future<void> startBackgroundTask() async {
    bool success = await FlutterBackground.enableBackgroundExecution();
    FlutterLocalNotification localNotification = FlutterLocalNotification();
    if (success) {
     // localNotification.showNotification(0, 'Notification status','Background task started successfully');
      print('Background task started successfully');
    } else {
      //localNotification.showNotification(0, 'Notification status','Handle failure to start background task');
      print("Handle failure to start background task");
    }
  }

  Future<void> stopBackgroundTask() async {
    bool success = await FlutterBackground.disableBackgroundExecution();
    FlutterLocalNotification localNotification = FlutterLocalNotification();

    if (success) {
      localNotification.showNotification(0, 'Notification status',"Background task started successfully");
      print('Background task started successfully');
    } else {
      print("Handle failure to start background task");
      localNotification.showNotification(0,'Notification status', 'Handle failure to start background task');

    }
  }
}
