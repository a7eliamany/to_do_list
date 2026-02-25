import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/views/EditTaskPage/edit_custom_buttom_sheet.dart';
import 'package:todo_list/cubit/Task/task_cupit.dart';
import 'package:uuid/uuid.dart';

class FlutterSlidable extends StatelessWidget {
  final String taskId;
  final bool isDeleted;
  final Widget child;
  const FlutterSlidable({
    super.key,
    required this.child,
    required this.taskId,
    required this.isDeleted,
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
        dismissible: DismissiblePane(
          onDismissed: () {
            context.read<TaskCupit>().taskRemove(taskId);
          },
        ),
        dragDismissible: true,
        // All actions are defined in the children parameter.
        children: [
          _Edit(taskId: taskId),
          _Delete(taskId: taskId),
        ],
      ),
      startActionPane: ActionPane(
        dragDismissible: true,
        dismissible: DismissiblePane(
          onDismissed: () {
            (isDeleted)
                ? context.read<TaskCupit>().restorTask(taskId)
                : context.read<TaskCupit>().taskToggle(taskId, context);
          },
        ),
        motion: ScrollMotion(),
        children: [
          (isDeleted) ? _Restore(taskId: taskId) : _Toggle(taskId: taskId),
        ],
      ),
      child: child,
    );
  }
}

class _Edit extends StatelessWidget {
  final String taskId;
  const _Edit({required this.taskId});

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
            body: EditCustomButtomSheet(taskId: taskId),
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

class _Restore extends StatelessWidget {
  final String taskId;
  const _Restore({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
      onPressed: (BuildContext context) {
        context.read<TaskCupit>().restorTask(taskId);
      },
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      icon: Icons.restore,
      label: 'Restore',
    );
  }
}
