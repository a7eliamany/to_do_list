import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/Model/task_model.dart';

Future<void> creatNotification({
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
  } else {
    // await AwesomeDialog(
    //   context: context,
    //   body: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: Text(
    //       "Task added succescfully but you need to turn on the notification to recive",
    //       style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
    //     ),
    //   ),
    //   dialogType: DialogType.warning,
    //   btnOk: AnimatedButton(
    //     pressEvent: () async {
    //       AwesomeNotifications().requestPermissionToSendNotifications();
    //       bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    //       if (isAllowed) {
    //         myFlushBar(context: context, message: "Notification Allowed");
    //       }
    //     },
    //     text: "turn on",
    //     color: Colors.green,
    //   ),

    //   btnCancel: AnimatedButton(
    //     pressEvent: () {
    //       Navigator.of(context).pop();
    //     },
    //     text: "cancel",
    //   ),
    // ).show();
  }
}
