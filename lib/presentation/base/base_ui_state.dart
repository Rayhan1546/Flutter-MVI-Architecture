import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/navigation/app_router.dart';
import 'package:github_repo_list/presentation/navigation/route_params.dart';

abstract class BaseUIState<T extends StatefulWidget> extends State<T> {
  BaseViewModel getViewModel();

  @override
  void initState() {
    super.initState();
    _setupNavigationListener();
  }

  void _setupNavigationListener() {
    getViewModel().baseState.addListener(
      () {
        final baseState = getViewModel().baseState.value;
        if (!mounted) {
          return;
        }
        if (baseState is NavigateState) {
          _navigateTo(
            routePath: baseState.routePath,
            routeParams: baseState.routeParams,
            isReplace: baseState.isReplace,
            isClearBackStack: baseState.isClearBackStack,
          );
        }
      },
    );
  }

  void _navigateTo({
    required String routePath,
    required RouteParams routeParams,
    required bool isReplace,
    required bool isClearBackStack,
  }) async {
    if (isReplace) {
      await AppRouter.replaceTo(
        context: context,
        routeName: routePath,
        routeParams: routeParams,
      );
    } else if (isClearBackStack) {
      await AppRouter.clearStackAndGo(
        context: context,
        routeName: routePath,
        routeParams: routeParams,
      );
    } else {
      await AppRouter.navigateTo(
        context: context,
        routeName: routePath,
        routeParams: routeParams,
      );
    }
  }

  @override
  void dispose() {
    getViewModel().onDispose();
    super.dispose();
  }
}
