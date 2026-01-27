// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:todo_list/main.dart';

// Future<void> showNotification() async {
//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'channel_id',
//     'channel_name',
//     channelDescription: 'Your channel description',
//     importance: Importance.high,
//     priority: Priority.high,
//   );

//   const NotificationDetails details = NotificationDetails(
//     android: androidDetails,
//   );

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     '📅 تذكير بالمهام',
//     'ما تنساش تراجع الليست النهارده!',
//     details,
//   );
// }

// Future<void> scheduleNotification() async {
//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'schedule_channel',
//     'Scheduled Notifications',
//     channelDescription: 'Notification channel for scheduled alerts',
//     importance: Importance.high,
//     priority: Priority.high,
//   );

//   const NotificationDetails details = NotificationDetails(
//     android: androidDetails,
//   );

//   final scheduledTime = tz.TZDateTime.now(
//     tz.local,
//   ).add(const Duration(seconds: 5));

//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     1,
//     '⏰ تذكير مهم',
//     'يلا راجع المهام اللي وراك يا نجم 💪',
//     scheduledTime,
//     details,
//     payload: 'scheduled',
//     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     // ملاحظات: لا تضيف uiLocalNotificationDateInterpretation هنا (إصدارات جديدة اتشالت)
//     // ولا تضيف matchDateTimeComponents لو عايز إشعار مرة واحدة بعد الـ Duration
//   );

//   debugPrint('تم جدولة الإشعار عند: $scheduledTime');
// }
