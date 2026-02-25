import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/Theme/theme_cupit.dart';
import 'package:todo_list/cubit/Theme/theme_state.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/services/local_storage.dart';
import 'package:todo_list/views/EditTaskPage/edit_custom_buttom_sheet.dart';
import 'package:todo_list/views/Settings/about_section.dart';
import 'package:todo_list/views/Settings/apperance_section.dart';
import 'package:todo_list/views/Settings/card_utility.dart';
import 'package:todo_list/views/home/home_header.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Header(title: "Settings")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskSettings(),
            SizedBox(height: 5),
            Appearance(),
            SizedBox(height: 5),
            About(),
          ],
        ),
      ),
    );
  }
}

class TaskSettings extends StatefulWidget {
  const TaskSettings({super.key});

  @override
  State<TaskSettings> createState() => _TaskSettingsState();
}

class _TaskSettingsState extends State<TaskSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Task Settings", style: textStyle()),
        SizedBox(height: 5),
        CardUtilty(
          title: SettingsTitle.askBefore,
          iconData: Icons.question_mark,
        ),
        CardUtilty(
          title: SettingsTitle.repeatTasks,
          iconData: Icons.question_mark,
        ),
        CardUtilty(
          title: SettingsTitle.viewDeletedInCalender,
          iconData: Icons.question_mark_outlined,
        ),
        CardUtilty(title: SettingsTitle.moveToTrash, iconData: Icons.delete),
        CardUtilty(
          title: SettingsTitle.notifications,
          iconData: Icons.notification_important,
        ),
        Card(
          color: context.watch<ThemeCupit>().isDarkmode
              ? null
              : Colors.indigo[200],
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed("DeletedTasksPage");
            },
            leading: Icon(Icons.delete_sweep_rounded),
            title: Text("Deleted tasks", style: textStyle()),
            subtitle: Text("view tasks which are deleted recently (60 days)"),
          ),
        ),
      ],
    );
  }
}
