import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/Custom/CustomTextForm.dart';
import 'package:todo_list/Custom/EditCustomButtomSheet.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';
import 'package:todo_list/TaskCupit/task_cupit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/packages/flush_bar.dart';
import 'package:todo_list/test.dart';
import 'package:uuid/uuid.dart';

class AddCustombuttomSheet extends StatefulWidget {
  const AddCustombuttomSheet({super.key});
  @override
  State<AddCustombuttomSheet> createState() => _CustombuttomSheetState();
}

class _CustombuttomSheetState extends State<AddCustombuttomSheet> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  String? _category;
  TimeOfDay? _pickedTime;
  DateTime? _pickedDate;
  String? _date;
  late String _id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // text form
          Form(
            key: globalKey,
            child: CustomTextForm(textEditingController: textEditingController),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: FilterChipCustom(
              category: _category ?? "Category",
              onSelected: (val) async {
                final results = await showMenu(
                  position: RelativeRect.fromLTRB(60, 200, 100, 100),
                  context: context,
                  items: categoryitems,
                );
                _category = results ?? _category;
                setState(() {});
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildDatePicker(),
              Text(_date ?? "Choose the Date", style: textStyle()),
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
          _buildAddButton(),
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
            _date = DateFormat.yMMMMd().format(date);
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
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 150,
        child: AnimatedButton(
          text: "Add",
          color: Colors.green,
          pressEvent: () async {
            _pickedDate ??= DateTime.now();
            _pickedTime ??= TimeOfDay.now().addMinutes(15);
            _category ??= "general";
            _id = _uuid.v4();
            if (textEditingController.text.trim().isEmpty) {
              myFlushBar(
                context: context,
                message: "Task can`t be empty",
                color: Colors.red,
              );
              return;
            }

            await context.read<TaskCupit>().addtask(
              title: textEditingController.text,
              category: _category!,
              date: _pickedDate ?? DateTime.now(),
              time: _pickedTime ?? TimeOfDay.now(),
              id: _id,
            );

            awesomeNotifications.createNotification(
              content: NotificationContent(
                body: textEditingController.text,
                backgroundColor: categoryColors[_category],
                id: _id.hashCode,
                channelKey: "$_category",
                title: "Task Reminder",
                payload: {"taskId": _id},
              ),
              // schedule: NotificationCalendar(
              //   year: _pickedDate!.year,
              //   day: _pickedDate!.day,
              //   month: _pickedDate!.month,
              //   hour: _pickedTime!.hour,
              //   second: 0,
              //   minute: _pickedTime!.minute,
              // ),
              actionButtons: [
                NotificationActionButton(
                  key: 'DONE',
                  label: 'Done',
                  actionType: ActionType.Default,
                ),
                NotificationActionButton(
                  key: 'SNOOZE',
                  label: 'Snooze 10m',
                  actionType: ActionType.Default,
                ),
              ],
            );

            textEditingController.clear();
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

final Uuid _uuid = Uuid();
