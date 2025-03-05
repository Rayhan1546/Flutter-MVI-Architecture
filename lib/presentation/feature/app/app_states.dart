import 'package:github_repo_list/presentation/common/enum/theme_enum.dart';

class AppStates {
  final ThemeEnum theme;

  AppStates({required this.theme});

  factory AppStates.initial() {
    return AppStates(theme: ThemeEnum.system);
  }

  AppStates copyWith({
    ThemeEnum? theme,
  }) {
    return AppStates(
      theme: theme ?? this.theme,
    );
  }

  AppStates setDarkMode() => copyWith(theme: ThemeEnum.dark);

  AppStates setLightMode() => copyWith(theme: ThemeEnum.light);

  AppStates setSystemTheme() => copyWith(theme: ThemeEnum.system);
}
