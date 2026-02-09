import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/Model/task_model.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key, required this.taskId});
  final String taskId;

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  late final TaskModel task;
  @override
  void initState() {
    task = context.read<TaskCupit>().getTaskById(widget.taskId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SizedBox(height: 200, child: Card()));
  }
}
