import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/views/add_custom_buttom_sheet.dart';
import 'package:todo_list/Custom/custom_textForm.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/notification/notification_create.dart';
import 'package:todo_list/packages/flush_bar.dart';
import 'package:todo_list/Model/task_model.dart';

class EditCustomButtomSheet extends StatefulWidget {
  final String taskId;
  const EditCustomButtomSheet({super.key, required this.taskId});
  @override
  State<EditCustomButtomSheet> createState() => _EditCustomButtomSheet();
}

class _EditCustomButtomSheet extends State<EditCustomButtomSheet> {
  late final TextEditingController textEditingController;
  String? category;
  DateTime? _pickedDate;
  late final TaskModel task;
  bool? repeat;

  @override
  void initState() {
    super.initState();
    task = context.read<TaskCupit>().getTaskById(widget.taskId);
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
              final TaskCategory? results = await categoryMenu;
              if (results != null) {
                category = results.name;
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
              Text(DateFormat.jm().format(_pickedDate!), style: textStyle()),
            ],
          ),
          Row(
            children: [
              Checkbox(
                activeColor: Colors.green,
                value: repeat ?? task.repeat,
                onChanged: (val) {
                  setState(() {
                    repeat = val ?? task.repeat;
                  });
                },
              ),
              Text("Repeat", style: textStyle()),
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
        final initilTime = TimeOfDay(
          hour: _pickedDate!.hour,
          minute: _pickedDate!.minute,
        );
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: initilTime,
        );
        if (time != null) {
          _pickedDate = combineDateAndTime(_pickedDate!, time);
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
          final time = TimeOfDay(
            hour: _pickedDate!.hour,
            minute: _pickedDate!.minute,
          );
          _pickedDate = combineDateAndTime(date, time);
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
            if (textEditingController.text.trim().isEmpty) {
              myFlushBar(
                context: context,
                message: "Task can`t be empty",
                color: Colors.red,
              );
              return;
            } else {
              context.read<TaskCupit>().taskEdit(
                taskId: task.id,
                title: textEditingController.text,
                category: category,

                date: _pickedDate!.toIso8601String(),
                repeat: repeat,
              );
              creatNotification(context: context, taskId: widget.taskId);
              Navigator.of(context).pop();
              myFlushBar(
                context: context,
                message: "Task Edited Succefully",
                color: Colors.blue,
              );
            }
          },
          text: "edit",
          color: Colors.blue,
        ),
      ),
    );
  }

  Future<dynamic> get categoryMenu => showMenu(
    position: RelativeRect.fromLTRB(60, 200, 100, 100),
    context: context,
    items: TaskCategoryConfig.categoryitems,
  );
}

TextStyle textStyle() {
  return TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
}
