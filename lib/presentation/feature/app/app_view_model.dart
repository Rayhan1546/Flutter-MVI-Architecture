import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/feature/app/app_states.dart';

class AppViewModel {
  final _appConfig = ValueNotifier<AppStates>(AppStates.initial());

  ValueListenable<AppStates> get appConfig => _appConfig;

  AppStates get _states => _appConfig.value;

  void onViewReady() {}

  void setDarkMode() => _states.setDarkMode();

  void setLightMode() => _states.setLightMode();

  void setSystemTheme() => _states.setSystemTheme();

  void onDispose() {
    _appConfig.dispose();
  }
}
