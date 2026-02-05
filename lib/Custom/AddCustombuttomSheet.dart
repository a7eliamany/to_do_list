import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/Custom/CustomTextForm.dart';
import 'package:todo_list/Custom/EditCustomButtomSheet.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/notification/notification_create.dart';
import 'package:todo_list/packages/flush_bar.dart';
import 'package:uuid/uuid.dart';

class AddCustomButtomSheet extends StatefulWidget {
  const AddCustomButtomSheet({super.key});
  @override
  State<AddCustomButtomSheet> createState() => _AddCustomButtomSheetState();
}

class _AddCustomButtomSheetState extends State<AddCustomButtomSheet> {
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
                final results = await categoryMenu;
                _category = results ?? _category;
                setState(() {});
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
          Row(
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
          ),
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
        text: "Add",
        color: Colors.green,
        pressEvent: () async {
          _pickedDate ??= DateTime.now().add(const Duration(minutes: 15));
          _pickedTime ??= TimeOfDay.now().addMinutes(15);
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
            date: _pickedDate!,
            time: _pickedTime!,
            id: _id,
            repeat: repeat,
          );
          creatNotification(taskId: _id, context: context);
          Navigator.of(context).pop();
          myFlushBar(context: context, message: "Task added succefully");
        },
      ),
    );
  }

  Future<dynamic> get categoryMenu => showMenu(
    position: RelativeRect.fromLTRB(60, 200, 100, 100),
    context: context,
    items: categoryitems,
  );
}

Uuid _uuid = Uuid();
