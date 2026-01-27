import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:todo_list/cubit/bottom_navigator_cubit.dart';

class MySalomonBottomBar extends StatefulWidget {
  const MySalomonBottomBar({super.key});

  @override
  State<MySalomonBottomBar> createState() => _MySalomonBottomBarState();
}

class _MySalomonBottomBarState extends State<MySalomonBottomBar> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SalomonBottomBar(
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.unselectedWidgetColor,
      onTap: (val) {
        setState(() {
          currentindex = val;
        });
        context.read<BottomNavigatorCubit>().changePage(val);
      },
      currentIndex: currentindex,
      items: [
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text("home"),
          selectedColor: Colors.pink,
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          title: Text("calendar"),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }
}
