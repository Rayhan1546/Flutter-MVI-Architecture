import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_argument.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static Future<void> navigateTo<T extends BaseArgument>({
    required BuildContext context,
    required String routePath,
    required BaseArgument arguments,
  }) async {
    if (context.mounted) {
      context.push(
        routePath,
        extra: arguments,
      );
    }
  }

  static Future<void> replaceTo<T extends BaseArgument>({
    required BuildContext context,
    required String routePath,
    required BaseArgument arguments,
  }) async {
    if (context.mounted) {
      return context.replace(
        routePath,
        extra: arguments,
      );
    }
  }

  static Future<void> clearStackAndGo<T extends BaseArgument>({
    required BuildContext context,
    required String routePath,
    required BaseArgument arguments,
  }) async {
    if (context.mounted) {
      return context.pushReplacement(
        routePath,
        extra: arguments,
      );
    }
  }

  static void pop(BuildContext context) {
    if (context.mounted && context.canPop()) {
      context.pop();
    }
  }
}
