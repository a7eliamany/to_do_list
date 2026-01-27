import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigator_state.dart';

class BottomNavigatorCubit extends Cubit<BottomNavigatorState> {
  BottomNavigatorCubit() : super(BottomNavigatorInitial(index: 0));

  changePage(int val) {
    emit(BottomNavigatorChange(index: val));
  }
}
