import 'package:todo_list/task_model.dart';

class TaskState {
  final List<TaskModel> tasks;
  TaskState({required this.tasks});
}

class TaskUpdate extends TaskState {
  TaskUpdate({required super.tasks});
}
