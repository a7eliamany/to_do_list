import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/Theme/theme_cupit.dart';
import 'package:todo_list/cubit/Theme/theme_state.dart';
import 'package:todo_list/views/EditTaskPage/edit_custom_buttom_sheet.dart';

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
