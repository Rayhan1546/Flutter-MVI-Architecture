import 'package:github_repo_list/data/data_sources/local/app_config/login_state_manager.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/login_page/argument/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/settings_page/argument/settings_argument.dart';
import 'package:github_repo_list/presentation/feature/splash_page/argument/splash_argument.dart';
import 'package:github_repo_list/presentation/feature/splash_page/view_model/splash_state.dart';
import 'package:github_repo_list/presentation/navigation/routes_config.dart';

class SplashViewModel extends BaseViewModel<SplashArgument, SplashState> {
  final LoginStateManager loginStateManager;

  SplashViewModel({
    required this.loginStateManager,
  }) : super(SplashState.inital());

  @override
  void onViewReady({SplashArgument? argument}) {
    super.onViewReady(argument: argument);
    _getLoginState();
  }

  void _getLoginState() async {
    bool? state = await loginStateManager.getValue();

    if (state == null || !state) {
      navigateTo(
        routePath: RoutePaths.login,
        arguments: LoginArgument(),
        isClearBackStack: true,
      );
      return;
    }

    // navigateTo(
    //   routePath: RoutePaths.githubRepoPage,
    //   arguments: GithubRepoArgument(email: 'h@gmail.com', password: '123455'),
    //   isClearBackStack: true,
    // );
    navigateTo(
      routePath: RoutePaths.settings,
      arguments: SettingsArgument(),
      isClearBackStack: true,
    );
  }
}
