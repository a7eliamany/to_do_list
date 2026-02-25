import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_list/cubit/Task/task_state.dart';
import 'package:todo_list/global.dart';
import 'package:todo_list/notification/notification_create.dart';
import 'package:todo_list/Model/task_model.dart';
import 'package:todo_list/services/local_storage.dart';

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
          ...state.tasks,
          TaskModel(
            id: id,
            title: title,
            isCompleted: false,
            category: category,
            date: date.toIso8601String(),
            isDeleted: false,
            repeat: repeat ?? false,
          ),
        ],
      ),
    );
  }

  void taskToggle(String id, BuildContext context) {
    late TaskModel updatedTask;
    final newList = state.tasks.map((task) {
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

  void taskRemove(String id) {
    final bool toTrash =
        LocalStorage.instance.getBool(SettingsTitle.moveToTrash) ?? true;
    if (toTrash) {
      final List<TaskModel> newList = state.tasks.map((task) {
        return (task.id == id)
            ? task.copyWith(
                isDeleted: true,
                deletedDate: DateTime.now().toIso8601String(),
              )
            : task;
      }).toList();
      AwesomeNotifications().cancel(id.hashCode);
      emit(TaskUpdate(tasks: newList));
    } else {
      final List<TaskModel> newList = state.tasks
          .where((task) => task.id != id)
          .toList();
      AwesomeNotifications().cancel(id.hashCode);
      emit(TaskUpdate(tasks: newList));
    }
  }

  void taskEdit({
    required String taskId,
    String? title,
    String? category,
    String? date,
    bool? repeat,
  }) {
    final List<TaskModel> newList = state.tasks.map((task) {
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

  void sortTasks() {
    final List<TaskModel> sortedTasks = state.tasks;
    sortedTasks.sort((a, b) {
      DateTime dateTimeA = DateTime.parse(a.date!);
      DateTime dateTimeB = DateTime.parse(b.date!);
      return dateTimeA.compareTo(dateTimeB);
    });
    emit(TaskUpdate(tasks: sortedTasks));
  }

  void removeAll(bool toTrash) {
    if (toTrash) {
      final List<TaskModel> newList = state.tasks
          .map(
            (task) => task.copyWith(
              isDeleted: true,
              deletedDate: DateTime.now().toIso8601String(),
            ),
          )
          .toList();
      AwesomeNotifications().cancelAll();
      emit(TaskUpdate(tasks: newList));
    } else {
      emit(
        TaskUpdate(
          tasks: state.tasks.where((task) => task.isDeleted == false).toList(),
        ),
      );
    }
  }

  void restorAll() {
    final List<TaskModel> newList = state.tasks
        .map((task) => task.copyWith(isDeleted: false))
        .toList();
    AwesomeNotifications().cancelAll();
    emit(TaskUpdate(tasks: newList));
  }

  void restorTask(String id) {
    final List<TaskModel> newList = state.tasks.map((task) {
      return (task.id == id) ? task.copyWith(isDeleted: false) : task;
    }).toList();
    AwesomeNotifications().cancel(id.hashCode);
    emit(TaskUpdate(tasks: newList));
  }

  List<TaskModel> getDeletedTasks() {
    final List<TaskModel> deletedTasks = state.tasks.where((task) {
      DateTime taskDeletedDate = DateTime.parse(task.date!);
      return task.isDeleted == true &&
          taskDeletedDate.add(Duration(days: 60)).isAfter(DateTime.now());
    }).toList();
    return deletedTasks;
  }

  List<TaskModel> getValidTasks([List<TaskModel>? tasks]) {
    if (tasks != null) {
      return tasks.where((task) => task.isDeleted == false).toList();
    } else {
      final List<TaskModel> validTasks = state.tasks
          .where((task) => task.isDeleted == false)
          .toList();

      return validTasks;
    }
  }

  TaskModel getTaskById(String id) {
    return state.tasks.firstWhere((task) => task.id == id);
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
    return {'todolist': state.tasks.map((task) => task.tojson()).toList()};
  }
}
