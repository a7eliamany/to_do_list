import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/cubit/Theme/theme_cupit.dart';
import 'package:todo_list/views/edit_custom_buttom_sheet.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "home",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: "Pacifico",
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<ThemeCupit>().themeChange();
              },
              icon: context.watch<ThemeCupit>().isDarkmode
                  ? Icon(Icons.dark_mode)
                  : Icon(Icons.light_mode),
            ),
            SizedBox(width: 10),
            PopupMenuButton(
              onSelected: (val) {
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
                      context.read<TaskCupit>().deleteAll();
                      Navigator.of(context).pop();
                    },
                    text: "Delete",
                    color: Colors.red,
                  ),

                  context: context,
                ).show();
              },
              itemBuilder: (BuildContext context) {
                return [PopupMenuItem(value: 1, child: Text("Delete All"))];
              },
            ),
          ],
        ),
      ],
    );
  }
}
