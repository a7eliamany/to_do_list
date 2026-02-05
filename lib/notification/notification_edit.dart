import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';
import 'package:todo_list/TaskCupit/task_cupit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/task_model.dart';

Future<void> editNotification({
  required String taskId,
  required BuildContext context,
}) async {
  TaskModel task = context.read<TaskCupit>().getTaskById(taskId);
  TimeOfDay taskTime = task.time!.toTimeOfDay12h();
  DateTime taskDate = DateTime.parse(task.date!);
  bool isNotificationAllowed = await AwesomeNotifications()
      .isNotificationAllowed();

  if (isNotificationAllowed) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        body: task.title,
        backgroundColor: categoryColors[task.category],
        color: categoryColors[task.category],
        id: task.id.hashCode,
        channelKey: task.category!,
        title: "Task Reminder ${task.category}",
        payload: {"taskId": task.id},
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
        year: taskDate.year,
        day: taskDate.day,
        month: taskDate.month,
        hour: taskTime.hour,
        minute: taskTime.minute,
        second: 0,
        repeats: task.repeat ?? false,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'DONE',
          label: 'Done',
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: 'SNOOZE',
          label: 'Snooze 15m',
          actionType: ActionType.Default,
        ),
      ],
    );
  }
}
