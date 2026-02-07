import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_list/cubit/Theme/theme_state.dart';

class ThemeCupit extends HydratedCubit<ThemeState> {
  ThemeCupit() : super(ThemeInitial(darkMode: true));

  themeChange() {
    emit(ThemeUpdate(darkMode: !state.darkMode));
  }

  bool get isDarkmode => state.darkMode;
  @override
  fromJson(Map<String, dynamic> json) {
    return ThemeUpdate(darkMode: json["Theme mode"]);
  }

  @override
  Map<String, dynamic>? toJson(state) {
    return {"Theme mode": state.darkMode};
  }
}
