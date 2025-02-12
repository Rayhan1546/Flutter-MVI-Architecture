import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_ui.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/route/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_ui.dart';
import 'package:go_router/go_router.dart';

abstract class RoutePaths {
  static const String login = '/login';
  static const String githubRepoPage = '/githubRepoPage';
}

final GoRouter routerConfig = GoRouter(
  initialLocation: RoutePaths.login,
  routes: [
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginUi(),
    ),
    GoRoute(
      path: RoutePaths.githubRepoPage,
      builder: (context, state) {
        final githubRepoParams = state.extra as GithubRepoArgument;
        return GithubRepoUi(
          githubRepoParams: githubRepoParams,
        );
      },
    ),
  ],
);
