import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';
import 'package:todo_list/cubit/Task/task_state.dart';
import 'package:todo_list/notification/notification_create.dart';
import 'package:todo_list/Model/task_model.dart';
import 'package:todo_list/views/test.dart';

class TaskCupit extends HydratedCubit<TaskState> {
  TaskCupit() : super(TaskUpdate(tasks: []));

  addtask({
    required TimeOfDay time,
    required String title,
    required String category,
    required DateTime date,
    required String id,
    bool? repeat,
  }) async {
    emit(TaskLoading(tasks: state.tasks));
    final formattedTime = time.to12HourFormat();
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
            time: formattedTime,
            repeat: repeat ?? false,
          ),
        ],
      ),
    );
  }

  taskToggle(String id, BuildContext context) {
    late TaskModel updatedTask;
    final newList = state.tasks!.map((task) {
      if (id == task.id) {
        updatedTask = task.copyWith(isCompleted: !task.isCompleted);
        return updatedTask;
      }
      return task;
    }).toList();
    if (updatedTask.isCompleted) {
      AwesomeNotifications().cancel(id.hashCode);
    } else {
      creatNotification(taskId: id, context: context);
    }
    emit(TaskUpdate(tasks: newList));
  }

  taskRemove(String id) async {
    emit(TaskLoading(tasks: state.tasks));
    await Future.delayed(const Duration(milliseconds: 300));
    final List<TaskModel> newList = state.tasks!
        .where((task) => task.id != id)
        .toList();
    AwesomeNotifications().cancel(id.hashCode);
    emit(TaskUpdate(tasks: newList));
  }

  taskEdit({
    required String taskId,
    String? title,
    String? category,
    String? time,
    String? date,
    bool? repeat,
  }) {
    final List<TaskModel> newList = state.tasks!.map((task) {
      return (task.id == taskId)
          ? task.copyWith(
              title: title ?? task.title,
              category: category ?? task.category,
              time: time ?? task.time,
              date: date ?? task.date,
              repeat: repeat,
            )
          : task;
    }).toList();
    emit(TaskUpdate(tasks: newList));
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
