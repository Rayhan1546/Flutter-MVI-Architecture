import 'package:flutter/material.dart';
import 'package:github_repo_list/data/data_sources/local/app_config/login_state_manager.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/argument/login_arguments.dart';
import 'package:github_repo_list/presentation/navigation/routes_config.dart';
import '../argument/settings_argument.dart';
import 'settings_state.dart';
import 'settings_intent.dart';

class SettingsViewModel extends BaseViewModel<SettingsArgument, SettingsState> {
  SettingsViewModel({
    required this.loginStateManager,
  }) : super(SettingsState.initial());

  final LoginStateManager loginStateManager;

  @override
  void onViewReady({SettingsArgument? argument});

  void dispatchIntent(SettingsIntent intent) {
    if (intent is LogOutIntent) {
      _logOut();
    }
  }

  void _logOut() async {
    showConfirmationDialog(
      title: 'Log Out',
      subTitle: 'Are you sure, you want to logout?',
      rightBtnText: 'Proceed',
      leftBtnText: 'Cancel',
      icon: Icons.logout,
      onTapRightBtn: () {
        loginStateManager.clearAllConfiguration();
        navigateTo(
          routePath: RoutePaths.login,
          arguments: LoginArgument(),
          isClearBackStack: true,
        );
      },
      onTapLeftBtn: () {},
    );
  }
}
