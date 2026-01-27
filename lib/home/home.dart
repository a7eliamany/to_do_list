import 'package:flutter/material.dart';
import 'package:todo_list/home/home_header.dart';
import 'package:todo_list/home/home_addTaskButton.dart';
import 'package:todo_list/home/home_tasks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //Header
              Header(),
              const SizedBox(height: 50),
              //button Add task
              AddTaskButton(textEditingController: textEditingController),
              const SizedBox(height: 10),
              // Task view
              Expanded(child: HomeTasks()),
            ],
          ),
        ),
      ),
    );
  }
}
