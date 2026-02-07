import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/Theme/theme_cupit.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "home",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
            SizedBox(width: 15),
            Icon(Icons.menu),
          ],
        ),
      ],
    );
  }
}
