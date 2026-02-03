import 'dart:async';

class TaskActionBus {
  TaskActionBus._(); // private constructor
  static final instance = TaskActionBus._();

  final _controller = StreamController<String>.broadcast();

  Stream<String> get stream => _controller.stream;

  void add(String taskId) {
    _controller.add(taskId);
  }

  void dispose() {
    _controller.close();
  }
}
