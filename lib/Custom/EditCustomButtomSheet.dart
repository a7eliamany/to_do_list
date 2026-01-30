import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/Custom/CustomTextForm.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';
import 'package:todo_list/TaskCupit/task_cupit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/packages/flush_bar.dart';
import 'package:todo_list/task_model.dart';

class EditCustomButtomSheet extends StatefulWidget {
  final String taskId;

  const EditCustomButtomSheet({super.key, required this.taskId});

  @override
  State<EditCustomButtomSheet> createState() => _EditCustomButtomSheet();
}

class _EditCustomButtomSheet extends State<EditCustomButtomSheet> {
  late final TextEditingController textEditingController;
  String? category;
  TimeOfDay? _pickedTime;
  DateTime? _pickedDate;
  late final TaskModel task;

  @override
  void initState() {
    super.initState();
    task = context.read<TaskCupit>().getTaskById(widget.taskId);
    _pickedTime = task.time!.toTimeOfDay12h();
    _pickedDate = DateTime.parse(task.date!);
    category = task.category;
    textEditingController = TextEditingController(text: task.title);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //textFiled
          CustomTextForm(textEditingController: textEditingController),
          SizedBox(height: 16),
          FilterChipCustom(
            category: category!,
            onSelected: (val) async {
              final result = await showMenu(
                position: RelativeRect.fromLTRB(100, 300, 100, 100),
                context: context,
                items: categoryitems,
              );
              if (result != null) {
                category = result;
                setState(() {});
              }
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildDatePicker(),
              Text(DateFormat.yMd().format(_pickedDate!), style: textStyle()),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildTimePicker(),
              Text(_pickedTime!.to12HourFormat(), style: textStyle()),
            ],
          ),
          _buildEditButton(),
        ],
      ),
    );
  }

  Widget _buildTimePicker() {
    return IconButton(
      onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: _pickedTime!,
        );
        if (time != null) {
          _pickedTime = time;
          setState(() {});
        }
      },
      icon: Icon(Icons.timer, size: 30),
    );
  }

  Widget _buildDatePicker() {
    return IconButton(
      onPressed: () async {
        final DateTime? date = await showDatePicker(
          context: context,
          initialDate: _pickedDate!.isBefore(DateTime.now())
              ? DateTime.now()
              : _pickedDate!,
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

  Widget _buildEditButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 120,
        child: AnimatedButton(
          buttonTextStyle: TextStyle(fontSize: 18, color: Colors.white),
          pressEvent: () {
            if (textEditingController.text.trim().isNotEmpty) {
              context.read<TaskCupit>().taskEdit(
                taskId: task.id,
                title: textEditingController.text,
                category: category,
                time: _pickedTime!.to12HourFormat(),
                date: _pickedDate!.toIso8601String(),
              );
              textEditingController.clear();
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
