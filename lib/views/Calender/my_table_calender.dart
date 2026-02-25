import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/Custom/tasks_of_the_day.dart';
import 'package:todo_list/Model/task_model.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/cubit/Task/task_state.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/services/local_storage.dart';
import 'package:todo_list/views/home/home_header.dart';

class MyCalender extends StatefulWidget {
  const MyCalender({super.key});

  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCupit, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Header(title: "Calender")),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  availableCalendarFormats: _availableCalendarFormats,
                  onFormatChanged: (format) {
                    _calendarFormat = format;
                    setState(() {});
                  },
                  eventLoader: (day) {
                    final bool viewDeleted =
                        LocalStorage.instance.getBool(
                          SettingsTitle.viewDeletedInCalender,
                        ) ??
                        false;
                    final List<TaskModel> validTasks = viewDeleted
                        ? state.tasks
                        : context.read<TaskCupit>().getValidTasks();

                    return validTasks.where((task) {
                      final taskDate = DateTime.parse(task.date!);

                      return taskDate.year == day.year &&
                          taskDate.month == day.month &&
                          taskDate.day == day.day;
                    }).toList();
                  },
                  calendarBuilders: calendarBuilder(),
                  selectedDayPredicate: (day) {
                    return isSameDay(day, _selectedDay);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                selectedDay(),
                TasksOfTheDay(selectedDay: _selectedDay, tasks: state.tasks),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget selectedDay() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        DateFormat.yMMMMd().format(_selectedDay),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: "Afacad",
        ),
      ),
    );
  }

  CalendarBuilders calendarBuilder() {
    return CalendarBuilders(
      markerBuilder: (context, day, events) {
        if (events.isEmpty) return null;

        final firstTask = events.first as TaskModel;

        TaskCategory taskCategory = TaskCategoryConfig.stringToCategory(
          firstTask.category!,
        );
        final color = TaskCategoryConfig.categoryColors[taskCategory];
        return CircleAvatar(backgroundColor: color, radius: 5);
      },
    );
  }
}

Map<CalendarFormat, String> _availableCalendarFormats = const {
  CalendarFormat.month: 'Week',
  CalendarFormat.twoWeeks: "Month",
  CalendarFormat.week: '2 Week',
};
