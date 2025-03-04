import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'text_themes.dart';
import 'button_themes.dart';
import 'component_themes.dart';

class LightTheme {
  static ThemeData themeData() {
    final ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      primaryContainer: AppColors.lightPrimaryContainer,
      onPrimaryContainer: Colors.black,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightOnSecondary,
      secondaryContainer: AppColors.lightSecondaryContainer,
      onSecondaryContainer: Colors.black,
      tertiary: Colors.orange,
      onTertiary: Colors.white,
      tertiaryContainer: Colors.orange[100]!,
      onTertiaryContainer: Colors.orange[900]!,
      error: AppColors.lightError,
      onError: AppColors.lightOnError,
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF410002),
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      onSurfaceVariant: Colors.grey[700]!,
      outline: Colors.grey[400]!,
      outlineVariant: Colors.grey[300]!,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Colors.grey[900]!,
      onInverseSurface: Colors.white,
      inversePrimary: Colors.blue[200]!,
      surfaceTint: AppColors.lightPrimary,
    );

    // Return the theme
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.light,

      // Base colors
      scaffoldBackgroundColor: colorScheme.surface,

      // Text theme
      textTheme: AppTextThemes.lightTextTheme(colorScheme),

      // Button themes
      elevatedButtonTheme: AppButtonThemes.elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: AppButtonThemes.outlinedButtonTheme(colorScheme),
      textButtonTheme: AppButtonThemes.textButtonTheme(colorScheme),
      floatingActionButtonTheme:
          AppButtonThemes.floatingActionButtonTheme(colorScheme),

      // Component themes
      appBarTheme: AppComponentThemes.lightAppBarTheme(colorScheme),
      cardTheme: AppComponentThemes.lightCardTheme(),
      inputDecorationTheme: AppComponentThemes.lightInputDecorationTheme(colorScheme),
      checkboxTheme: AppComponentThemes.checkboxTheme(colorScheme, false),
      radioTheme: AppComponentThemes.radioTheme(colorScheme, false),
      switchTheme: AppComponentThemes.switchTheme(colorScheme, false),
      sliderTheme: AppComponentThemes.sliderTheme(colorScheme),
      tabBarTheme: AppComponentThemes.tabBarTheme(colorScheme, false),
      dividerTheme: AppComponentThemes.dividerTheme(false),
      dialogTheme: AppComponentThemes.dialogTheme(colorScheme),
      bottomSheetTheme: AppComponentThemes.bottomSheetTheme(colorScheme),
      snackBarTheme: AppComponentThemes.snackBarTheme(false),
      bottomNavigationBarTheme: AppComponentThemes.bottomNavigationBarTheme(colorScheme, false),
    );
  }
}
