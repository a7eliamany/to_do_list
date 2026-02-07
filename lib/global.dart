import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

enum TaskCategory<String> { general, personal, important, study, special, work }

class TaskCategoryConfig {
  static const Map<TaskCategory, Color?> categoryColors = {
    TaskCategory.general: Colors.green,
    TaskCategory.work: Colors.orange,
    TaskCategory.study: Colors.blue,
    TaskCategory.important: Colors.red,
    TaskCategory.personal: Colors.pinkAccent,
    TaskCategory.special: Colors.purple,
  };

  static TaskCategory stringToCategory(String value) {
    return TaskCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TaskCategory.general, // default لو القيمة غلط
    );
  }

  static final List<PopupMenuItem> categoryitems = [
    FastPopUpMenu(value: TaskCategory.general),
    FastPopUpMenu(value: TaskCategory.personal),
    FastPopUpMenu(value: TaskCategory.important),
    FastPopUpMenu(value: TaskCategory.study),
    FastPopUpMenu(value: TaskCategory.special),
    FastPopUpMenu(value: TaskCategory.work),
  ];

  static final List<NotificationChannel> notificationChannel = [
    NotificationChannel(
      channelKey: 'general',
      channelName: 'general',
      channelDescription: 'for general tasks',
      importance: NotificationImportance.High,
    ),
    NotificationChannel(
      channelKey: 'personal',
      channelName: 'personal',
      channelDescription: 'Task reminders',
      importance: NotificationImportance.High,
    ),
    NotificationChannel(
      channelKey: 'important',
      channelName: 'important',
      channelDescription: 'Task reminders',
      importance: NotificationImportance.High,
    ),
    NotificationChannel(
      channelKey: 'study',
      channelName: 'study',
      channelDescription: 'Task reminders',
      importance: NotificationImportance.High,
    ),
    NotificationChannel(
      channelKey: 'special',
      channelName: 'special',
      channelDescription: 'Task reminders',
      importance: NotificationImportance.High,
    ),
    NotificationChannel(
      channelKey: 'work',
      channelName: 'work',
      channelDescription: 'Task reminders',
      importance: NotificationImportance.High,
    ),
  ];
}

class FastPopUpMenu extends PopupMenuItem<TaskCategory> {
  FastPopUpMenu({super.key, required TaskCategory value})
    : super(value: value, child: Text(value.name));
}
