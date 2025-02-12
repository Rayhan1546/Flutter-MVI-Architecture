import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_arguments.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/navigation/app_router.dart';

abstract class BaseUI<T extends StatefulWidget> extends State<T> {
  BaseViewModel getViewModel();

  @override
  void initState() {
    super.initState();
    _setupListener();
  }

  void _setupListener() {
    getViewModel().baseState.addListener(
      () {
        final baseState = getViewModel().baseState.value;
        if (!mounted) {
          return;
        }
        if (baseState is NavigateState) {
          _navigateTo(
            routePath: baseState.routePath,
            arguments: baseState.arguments,
            isReplace: baseState.isReplace,
            isClearBackStack: baseState.isClearBackStack,
          );
        }
      },
    );
  }

  void _navigateTo({
    required String routePath,
    required BaseArguments arguments,
    required bool isReplace,
    required bool isClearBackStack,
  }) async {
    if (isReplace) {
      await AppRouter.replaceTo(
        context: context,
        routePath: routePath,
        arguments: arguments,
      );
    } else if (isClearBackStack) {
      await AppRouter.clearStackAndGo(
        context: context,
        routePath: routePath,
        arguments: arguments,
      );
    } else {
      await AppRouter.navigateTo(
        context: context,
        routePath: routePath,
        arguments: arguments,
      );
    }
  }

  @override
  void dispose() {
    getViewModel().onDispose();
    super.dispose();
  }
}
