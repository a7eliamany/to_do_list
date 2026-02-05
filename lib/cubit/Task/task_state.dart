import 'package:todo_list/Model/task_model.dart';

abstract class TaskState {
  final List<TaskModel>? tasks;
  TaskState({this.tasks});
}

class TaskLoading extends TaskState {
  TaskLoading({super.tasks});
}

class TaskUpdate extends TaskState {
  TaskUpdate({required super.tasks});
}
