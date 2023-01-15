import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/user_preferences.dart';

class ThemeModel {
  final bool darkMode;
  final Color primaryColor;

  const ThemeModel({required this.darkMode, required this.primaryColor});

  factory ThemeModel.fromPrimatives(bool darkMode, int color) {
    return ThemeModel(darkMode: darkMode, primaryColor: Color(color));
  }
}

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
    theme.darkMode ?     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark):
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

final themeDataController =
    StateNotifierProvider.autoDispose<ThemeDataController, ThemeData?>(
        (ref) => ThemeDataController(ref.watch(themeController)));

class ThemeDataController extends StateNotifier<ThemeData?> {
  ThemeDataController(this.theme) : super(null) {
    if (theme.darkMode) {
      state = ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: theme.primaryColor,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.black,
            onBackground: Colors.white,
            surface: Colors.grey.shade900,
            onSurface: Colors.white),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
      );
    } else {
      state = ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: theme.primaryColor,
            onPrimary: Colors.white,
            secondary: Colors.black,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.grey.shade100,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black),
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade100,
        ),
      );
    }
  }

  final ThemeModel theme;
}
