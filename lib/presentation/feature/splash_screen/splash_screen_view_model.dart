import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/route/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/splash_screen/route/splash_screen_argument.dart';
import 'package:github_repo_list/presentation/navigation/route_path.dart';

class SplashScreenViewModel extends BaseViewModel<SplashScreenArgument> {
  @override
  void onViewReady({SplashScreenArgument? argument}) {
    super.onViewReady(argument: argument);
    Future.microtask(() {
      _navigateToLoginScreen();
    });
  }

  void _navigateToLoginScreen() {
    navigateTo(
      routePath: RoutePaths.login,
      arguments: LoginArguments(),
      isClearBackStack: true,
    );
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
    super.onDispose();
  }
}
