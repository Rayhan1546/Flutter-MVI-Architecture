import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_ui.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/splash_screen/route/splash_screen_argument.dart';
import 'package:github_repo_list/presentation/feature/splash_screen/splash_screen_view_model.dart';

class SplashScreenUi extends StatefulWidget {
  final SplashScreenArgument? argument;

  const SplashScreenUi({
    super.key,
    this.argument,
  });

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends BaseUI<SplashScreenUi> {
  final _viewModel = SplashScreenViewModel();

  @override
  BaseViewModel getViewModel() => _viewModel;

  @override
  void addPostFrameCallback() {
    _viewModel.onViewReady(argument: widget.argument);
    super.addPostFrameCallback();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
