import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/cubit/Task/task_state.dart';
import 'package:todo_list/views/edit_custom_buttom_sheet.dart';

class SortIcon extends StatelessWidget {
  const SortIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCupit, TaskState>(
      builder: (context, state) {
        final bool validTasks = context
            .read<TaskCupit>()
            .getValidTasks()
            .isNotEmpty;
        return Align(
          alignment: AlignmentGeometry.topRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (validTasks)
                IconButton(
                  onPressed: () {
                    context.read<TaskCupit>().sortTasks();
                  },
                  icon: Icon(Icons.sort, color: Colors.blue, size: 25),
                  tooltip: "Sort",
                ),
              if (validTasks)
                IconButton(
                  onPressed: () {
                    AwesomeDialog(
                      dialogType: DialogType.warning,
                      body: Text(
                        "you will delete all tasks , are you sure",
                        style: textStyle(),
                      ),
                      btnCancel: AnimatedButton(
                        pressEvent: () {
                          Navigator.of(context).pop();
                        },
                        text: "Cancel",
                        color: Colors.blue,
                      ),
                      btnOk: AnimatedButton(
                        pressEvent: () {
                          context.read<TaskCupit>().removeAll(true);
                          Navigator.of(context).pop();
                        },
                        text: "Delete",
                        color: Colors.red,
                      ),

                      context: context,
                    ).show();
                  },
                  icon: Icon(Icons.delete, color: Colors.red, size: 25),
                ),
            ],
          ),
        );
      },
    );
  }
}
