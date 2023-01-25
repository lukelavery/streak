import 'package:shared_preferences/shared_preferences.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/user/models/theme_model.dart';

class UserSimplePreferenes {
  static late SharedPreferences _preferences;

  static const _keyDarkMode = 'darkMode';
  static const _keyColor = 'color';
  static const _habitOrder = 'habitOrder';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTheme(ThemeModel theme) async {
    await _preferences.setBool(_keyDarkMode, theme.darkMode);
    await _preferences.setInt(_keyColor, theme.primaryColor.value);
  }

  static ThemeModel? getTheme() {
    bool? darkMode = _preferences.getBool(_keyDarkMode);
    int? color = _preferences.getInt(_keyColor);

    if ((darkMode != null) & (color != null)) {
      return ThemeModel.fromPrimatives(darkMode!, color!);
    }
    return null;
  }

  static Future saveHabitOrder(List<HabitModel> habits) async {
    await _preferences.setStringList(
        _habitOrder, habits.map((e) => e.id).toList());
  }

  static Map<String, int>? getHabitOrder() {
    final savedList = _preferences.getStringList(_habitOrder);
    if (savedList != null) {
      return {for (var i = 0; i < savedList.length; i++) savedList[i]: i};
    }
    return null;
  }
}
