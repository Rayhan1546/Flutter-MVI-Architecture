import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/config/theme/app_theme.dart';
import 'package:github_repo_list/presentation/navigation/routes_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      routerConfig: routerConfig,
    );
  }
}
