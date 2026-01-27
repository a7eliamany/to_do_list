import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/Custom/CustomTextForm.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/TaskCupit/task_cupit.dart';
import 'package:todo_list/TaskCupit/task_state.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/packages/flush_bar.dart';

class EditCustomButtomSheet extends StatefulWidget {
  final String taskId;
  final int index;
  final TextEditingController textEditingController;
  const EditCustomButtomSheet({
    super.key,
    required this.textEditingController,
    required this.index,
    required this.taskId,
  });

  @override
  State<EditCustomButtomSheet> createState() => _EditCustomButtomSheet();
}

class _EditCustomButtomSheet extends State<EditCustomButtomSheet> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Form(
                key: globalKey,
                child: CustomTextForm(
                  textEditingController: widget.textEditingController,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: BlocBuilder<TaskCupit, TaskState>(
                builder: (context, state) {
                  var tasks = state.tasks[widget.index];
                  return FilterChipCustom(
                    category: tasks.category!,
                    onSelected: (val) async {
                      final results = await showMenu(
                        position: RelativeRect.fromLTRB(100, 300, 100, 100),
                        context: context,
                        items: categoryitems,
                      );
                      context.read<TaskCupit>().taskChangeCategory(
                        taskId: tasks.id,
                        category: results ?? tasks.category!,
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      // pickedTime = time.format(context);
                    }
                  },
                  icon: Icon(Icons.timer, size: 30),
                ),
                IconButton(
                  onPressed: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2099),
                    );
                    if (date != null) {
                      // pickedDate = DateFormat.yMMMEd().format(date);
                    }
                  },
                  icon: Icon(Icons.calendar_today, size: 30),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: phoneWidth / 2,
                child: AnimatedButton(
                  buttonTextStyle: TextStyle(fontSize: 18, color: Colors.white),
                  pressEvent: () {
                    if (widget.textEditingController.text.trim().isNotEmpty) {
                      context.read<TaskCupit>().taskEdit(
                        taskId: widget.taskId,
                        title: widget.textEditingController.text,
                      );
                      widget.textEditingController.clear();
                      Navigator.of(context).pop();
                    } else {
                      myFlushBar(
                        context: context,
                        message: "Task can`t be empty",
                        color: Colors.red,
                      );
                    }
                  },
                  text: "edit",
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
