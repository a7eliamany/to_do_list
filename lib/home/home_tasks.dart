import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/TaskCupit/task_cupit.dart';
import 'package:todo_list/TaskCupit/task_state.dart';
import 'package:todo_list/home/home_custom.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCupit, TaskState>(
      builder: (context, state) {
        if (state is TaskUpdate) {
          if (state.tasks.isEmpty) {
            return Column(
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/animation/EmptyList.json',
                    repeat: true,
                  ),
                ),
                Text(
                  "Tasks is Empty",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            );
          } else {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) => Tasks(index: index),
            );
          }
        } else {
          return Text('');
        }
      },
    );
  }
}
