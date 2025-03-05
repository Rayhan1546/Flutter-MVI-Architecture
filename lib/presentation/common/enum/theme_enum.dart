import 'package:flutter/material.dart';

enum ThemeEnum {
  dark,
  light,
  system;

  String get getString {
    switch (this) {
      case ThemeEnum.dark:
        return 'Dark';
      case ThemeEnum.light:
        return 'Light';
      case ThemeEnum.system:
        return 'System';
    }
  }

  ThemeMode get getTheme {
    switch (this) {
      case ThemeEnum.dark:
        return ThemeMode.dark;
      case ThemeEnum.light:
        return ThemeMode.light;
      case ThemeEnum.system:
        return ThemeMode.system;
    }
  }

  static ThemeEnum fromString(String themeString) {
    final lowerCaseTheme = themeString.toLowerCase();

    return ThemeEnum.values.firstWhere(
      (theme) => theme.name.toLowerCase() == lowerCaseTheme,
      orElse: () => ThemeEnum.system,
    );
  }
}
