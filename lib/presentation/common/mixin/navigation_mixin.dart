import 'package:flutter/material.dart';
import 'package:github_repo_list/state_handler/navigation_type.dart';
import 'package:go_router/go_router.dart';

mixin NavigationMixin {
  void navigateTo(
    BuildContext context,
    String routePage, {
    NavigationType navigationType = NavigationType.push,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        switch (navigationType) {
          case NavigationType.replace:
            GoRouter.of(context).pushReplacement(routePage);
          case NavigationType.push:
            GoRouter.of(context).push(routePage);
          case NavigationType.none:
            throw UnimplementedError();
        }
      },
    );
  }
}
