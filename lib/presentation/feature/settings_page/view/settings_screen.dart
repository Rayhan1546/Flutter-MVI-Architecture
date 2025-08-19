import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/presentation/common/listener/listener_state.dart';
import 'package:github_repo_list/presentation/feature/settings_page/components/dark_theme_tile.dart';
import 'package:github_repo_list/presentation/feature/settings_page/components/log_out_button.dart';
import 'package:github_repo_list/presentation/feature/settings_page/components/system_theme_tile.dart';
import 'package:reeve_state/reeve/reeve_injecter.dart';

import '../view_model/settings_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingsScreen> {
  late SettingsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = DIModule().get<SettingsViewModel>();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void _handleListenerState(ListenerState? state) {
    if (!mounted) return;

    if (state is EmptyState) {
      return;
    }
    if (state is ToastMessageState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ReeveInjecter<SettingsViewModel>(
        inject: viewModel,
        child: const Column(
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
