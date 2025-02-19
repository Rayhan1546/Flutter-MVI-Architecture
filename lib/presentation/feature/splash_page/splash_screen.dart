import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_screen.dart';
import 'package:github_repo_list/presentation/feature/splash_page/argument/splash_argument.dart';
import 'package:github_repo_list/presentation/feature/splash_page/splash_screen_view_model.dart';

class SplashScreen
    extends BaseAdaptiveScreen<SplashScreenViewModel, SplashArgument> {
  const SplashScreen({super.key, required super.arguments});

  @override
  Widget buildView(BuildContext context) {
    return const Scaffold();
  }
}
