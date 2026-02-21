import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/cubit/Task/task_state.dart';
import 'package:todo_list/views/home/home_custom.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCupit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is TaskUpdate) {
          if (state.tasks!.isEmpty) {
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
            return Tasks(tasks: state.tasks!);
          }
        } else {
          return Text('');
        }
      },
    );
  }
}
