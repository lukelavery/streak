import 'package:flutter/material.dart';

class ThemeModel {
  final bool darkMode;
  final Color primaryColor;

  const ThemeModel({required this.darkMode, required this.primaryColor});

  factory ThemeModel.fromPrimatives(bool darkMode, int color) {
    return ThemeModel(darkMode: darkMode, primaryColor: Color(color));
  }
}