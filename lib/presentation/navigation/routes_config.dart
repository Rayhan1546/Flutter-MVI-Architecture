import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_arguments.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/view/github_repo_screen.dart';
import 'package:github_repo_list/presentation/feature/login_page/view/login_screen.dart';
import 'package:github_repo_list/presentation/feature/settings_page/view/settings_screen.dart';
import 'package:github_repo_list/presentation/feature/splash_page/view/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:github_repo_list/presentation/feature/count_page/view/count_screen.dart';

part 'routes.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: RoutePaths.splash,
  routes: [
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.githubRepoPage,
      builder: (context, state) {
        final arguments = state.extra;
        if (arguments == null || arguments is! GithubRepoArguments) {
          throw Exception('Invalid Argument');
        }
        return GithubRepoScreen(arguments: arguments);
      },
    ),
    GoRoute(
      path: RoutePaths.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: RoutePaths.count,
      builder: (context, state) => const CountScreen(),
    ),
  ],
);
