import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/Custom/CustomTextForm.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';
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
  String? category;
  late TimeOfDay _pickedTime;
  late DateTime _pickedDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCupit, TaskState>(
      builder: (context, state) {
        var tasks = state.tasks[widget.index];
        _pickedTime = tasks.time!.toTimeOfDay12h();
        _pickedDate = DateTime.parse(tasks.date!);
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //textFiled
              CustomTextForm(
                textEditingController: widget.textEditingController,
              ),
              SizedBox(height: 16),
              FilterChipCustom(
                category: tasks.category!,
                onSelected: (val) async {
                  final results = await showMenu(
                    position: RelativeRect.fromLTRB(100, 300, 100, 100),
                    context: context,
                    items: categoryitems,
                  );
                  category = results ?? tasks.category;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  _buildDatePicker(taskDate: DateTime.parse(tasks.date!)),
                  Text(
                    DateFormat.yMd().format(DateTime.parse(tasks.date!)),
                    style: textStyle(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  _buildTimePicker(tasktime: tasks.time!.toTimeOfDay12h()),
                  Text(tasks.time!, style: textStyle()),
                ],
              ),
              _buildEditButton(taskdate: tasks.date!, tasktime: tasks.time!),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimePicker({required TimeOfDay tasktime}) {
    return IconButton(
      onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: _pickedTime ?? tasktime,
        );
        if (time != null) {
          _pickedTime = time;
          setState(() {});
        }
      },
      icon: Icon(Icons.timer, size: 30),
    );
  }

  Widget _buildDatePicker({required DateTime taskDate}) {
    return IconButton(
      onPressed: () async {
        final DateTime? date = await showDatePicker(
          context: context,
          initialDate: taskDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2099),
        );
        if (date != null) {
          _pickedDate = date;
          setState(() {});
        }
      },
      icon: Icon(Icons.calendar_today, size: 30),
    );
  }

  Widget _buildEditButton({
    required String tasktime,
    required String taskdate,
  }) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 120,
        child: AnimatedButton(
          buttonTextStyle: TextStyle(fontSize: 18, color: Colors.white),
          pressEvent: () {
            if (widget.textEditingController.text.trim().isNotEmpty) {
              context.read<TaskCupit>().taskEdit(
                taskId: widget.taskId,
                title: widget.textEditingController.text,
                category: category,
                time: _pickedTime.to12HourFormat(),
                date: _pickedDate.toIso8601String(),
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
    );
  }
}

TextStyle textStyle() {
  return TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
}
