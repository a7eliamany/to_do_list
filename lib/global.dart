import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Map<String, Color?> categoryColors = {
  "general": Colors.green,
  "work": Colors.orange,
  "study": Colors.blue,
  "important": Colors.red[400],
  "personal": Colors.blueGrey,
  "special": Colors.purple,
};

class FastPopUpMenu extends PopupMenuItem<String> {
  FastPopUpMenu({super.key, required String value})
    : super(value: value, child: Text(value));
}

List<PopupMenuItem> categoryitems = [
  FastPopUpMenu(value: "general"),
  FastPopUpMenu(value: "personal"),
  FastPopUpMenu(value: "important"),
  FastPopUpMenu(value: "study"),
  FastPopUpMenu(value: "special"),
  FastPopUpMenu(value: "work"),
];

List<NotificationChannel> notificationChannel = [
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
