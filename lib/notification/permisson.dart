import 'package:awesome_notifications/awesome_notifications.dart';

Future<bool> checkNotificationPermission() async {
  bool isNotificationAllowed = await AwesomeNotifications()
      .isNotificationAllowed();
  if (!isNotificationAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
    isNotificationAllowed = await AwesomeNotifications()
        .isNotificationAllowed();
  }
  return isNotificationAllowed;
}
