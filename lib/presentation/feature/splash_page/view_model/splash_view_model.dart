import 'package:github_repo_list/data/data_sources/local/app_config/login_state_manager.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/splash_page/view_model/splash_state.dart';
import 'package:github_repo_list/presentation/navigation/routes_config.dart';

class SplashViewModel extends BaseViewModel<SplashState> {
  final LoginStateManager loginStateManager;

  SplashViewModel({
    required this.loginStateManager,
  }) : super(SplashState.inital());

  @override
  void onViewReady() {
    super.onViewReady();
    _getLoginState();
  }

  void _getLoginState() async {
    bool? state = await loginStateManager.getValue();

    if (state == null || !state) {
      navigateTo(
        routePath: RoutePaths.login,
        isClearBackStack: true,
      );
      return;
    }

    // navigateTo(
    //   routePath: RoutePaths.githubRepoPage,
    //   arguments: GithubRepoArgument(email: 'h@gmail.com', password: '123455'),
    //   isClearBackStack: true,
    // );
    navigateTo(routePath: RoutePaths.settings, isClearBackStack: true);
  }
}
