import 'package:github_repo_list/data/data_sources/local/app_config/login_state_manager.dart';
import 'package:github_repo_list/data/data_sources/local/shared_preference/pref_token_manager.dart';
import 'package:github_repo_list/domain/entities/login_credentials.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_arguments.dart';
import 'package:github_repo_list/presentation/feature/splash_page/view_model/splash_state.dart';
import 'package:github_repo_list/presentation/navigation/routes_config.dart';

class SplashViewModel extends BaseViewModel<SplashState> {
  final LoginStateManager loginStateManager;
  final PrefTokenManager prefTokenManager;

  SplashViewModel({
    required this.loginStateManager,
    required this.prefTokenManager,
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

    await prefTokenManager.saveToStorage(
      LoginCredentials(
        token: 'jfvnhjfdbvhfjd',
        refreshToken: 'jfhnvjfdhbhjfdb',
        userName: 'Rayhan Mahmud',
      ),
    );

    navigateTo(
      routePath: RoutePaths.githubRepoPage,
      arguments: GithubRepoArguments(email: 'g@gmail.com'),
      isClearBackStack: true,
    );
  }
}
