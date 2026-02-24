import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/packages/flutter_slidable.dart';
import 'package:todo_list/Model/task_model.dart';

class Tasks extends StatelessWidget {
  final List<TaskModel> tasks;
  const Tasks({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        TaskModel task = tasks[index];
        return FlutterSlidable(
          isDeleted: task.isDeleted!,
          taskId: task.id,
          child: Card(
            child: InkWell(
              onTap: () {
                // MyApp.navigatorKey.currentState?.push(
                //   MaterialPageRoute(
                //     builder: (_) => TaskDetail(taskId: task.id),
                //   ),
                // );
              },
              child: ListTile(
                trailing: FilterChipCustom(category: task.category!),
                leading: _Leading(tasks: task),
                subtitle: _Subtitle(tasks: task),
                title: _ListTitle(tasks: task),
              ),
            ),
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
        "${DateFormat.yMd().format(DateTime.parse(tasks.date!))}  ${DateFormat.jm().format(DateTime.parse(tasks.date!))}",
        style: TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }
}

class _ListTitle extends StatelessWidget {
  final TaskModel tasks;
  const _ListTitle({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Text(
      (tasks.title.length > 50) ? tasks.title.substring(0, 49) : tasks.title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: (tasks.isCompleted) ? Colors.grey : null,
        decoration: tasks.isCompleted ? TextDecoration.lineThrough : null,
      ),
    );
  }
}
