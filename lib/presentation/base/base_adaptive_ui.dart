import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_argument.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/navigation/app_router.dart';

abstract class BaseAdaptiveUI<T extends StatefulWidget> extends State<T> {
  BaseViewModel viewModel();

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }

  void _initializeDependencies() {
    _setupListener();
  }


  void _setupListener() {
    viewModel().baseState.addListener(
      () {
        final baseState = viewModel().baseState.value;
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
    required BaseArgument arguments,
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
    viewModel().onDispose();
    super.dispose();
  }
}
