import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/Custom/EditCustomButtomSheet.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:todo_list/cubit/Task/task_state.dart';
import 'package:todo_list/Model/task_model.dart';
import 'package:uuid/uuid.dart';

class FlutterSlidable extends StatelessWidget {
  final String taskId;
  final int index;
  final Widget child;
  const FlutterSlidable({
    super.key,
    required this.child,
    required this.index,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context) {
    Uuid uuid = Uuid();
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(uuid.v4()),
      // The start action pane is the one at the left or the top side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: ScrollMotion(),
        // All actions are defined in the children parameter.
        children: [
          BlocBuilder<TaskCupit, TaskState>(
            builder: (context, state) {
              return _Edit(index: index, tasks: state.tasks![index]);
            },
          ),
          _Delete(taskId: taskId),
        ],
      ),
      startActionPane: ActionPane(
        dragDismissible: true,
        dismissible: DismissiblePane(
          onDismissed: () {
            context.read<TaskCupit>().taskToggle(taskId, context);
          },
        ),
        motion: ScrollMotion(),
        children: [_Toggle(taskId: taskId)],
      ),
      child: child,
    );
  }
}

class _Edit extends StatelessWidget {
  final TaskModel tasks;
  final int index;
  const _Edit({required this.tasks, required this.index});

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
      flex: 2,
      onPressed: (BuildContext context) {
        showModalBottomSheet(
          isScrollControlled: true,
          showDragHandle: true,
          useSafeArea: true,
          context: context,
          builder: (context) => Scaffold(
            resizeToAvoidBottomInset: true,
            body: EditCustomButtomSheet(taskId: tasks.id),
          ),
        );
      },
      backgroundColor: Color(0xFF21B7CA),
      foregroundColor: Colors.white,
      icon: Icons.edit,
      label: 'Edit',
    );
  }
}

class _Delete extends StatelessWidget {
  final String taskId;
  const _Delete({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
      onPressed: (BuildContext context) {
        context.read<TaskCupit>().taskRemove(taskId);
      },
      backgroundColor: Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Delete',
    );
  }
}

class _Toggle extends StatelessWidget {
  final String taskId;
  const _Toggle({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
      onPressed: (BuildContext context) {
        context.read<TaskCupit>().taskToggle(taskId, context);
      },
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      icon: Icons.check,
      label: 'Toggle',
    );
  }
}
