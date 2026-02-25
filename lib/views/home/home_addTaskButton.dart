import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/views/AddTaskPage/add_custom_buttom_sheet.dart';

class AddTaskButton extends StatelessWidget {
  final TextEditingController textEditingController;
  const AddTaskButton({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: double.infinity,
        child: AnimatedButton(
          pressEvent: () {
            showModalBottomSheet(
              isScrollControlled: true,
              showDragHandle: true,
              useSafeArea: true,
              context: context,
              builder: (context) => Scaffold(
                resizeToAvoidBottomInset: true,
                body: AddCustomBottomSheet(),
              ),
            );
          },
          color: Colors.orange,
          text: "Add task",
          buttonTextStyle: TextStyle(
            fontFamily: "Afacad",
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
