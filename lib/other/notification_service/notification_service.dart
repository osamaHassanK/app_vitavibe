import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel_group',
          channelKey: 'high_importance_channel',
          channelName: 'High Importance Notifications',
          channelDescription: 'Channel for high importance notifications',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
          soundSource: 'resource://raw/reminder_sound',

        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'High Importance Notifications Group',
        )
      ],
      debug: true,
    );

    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      // Handle navigation or other actions based on the payload
    }
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? summary,
    Map<String, String>? payload,
    ActionType actionType = ActionType.Default,
    NotificationLayout notificationLayout = NotificationLayout.Default,
    NotificationCategory? category,
    String? bigPicture,
    List<NotificationActionButton>? actionButtons,
    bool scheduled = false,
    int? interval,
    //String? soundSource,
    bool repeat = false,
  }) async {
    // Use the soundSource as the resource name if provided
  //  String? finalSound = soundSource ?? 'reminder_sound'; // Default sound name

    // Generate a unique ID for the notification
    int uniqueId = DateTime.now().millisecondsSinceEpoch & 0x7FFFFFFF;

    debugPrint('Creating notification with ID: $uniqueId ');

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
       // customSound: soundSource,
        id: uniqueId,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
        duration: Duration(seconds: 20)
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
        interval: interval!,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
        repeats: repeat,
      )
          : null,
    );
  }


}