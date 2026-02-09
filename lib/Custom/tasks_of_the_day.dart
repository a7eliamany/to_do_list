import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/Model/task_model.dart';
import 'package:todo_list/views/home/home_custom.dart';

class TasksOfTheDay extends StatefulWidget {
  final DateTime selectedDay;
  final List<TaskModel> tasks;
  const TasksOfTheDay({
    super.key,
    required this.selectedDay,
    required this.tasks,
  });

  @override
  State<TasksOfTheDay> createState() => _TasksOfTheDayState();
}

class _TasksOfTheDayState extends State<TasksOfTheDay> {
  @override
  Widget build(BuildContext context) {
    final events = widget.tasks.where((task) {
      final d = DateTime.parse(task.date!);
      return d.year == widget.selectedDay.year &&
          d.month == widget.selectedDay.month &&
          d.day == widget.selectedDay.day;
    }).toList();
    if (events.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'No tasks',
            style: GoogleFonts.afacad(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Expanded(child: Tasks(tasks: events));
    }
  }
}
