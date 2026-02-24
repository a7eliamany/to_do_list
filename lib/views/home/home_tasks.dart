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
          final isEmptyFromDelete = state.tasks.where(
            (task) => task.isDeleted == false,
          );
          if (isEmptyFromDelete.isEmpty) {
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
            final List<TaskModel> validTasks = context
                .read<TaskCupit>()
                .getValidTasks();
            return Tasks(tasks: validTasks);
          }
        } else {
          return Text('');
        }
      },
    );
  }
}
