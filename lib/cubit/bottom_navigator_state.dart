part of 'bottom_navigator_cubit.dart';

sealed class BottomNavigatorState {
  final int index;

  const BottomNavigatorState({required this.index});
}

final class BottomNavigatorInitial extends BottomNavigatorState {
  const BottomNavigatorInitial({required super.index});
}

final class BottomNavigatorChange extends BottomNavigatorState {
  const BottomNavigatorChange({required super.index});
}
