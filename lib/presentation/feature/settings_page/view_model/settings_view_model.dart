import 'package:github_repo_list/data/data_sources/local/app_config/login_state_manager.dart';
import 'package:reeve_state/reeve/reeve.dart';
import 'settings_state.dart';

class SettingsViewModel extends Reeve<SettingsState> {
  SettingsViewModel({
    required this.loginStateManager,
  }) : super(SettingsState.initial());

  final LoginStateManager loginStateManager;

  void onViewReady() {}

  void logout() {

  }

  //
  // void _logOut() async {
  //   showConfirmationDialog(
  //     title: 'Log Out',
  //     subTitle: 'Are you sure, you want to logout?',
  //     rightBtnText: 'Proceed',
  //     leftBtnText: 'Cancel',
  //     icon: Icons.logout,
  //     onTapRightBtn: () {
  //       loginStateManager.clearAllConfiguration();
  //       navigateTo(
  //         routePath: RoutePaths.login,
  //         isClearBackStack: true,
  //       );
  //     },
  //     onTapLeftBtn: () {},
  //   );
  // }
}
