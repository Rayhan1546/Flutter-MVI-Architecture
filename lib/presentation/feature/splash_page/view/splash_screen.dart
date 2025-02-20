import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_screen.dart';
import 'package:github_repo_list/presentation/feature/splash_page/argument/splash_argument.dart';
import 'package:github_repo_list/presentation/feature/splash_page/view_model/splash_view_model.dart';

class SplashScreen extends BaseAdaptiveScreen<SplashViewModel, SplashArgument> {
  const SplashScreen({super.key, required super.arguments});

  @override
  Widget buildView(BuildContext context) {
    return const Scaffold();
  }
}
