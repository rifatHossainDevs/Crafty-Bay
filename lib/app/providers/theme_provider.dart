import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  final String _themeKey = "themeMode";

  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get currentTheme => _currentTheme;

  List<ThemeMode> get themeModes =>
      [
        ThemeMode.system,
        ThemeMode.light,
        ThemeMode.dark
      ];

  void changeThemeMode(ThemeMode theme) {
    _currentTheme = theme;
    _saveCurrentThemeMode(theme);
    notifyListeners();
  }


  Future<void> init() async {
    await _setCurrentThemeMode();
  }

  Future<void> _saveCurrentThemeMode(ThemeMode theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_themeKey, theme.name);
  }

  Future<void> _setCurrentThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? themeMode = sharedPreferences.getString(_themeKey);

    if (themeMode != null) {
      _currentTheme = _getThemeMode(themeMode);
    }
  }

  ThemeMode _getThemeMode(String? themeMode) {
    switch (themeMode) {
      case "dark":
        return ThemeMode.dark;
      case "light":
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
