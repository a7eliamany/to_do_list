import 'package:todo_list/Model/task_model.dart';

abstract class TaskState {
  final List<TaskModel> tasks;
  TaskState({required this.tasks});
}

class TaskUpdate extends TaskState {
  TaskUpdate({required super.tasks});
}
