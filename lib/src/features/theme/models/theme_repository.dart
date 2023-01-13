import 'package:shared_preferences/shared_preferences.dart';
import 'package:streak/src/features/theme/theme.dart';

class UserSimplePreferenes {
  static late SharedPreferences _preferences;

  static const _keyDarkMode = 'darkMode';
  static const _keyColor = 'color';

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
}
