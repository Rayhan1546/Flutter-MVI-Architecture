import 'package:github_repo_list/presentation/feature/change_password_page/change_password_ui.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_ui.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_ui.dart';
import 'package:go_router/go_router.dart';

class NavigationRoutes {
  static GoRouter getRouteConfig() {
    return GoRouter(
      initialLocation: LoginUi.routeName,
      routes: [
        GoRoute(
          path: LoginUi.routeName,
          builder: (context, state) => const LoginUi(),
        ),
        GoRoute(
          path: GithubRepoUi.routeName,
          builder: (context, state) => const GithubRepoUi(),
        ),
        GoRoute(
          path: ChangePasswordUi.routeName,
          builder: (context, state) => const ChangePasswordUi(),
        ),
      ],
    );
  }
}
