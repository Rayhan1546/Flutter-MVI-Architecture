import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/argument/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/splash_page/argument/splash_argument.dart';
import 'package:github_repo_list/presentation/feature/splash_page/state/splash_state.dart';
import 'package:github_repo_list/presentation/navigation/route_path.dart';

class SplashScreenViewModel extends BaseViewModel<SplashArgument, SplashState> {
  SplashScreenViewModel() : super(SplashState.inital());

  @override
  void onViewReady({SplashArgument? argument}) {
    super.onViewReady(argument: argument);
    Future.microtask(() {
      _navigateToLoginScreen();
    });
  }

  void _navigateToLoginScreen() {
    navigateTo(
      routePath: RoutePaths.login,
      arguments: LoginArgument(),
      isClearBackStack: true,
    );
  }
}
