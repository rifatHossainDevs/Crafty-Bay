import 'package:flutter/material.dart';

class Utils {
  static String getLanguage(Locale locale) {
    switch (locale.languageCode) {
      case "en":
        return "English";
      case "bn":
        return "বাংলা";
      case "de":
        return "Deutsch";
      case "es":
        return "Español";
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  static IconData getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_suggest;
    }
  }
}
