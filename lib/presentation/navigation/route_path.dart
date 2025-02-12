import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_ui.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/route/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_ui.dart';
import 'package:github_repo_list/presentation/feature/login_page/route/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/splash_screen/route/splash_screen_argument.dart';
import 'package:github_repo_list/presentation/feature/splash_screen/splash_screen_ui.dart';
import 'package:go_router/go_router.dart';

abstract class RoutePaths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String githubRepoPage = '/githubRepoPage';
}

final GoRouter routerConfig = GoRouter(
  initialLocation: RoutePaths.splash,
  routes: [
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) {
        return SplashScreenUi(argument: SplashScreenArgument());
      },
    ),
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) {
        final arguments = state.extra as LoginArguments;
        return LoginUi(arguments: arguments);
      },
    ),
    GoRoute(
      path: RoutePaths.githubRepoPage,
      builder: (context, state) {
        final arguments = state.extra as GithubRepoArgument;
        return GithubRepoUi(githubRepoParams: arguments);
      },
    ),
  ],
);
