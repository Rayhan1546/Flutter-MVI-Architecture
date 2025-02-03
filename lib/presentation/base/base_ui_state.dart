import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/mixin/navigation_mixin.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/common/enum/navigation_type.dart';

abstract class BaseUIState<T extends StatefulWidget> extends State<T> with NavigationMixin {
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
        if (baseState is NavigationState) {
          _navigate(baseState);
        }
      },
    );
  }

  void _navigate(NavigationState navigationState) {
    if (navigationState.navigationType != NavigationType.none) {
      navigateTo(
        context,
        navigationState.routePage,
        navigationType: navigationState.navigationType,
      );
    }
  }

  @override
  void dispose() {
    getViewModel().onDispose();
    super.dispose();
  }
}
