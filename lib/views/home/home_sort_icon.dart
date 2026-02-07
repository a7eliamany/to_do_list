import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';

class SortIcon extends StatelessWidget {
  const SortIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.topRight,
      child: IconButton(
        onPressed: () {
          context.read<TaskCupit>().sortTasks();
        },
        icon: Icon(Icons.sort),
        tooltip: "Sort",
      ),
    );
  }
}
