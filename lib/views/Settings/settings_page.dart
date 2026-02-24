import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/Theme/theme_cupit.dart';
import 'package:todo_list/cubit/Theme/theme_state.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/services/local_storage.dart';
import 'package:todo_list/views/edit_custom_buttom_sheet.dart';
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

class CardUtilty extends StatefulWidget {
  const CardUtilty({super.key, required this.title, required this.iconData});
  final String title;
  final IconData iconData;

  @override
  State<CardUtilty> createState() => _CardUtiltyState();
}

class _CardUtiltyState extends State<CardUtilty> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(widget.iconData),
        title: Text(widget.title),
        trailing: Switch(
          value: LocalStorage.instance.getBool(widget.title) ?? false,
          onChanged: (val) {
            LocalStorage.instance.setBool(widget.title, val);
            setState(() {});
          },
          activeThumbColor: Colors.teal,
        ),
      ),
    );
  }
}

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Appearance", style: textStyle()),
        BlocBuilder<ThemeCupit, ThemeState>(
          builder: (context, state) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: Icon(
                  context.watch<ThemeCupit>().isDarkmode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                title: Text("Dark mode"),
                trailing: Switch(
                  value: state.darkMode,
                  onChanged: (val) {
                    context.read<ThemeCupit>().themeChange();
                  },
                  activeThumbColor: Colors.teal,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("About", style: textStyle()),
        const SizedBox(height: 16),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text("Version"),
          trailing: Text(
            "1.0.0",
            style: TextStyle(color: Colors.teal, fontSize: 17),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
