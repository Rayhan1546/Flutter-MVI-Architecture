import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_screen.dart';
import 'package:github_repo_list/presentation/feature/settings_page/components/dark_theme_tile.dart';
import 'package:github_repo_list/presentation/feature/settings_page/components/log_out_button.dart';
import 'package:github_repo_list/presentation/feature/settings_page/components/system_theme_tile.dart';
import '../argument/settings_argument.dart';
import '../view_model/settings_view_model.dart';

class SettingsScreen
    extends BaseAdaptiveScreen<SettingsViewModel, SettingsArgument> {
  const SettingsScreen({super.key, required super.arguments});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SystemThemeTile(),
            DarkThemeTile(),
            SizedBox(height: 100),
            LogOutButton(),
          ],
        ),
      ),
    );
  }
}
