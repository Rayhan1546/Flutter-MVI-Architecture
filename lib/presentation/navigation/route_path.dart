import 'package:github_repo_list/presentation/feature/change_password_page/change_password_ui.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_ui.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_ui.dart';
import 'package:go_router/go_router.dart';

abstract class RouteNames {
  static const String login = 'login';
  static const String changePassword = 'changePassword';
  static const String githubRepoPage = 'githubRepoPage';
}

abstract class RoutePaths {
  static const String login = '/login';
  static const String changePassword = '/changePassword';
  static const String githubRepoPage = '/githubRepoPage';
}

final GoRouter routerConfig = GoRouter(
  initialLocation: RoutePaths.login,
  routes: [
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      builder: (context, state) => const LoginUi(),
    ),
    GoRoute(
      path: RoutePaths.changePassword,
      name: RouteNames.changePassword,
      builder: (context, state) => const ChangePasswordUi(),
    ),
    GoRoute(
      path: RoutePaths.githubRepoPage,
      name: RouteNames.githubRepoPage,
      builder: (context, state) => const GithubRepoUi(),
    ),
  ],
);
