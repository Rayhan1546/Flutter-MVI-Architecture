import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_arguments.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static Future<void> navigateTo<T extends BaseArguments>({
    required BuildContext context,
    required String routePath,
    required BaseArguments arguments,
  }) async {
    if (context.mounted) {
      context.push(
        routePath,
        extra: arguments,
      );
    }
  }

  static Future<void> replaceTo<T extends BaseArguments>({
    required BuildContext context,
    required String routePath,
    required BaseArguments arguments,
  }) async {
    if (context.mounted) {
      return context.replace(
        routePath,
        extra: arguments,
      );
    }
  }

  static Future<void> clearStackAndGo<T extends BaseArguments>({
    required BuildContext context,
    required String routePath,
    required BaseArguments arguments,
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
