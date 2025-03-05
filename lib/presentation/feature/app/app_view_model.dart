import 'package:flutter/foundation.dart';
import 'package:github_repo_list/data/data_sources/local/app_config/theme_manager.dart';
import 'package:github_repo_list/presentation/common/enum/theme_enum.dart';
import 'package:github_repo_list/presentation/feature/app/app_states.dart';

class AppViewModel {
  final ThemeManager themeManager;

  AppViewModel({required this.themeManager});

  final _systemConfig = ValueNotifier<AppStates>(AppStates.initial());
  ValueListenable<AppStates> get systemConfig => _systemConfig;
  AppStates get _states => _systemConfig.value;

  void onViewReady() {
    _setInitialTheme();
  }

  void _setInitialTheme() async {
    String? theme = await themeManager.getValue();

    if (theme == null) {
      updateState(_states.copyWith(
        theme: ThemeEnum.system,
      ));
      return;
    }

    updateState(_states.copyWith(
      theme: ThemeEnum.fromString(theme),
    ));
  }

  void updateState(AppStates appStates) {
    _systemConfig.value = appStates;
  }

  void setDarkMode() {
    updateState(_states.setDarkMode());
    themeManager.saveValue(_states.theme.getString);
  }

  void setLightMode() {
    updateState(_states.setLightMode());
    themeManager.saveValue(_states.theme.getString);
  }

  void setSystemTheme() {
    updateState(_states.setSystemTheme());
    themeManager.saveValue(_states.theme.getString);
  }

  bool isSystemThemeEnabled() => _states.theme == ThemeEnum.system;

  void onDispose() {
    _systemConfig.dispose();
  }
}
