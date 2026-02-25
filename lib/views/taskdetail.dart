import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/Custom/filter_chip.dart';
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Spacer(),
              Align(
                alignment: AlignmentGeometry.center,
                child: Hero(
                  tag: task.id,
                  child: Card(
                    child: ListTile(
                      title: Text(task.title),
                      trailing: FilterChipCustom(
                        category: task.category!,
                        isDeleted: task.isDeleted!,
                      ),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (val) {
                          setState(() {
                            context.read<TaskCupit>().taskToggle(
                              task.id,
                              context,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
