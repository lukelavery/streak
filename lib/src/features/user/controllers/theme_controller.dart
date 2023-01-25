import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/user/services/user_preferences.dart';
import 'package:streak/src/features/user/models/theme_model.dart';

final themeController =
    StateNotifierProvider.autoDispose<ThemeController, ThemeModel>(
        (ref) => ThemeController());

class ThemeController extends StateNotifier<ThemeModel> {
  ThemeController()
      : super(const ThemeModel(darkMode: true, primaryColor: Colors.blue)) {
    getTheme();
  }

  final List<MaterialColor> colors = Colors.primaries;

  void getTheme() async {
    ThemeModel? theme = UserSimplePreferenes.getTheme();
    if (theme != null) {
      state = theme;
    }
  }

  void toggleDarkMode() {
    ThemeModel theme =
        ThemeModel(darkMode: !state.darkMode, primaryColor: state.primaryColor);
    state = theme;
    theme.darkMode ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark):
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    UserSimplePreferenes.setTheme(theme);
  }

  void setColor(Color color) async {
    ThemeModel theme =
        ThemeModel(darkMode: state.darkMode, primaryColor: color);
    state = theme;
    UserSimplePreferenes.setTheme(theme);
  }
}
