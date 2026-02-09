import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/Custom/custom_textForm.dart';
import 'package:todo_list/views/edit_custom_buttom_sheet.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/notification/notification_create.dart';
import 'package:todo_list/packages/flush_bar.dart';
import 'package:uuid/uuid.dart';

class AddCustomBottomSheet extends StatefulWidget {
  const AddCustomBottomSheet({super.key});
  @override
  State<AddCustomBottomSheet> createState() => _AddCustomBottomSheetState();
}

class _AddCustomBottomSheetState extends State<AddCustomBottomSheet> {
  late TextEditingController textEditingController;

  String? _category;
  TimeOfDay? _pickedTime;
  DateTime? _pickedDate;
  late String _id;
  bool repeat = false;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // text form
          CustomTextForm(textEditingController: textEditingController),

          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: FilterChipCustom(
              category: _category ?? "Category",
              onSelected: (val) async {
                final TaskCategory? results = await categoryMenu;
                if (results != null) {
                  _category = results.name;
                  setState(() {});
                }
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildDatePicker(),
              Text(
                (_pickedDate == null)
                    ? "Choose the Date"
                    : DateFormat.yMd().format(_pickedDate!),
                style: textStyle(),
              ),
            ],
          ),
          Row(
            children: [
              _buildTimePicker(),
              Text(
                _pickedTime?.format(context) ?? "Choose the time",
                style: textStyle(),
              ),
            ],
          ),
          _repeatCheckBox(),

          Align(alignment: Alignment.bottomRight, child: _buildAddButton()),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return IconButton(
      icon: const Icon(Icons.calendar_today, size: 30),
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _pickedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2099),
        );

        if (date != null) {
          setState(() {
            _pickedDate = date;
          });
        }
      },
    );
  }

  Widget _buildTimePicker() {
    return IconButton(
      icon: const Icon(Icons.timer, size: 30),
      onPressed: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: _pickedTime ?? TimeOfDay.now(),
        );

        if (time != null) {
          setState(() {
            _pickedTime = time;
          });
        }
      },
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: 150,
      child: AnimatedButton(
        text: "Add Task",
        color: Colors.orange,
        pressEvent: () async {
          _pickedDate ??= DateTime.now().add(const Duration(minutes: 15));
          _pickedTime ??= TimeOfDay.now().addMinutes(15);

          DateTime dateTime = combineDateAndTime(_pickedDate!, _pickedTime!);
          _id = _uuid.v4();

          if (textEditingController.text.trim().isEmpty) {
            myFlushBar(
              context: context,
              message: "Task can`t be empty",
              color: Colors.red,
            );
            return;
          }
          context.read<TaskCupit>().addtask(
            title: textEditingController.text,
            category: _category ?? "general",
            date: dateTime,

            id: _id,
            repeat: repeat,
          );
          creatNotification(taskId: _id, context: context);
          Navigator.of(context).pop();
          myFlushBar(context: context, message: "Task added successfully");
        },
      ),
    );
  }

  Widget _repeatCheckBox() {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.green,
          value: repeat,
          onChanged: (val) {
            setState(() {
              repeat = val ?? false;
            });
          },
        ),
        Text("Repeat", style: textStyle()),
      ],
    );
  }

  Future<dynamic> get categoryMenu => showMenu(
    position: RelativeRect.fromLTRB(60, 200, 100, 100),
    context: context,
    items: TaskCategoryConfig.categoryitems,
  );
}

Uuid _uuid = Uuid();
DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
