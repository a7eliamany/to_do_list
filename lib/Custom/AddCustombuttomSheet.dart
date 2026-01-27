import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/Custom/CustomTextForm.dart';
import 'package:todo_list/Custom/filter_chip.dart';
import 'package:todo_list/TaskCupit/task_cupit.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/packages/flush_bar.dart';

class AddCustombuttomSheet extends StatefulWidget {
  final TextEditingController textEditingController;
  const AddCustombuttomSheet({super.key, required this.textEditingController});
  @override
  State<AddCustombuttomSheet> createState() => _CustombuttomSheetState();
}

class _CustombuttomSheetState extends State<AddCustombuttomSheet> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  String? _category;
  TimeOfDay? _pickedTime;
  DateTime? _pickedDate;
  String? _date;

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
            child: CustomTextForm(
              textEditingController: widget.textEditingController,
            ),
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
          Row(children: [_buildDatePicker(), Text(_date ?? "Choose the Date")]),
          Row(
            children: [
              _buildTimePicker(),
              Text(_pickedTime?.format(context) ?? "Choose the time"),
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
          pressEvent: () {
            if (widget.textEditingController.text.trim().isEmpty) {
              myFlushBar(
                context: context,
                message: "Task can`t be empty",
                color: Colors.red,
              );
              return;
            }

            context.read<TaskCupit>().addtask(
              title: widget.textEditingController.text,
              category: _category ?? 'general',
              date: _pickedDate ?? DateTime.now(),
              time: _pickedTime ?? TimeOfDay.now(),
            );

            widget.textEditingController.clear();
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
