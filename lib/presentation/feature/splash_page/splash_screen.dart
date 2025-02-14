import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_ui.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/splash_page/argument/splash_argument.dart';
import 'package:github_repo_list/presentation/feature/splash_page/splash_screen_view_model.dart';

class SplashScreen extends StatefulWidget {
  final SplashArgument? argument;

  const SplashScreen({
    super.key,
    this.argument,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseAdaptiveUI<SplashScreen> {
  final _viewModel = SplashScreenViewModel();

  @override
  BaseViewModel viewModel() => _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel.onViewReady(argument: widget.argument);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
