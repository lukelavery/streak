
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/user/controllers/theme_controller.dart';
import 'package:streak/src/features/user/models/theme_model.dart';

final themeDataController =
    StateNotifierProvider.autoDispose<ThemeDataController, ThemeData?>(
        (ref) => ThemeDataController(ref.watch(themeController)));

class ThemeDataController extends StateNotifier<ThemeData?> {
  ThemeDataController(this.theme) : super(null) {
    if (theme.darkMode) {
      state = ThemeData(
        fontFamily: 'Montserrat',
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
        fontFamily: 'Montserrat',
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