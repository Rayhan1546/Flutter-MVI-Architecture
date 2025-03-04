import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/config/theme/dark_theme.dart';
import 'package:github_repo_list/presentation/config/theme/light_theme.dart';

class AppTheme {
  static ThemeData lightTheme() => LightTheme.themeData();
  static ThemeData darkTheme() => DarkTheme.themeData();
}
