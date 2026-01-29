import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';
import 'package:todo_list/TaskCupit/task_state.dart';
import 'package:todo_list/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskCupit extends HydratedCubit<TaskState> {
  TaskCupit() : super(TaskUpdate(tasks: []));

  addtask({
    required TimeOfDay time,
    required String title,
    required String category,
    required DateTime date,
  }) {
    Uuid uuid = Uuid();

    final formattedTime = time.to12HourFormat();

    emit(
      TaskUpdate(
        tasks: [
          ...state.tasks,
          TaskModel(
            id: uuid.v4(),
            title: title,
            isCompleted: false,
            category: category,
            date: date.toIso8601String(),
            time: formattedTime,
          ),
        ],
      ),
    );
  }

  taskToggle(String id) {
    final newList = state.tasks.map((task) {
      return id == task.id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();
    emit(TaskUpdate(tasks: newList));
  }

  taskRemove(String id) {
    final List<TaskModel> newList = state.tasks
        .where((task) => task.id != id)
        .toList();
    emit(TaskUpdate(tasks: newList));
  }

  taskEdit({
    required String taskId,
    String? title,
    String? category,
    String? time,
    String? date,
  }) {
    final List<TaskModel> newList = state.tasks.map((task) {
      return (task.id == taskId)
          ? task.copyWith(
              title: title ?? task.title,
              category: category ?? task.category,
              time: time ?? task.time,
              date: date ?? task.date,
            )
          : task;
    }).toList();
    emit(TaskUpdate(tasks: newList));
  }

  taskChangeCategory({required String taskId, required String category}) {
    final List<TaskModel> newlist = state.tasks.map((task) {
      return task.id == taskId ? task.copyWith(category: category) : task;
    }).toList();
    emit(TaskUpdate(tasks: newlist));
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
