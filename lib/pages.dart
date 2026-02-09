import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/bottom_navigator/bottom_navigator_cubit.dart';
import 'package:todo_list/views/home/home.dart';
import 'package:todo_list/packages/salomon_bottom_bar.dart';
import 'package:todo_list/views/calender_page.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (val) {
          context.read<BottomNavigatorCubit>().changePage(val);
        },
        children: const [Home(), CalendarPage()],
      ),
      bottomNavigationBar: MySalomonBottomBar(
        onTap: (val) {
          context.read<BottomNavigatorCubit>().changePage(val);
          controller.animateToPage(
            val,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
          );
        },
      ),
    );
  }
}
