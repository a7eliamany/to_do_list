import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/Model/task_model.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/cubit/Task/task_state.dart';
import 'package:todo_list/views/home/home_custom.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCupit, TaskState>(
      builder: (context, state) {
        if (state is TaskUpdate) {
          final List<TaskModel> notDeletedTasks = state.tasks
              .where((task) => task.isDeleted == false)
              .toList();
          if (notDeletedTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/animation/EmptyList.json',
                    repeat: true,
                    reverse: true,
                  ),
                  Text(
                    "Tasks is Empty",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: "StoryScript",
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Tasks(tasks: notDeletedTasks);
          }
        } else {
          return Text('');
        }
      },
    );
  }
}
