import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/Theme/theme_cupit.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
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
            SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
