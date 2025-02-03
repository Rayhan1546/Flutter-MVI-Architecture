import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/navigation/route_params.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static Future<void> navigateTo<T extends RouteParams>({
    required BuildContext context,
    required String routeName,
    required T routeParams,
  }) async {
    if (context.mounted) {
      context.push(
        routeName,
        extra: routeParams,
      );
    }
  }

  static Future<void> replaceTo<T extends RouteParams>({
    required BuildContext context,
    required String routeName,
    required T routeParams,
  }) async {
    if (context.mounted) {
      return context.replace(
        routeName,
        extra: routeParams,
      );
    }
  }

  static Future<void> clearStackAndGo<T extends RouteParams>({
    required BuildContext context,
    required String routeName,
    required T routeParams,
  }) async {
    if (context.mounted) {
      return context.goNamed(
        routeName,
        extra: routeParams,
      );
    }
  }

  static void pop(BuildContext context) {
    if (context.mounted && context.canPop()) {
      context.pop();
    }
  }
}
