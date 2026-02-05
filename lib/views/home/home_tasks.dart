import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    style: GoogleFonts.afacad(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.tasks!.length,
              itemBuilder: (context, index) => InkWell(
                child: Tasks(index: index),
                onTap: () {},
              ),
            );
          }
        } else {
          return Text('');
        }
      },
    );
  }
}
