import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:todo_list/cubit/bottom_navigator/bottom_navigator_cubit.dart';

class MySalomonBottomBar extends StatefulWidget {
  final Function(int)? onTap;
  const MySalomonBottomBar({super.key, this.onTap});

  @override
  State<MySalomonBottomBar> createState() => _MySalomonBottomBarState();
}

class _MySalomonBottomBarState extends State<MySalomonBottomBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BottomNavigatorCubit, BottomNavigatorState>(
      builder: (context, state) {
        return SalomonBottomBar(
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.unselectedWidgetColor,
          onTap: widget.onTap,
          currentIndex: state.index,
          margin: EdgeInsets.symmetric(horizontal: 50),
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
            SalomonBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text("Settings"),
              selectedColor: Colors.deepOrange,
            ),
          ],
        );
      },
    );
  }
}
