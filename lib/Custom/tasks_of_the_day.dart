import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/Model/task_model.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/services/local_storage.dart';
import 'package:todo_list/views/home/home_custom.dart';

class TasksOfTheDay extends StatelessWidget {
  final DateTime selectedDay;
  final List<TaskModel> tasks;
  const TasksOfTheDay({
    super.key,
    required this.selectedDay,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final bool viewDeleted =
        LocalStorage.instance.getBool(SettingsTitle.viewDeletedInCalender) ??
        false;

    final List<TaskModel> events = tasks.where((task) {
      final d = DateTime.parse(task.date!);
      return d.year == selectedDay.year &&
          d.month == selectedDay.month &&
          d.day == selectedDay.day;
    }).toList();

    final List<TaskModel> validEvents = context.read<TaskCupit>().getValidTasks(
      events,
    );
    if (validEvents.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'No tasks',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: "Afacad",
            ),
          ),
        ),
      );
    } else {
      return Expanded(child: Tasks(tasks: viewDeleted ? events : validEvents));
    }
  }
}
