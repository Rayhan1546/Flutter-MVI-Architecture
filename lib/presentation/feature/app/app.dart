import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/presentation/base/base_provider.dart';
import 'package:github_repo_list/presentation/config/theme/app_theme.dart';
import 'package:github_repo_list/presentation/feature/app/app_view_model.dart';
import 'package:github_repo_list/presentation/navigation/routes_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppViewModel _viewModel;
  final diModule = DIModule();

  @override
  void initState() {
    _viewModel = diModule.get<AppViewModel>();
    _viewModel.onViewReady();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseProvider(
      viewModel: _viewModel,
      builder: (context, _) {
        return ValueListenableBuilder(
          valueListenable: _viewModel.systemConfig,
          builder: (context, config, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              themeMode: config.theme.getTheme,
              routerConfig: routerConfig,
            );
          },
        );
      },
    );
  }
}
