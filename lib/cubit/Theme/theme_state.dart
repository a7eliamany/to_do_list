class ThemeState {
  final bool darkMode;
  ThemeState({required this.darkMode});
}

class ThemeInitial extends ThemeState {
  ThemeInitial({required super.darkMode});
}

class ThemeUpdate extends ThemeState {
  ThemeUpdate({required super.darkMode});
}
