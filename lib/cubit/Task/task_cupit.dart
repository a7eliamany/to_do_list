import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_list/cubit/Task/task_state.dart';
import 'package:todo_list/notification/notification_create.dart';
import 'package:todo_list/Model/task_model.dart';

class TaskCupit extends HydratedCubit<TaskState> {
  TaskCupit() : super(TaskUpdate(tasks: []));

  void addtask({
    required String title,
    required String category,
    required DateTime date,
    required String id,
    bool? repeat,
  }) async {
    emit(
      TaskUpdate(
        tasks: [
          ...state.tasks ?? [],
          TaskModel(
            id: id,
            title: title,
            isCompleted: false,
            category: category,
            date: date.toIso8601String(),

            repeat: repeat ?? false,
          ),
        ],
      ),
    );
  }

  void taskToggle(String id, BuildContext context) {
    late TaskModel updatedTask;
    final newList = state.tasks!.map((task) {
      if (id == task.id) {
        updatedTask = task.copyWith(isCompleted: !task.isCompleted);
        return updatedTask;
      }
      return task;
    }).toList();
    if (updatedTask.isCompleted && !updatedTask.repeat!) {
      AwesomeNotifications().cancel(id.hashCode);
    } else {
      creatNotification(taskId: id, context: context);
    }
    emit(TaskUpdate(tasks: newList));
  }

  void taskRemove(String id) async {
    emit(TaskLoading(tasks: state.tasks));
    final List<TaskModel> newList = state.tasks!
        .where((task) => task.id != id)
        .toList();
    AwesomeNotifications().cancel(id.hashCode);
    emit(TaskUpdate(tasks: newList));
  }

  void taskEdit({
    required String taskId,
    String? title,
    String? category,

    String? date,
    bool? repeat,
  }) {
    final List<TaskModel> newList = state.tasks!.map((task) {
      return (task.id == taskId)
          ? task.copyWith(
              title: title ?? task.title,
              category: category ?? task.category,

              date: date ?? task.date,
              repeat: repeat,
            )
          : task;
    }).toList();
    emit(TaskUpdate(tasks: newList));
  }

  void sortTasks() async {
    emit(TaskLoading(tasks: state.tasks));

    final List<TaskModel> sortedTasks = state.tasks!;
    sortedTasks.sort((a, b) {
      DateTime dateTimeA = DateTime.parse(a.date!);
      DateTime dateTimeB = DateTime.parse(b.date!);
      return dateTimeA.compareTo(dateTimeB);
    });
    await Future.delayed(Duration(milliseconds: 100));
    emit(TaskUpdate(tasks: sortedTasks));
  }

  void deleteAll() {
    AwesomeNotifications().cancelAll();
    emit(TaskUpdate(tasks: []));
  }

  TaskModel getTaskById(String id) {
    return state.tasks!.firstWhere((task) => task.id == id);
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    final tasksList = json['todolist'] as List<dynamic>?;

    if (tasksList == null) return TaskUpdate(tasks: []);

    final tasks = tasksList
        .map((taskJson) => TaskModel.fromjson(taskJson))
        .toList();

    return TaskUpdate(tasks: tasks);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return {'todolist': state.tasks!.map((task) => task.tojson()).toList()};
  }
}
