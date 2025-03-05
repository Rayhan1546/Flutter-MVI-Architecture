import 'package:flutter/material.dart';

class AppStates {
  final ThemeMode themeMode;

  AppStates({required this.themeMode});

  factory AppStates.initial() {
    return AppStates(themeMode: ThemeMode.system);
  }

  AppStates copyWith({
    ThemeMode? themeMode,
  }) {
    return AppStates(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  void setDarkMode() => copyWith(themeMode: ThemeMode.dark);

  void setLightMode() => copyWith(themeMode: ThemeMode.light);

  void setSystemTheme() => copyWith(themeMode: ThemeMode.system);
}
