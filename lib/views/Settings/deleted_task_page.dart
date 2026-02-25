import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/Model/task_model.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/cubit/Task/task_state.dart';
import 'package:todo_list/views/EditTaskPage/edit_custom_buttom_sheet.dart';
import 'package:todo_list/views/home/home_custom.dart';

class DeletedTasksPage extends StatelessWidget {
  const DeletedTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              AwesomeDialog(
                dialogType: DialogType.warning,
                body: Text(
                  "you will restore all tasks , are you sure",
                  style: textStyle(),
                ),
                btnCancel: AnimatedButton(
                  pressEvent: () {
                    Navigator.of(context).pop();
                  },
                  text: "Cancel",
                  color: Colors.red,
                ),
                btnOk: AnimatedButton(
                  pressEvent: () {
                    context.read<TaskCupit>().restorAll();
                    Navigator.of(context).pop();
                  },
                  text: "Ok",
                  color: Colors.green,
                ),
                context: context,
              ).show();
            },
            icon: Icon(Icons.restore_rounded),
          ),
          IconButton(
            onPressed: () {
              context.read<TaskCupit>().removeAll(false);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocBuilder<TaskCupit, TaskState>(
        builder: (context, state) {
          final deletedTasks = state.tasks.where(
            (task) => task.isDeleted == true,
          );
          if (deletedTasks.isEmpty) {
            return Center(
              child: Text("No Deleted Tasks", style: TextStyle(fontSize: 30)),
            );
          } else {
            final List<TaskModel> deletedTasks = context
                .read<TaskCupit>()
                .getDeletedTasks();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Tasks(tasks: deletedTasks),
            );
          }
        },
      ),
    );
  }
}
