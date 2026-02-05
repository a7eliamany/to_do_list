import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/TaskCupit/task_cupit.dart';
import 'package:todo_list/TaskCupit/task_state.dart';
import 'package:todo_list/packages/flutter_slidable.dart';
import 'package:todo_list/task_model.dart';

class Tasks extends StatelessWidget {
  final int index;
  const Tasks({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCupit, TaskState>(
      builder: (context, state) {
        var tasks = state.tasks![index];
        return FlutterSlidable(
          taskId: tasks.id,
          index: index,
          child: ListTile(
            trailing: FilterChipCustom(category: tasks.category!),
            leading: _Leading(tasks: tasks),
            subtitle: _Subtitle(tasks: tasks),
            title: _Title(tasks: tasks),
          ),
        );
      },
    );
  }
}

class _Leading extends StatelessWidget {
  final TaskModel tasks;
  const _Leading({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.green,
      value: tasks.isCompleted,
      onChanged: (val) {
        context.read<TaskCupit>().taskToggle(tasks.id, context);
      },
    );
  }
}

class _Subtitle extends StatelessWidget {
  final TaskModel tasks;
  const _Subtitle({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.topLeft,
      child: Text(
        "${DateFormat.yMd().format(DateTime.parse(tasks.date!))}  ${tasks.time}",
        style: TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final TaskModel tasks;
  const _Title({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Text(
      (tasks.title.length > 50) ? tasks.title.substring(0, 49) : tasks.title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: (tasks.isCompleted) ? Colors.grey : null,
          decoration: tasks.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
