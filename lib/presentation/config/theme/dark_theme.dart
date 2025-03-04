import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'text_themes.dart';
import 'button_themes.dart';
import 'component_themes.dart';

class DarkTheme {
  static ThemeData themeData() {
    final ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      primaryContainer: AppColors.darkPrimaryContainer,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      secondaryContainer: AppColors.darkSecondaryContainer,
      onSecondaryContainer: Colors.white,
      tertiary: Colors.orange[300]!,
      onTertiary: Colors.black,
      tertiaryContainer: Colors.orange[800]!,
      onTertiaryContainer: Colors.orange[50]!,
      error: AppColors.darkError,
      onError: AppColors.darkOnError,
      errorContainer: const Color(0xFF93000A),
      onErrorContainer: const Color(0xFFFFDAD6),
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      onSurfaceVariant: Colors.grey[300]!,
      outline: Colors.grey[500]!,
      outlineVariant: Colors.grey[700]!,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Colors.grey[100]!,
      onInverseSurface: Colors.black,
      inversePrimary: Colors.blue[700]!,
      surfaceTint: AppColors.darkPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,

      scaffoldBackgroundColor: colorScheme.surface,

      // Text theme
      textTheme: AppTextThemes.darkTextTheme(colorScheme),

      // Button themes
      elevatedButtonTheme: AppButtonThemes.elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: AppButtonThemes.outlinedButtonTheme(colorScheme),
      textButtonTheme: AppButtonThemes.textButtonTheme(colorScheme),
      floatingActionButtonTheme: AppButtonThemes.floatingActionButtonTheme(colorScheme),

      // Component themes
      appBarTheme: AppComponentThemes.darkAppBarTheme(colorScheme),
      cardTheme: AppComponentThemes.darkCardTheme(),
      inputDecorationTheme: AppComponentThemes.darkInputDecorationTheme(colorScheme),
      checkboxTheme: AppComponentThemes.checkboxTheme(colorScheme, true),
      radioTheme: AppComponentThemes.radioTheme(colorScheme, true),
      switchTheme: AppComponentThemes.switchTheme(colorScheme, true),
      sliderTheme: AppComponentThemes.sliderTheme(colorScheme),
      tabBarTheme: AppComponentThemes.tabBarTheme(colorScheme, true),
      dividerTheme: AppComponentThemes.dividerTheme(true),
      dialogTheme: AppComponentThemes.dialogTheme(colorScheme),
      bottomSheetTheme: AppComponentThemes.bottomSheetTheme(colorScheme),
      snackBarTheme: AppComponentThemes.snackBarTheme(true),
      bottomNavigationBarTheme: AppComponentThemes.bottomNavigationBarTheme(colorScheme, true),
    );
  }
}
