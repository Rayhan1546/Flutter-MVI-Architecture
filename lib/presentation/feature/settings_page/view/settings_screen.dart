import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/presentation/common/listener/listener_state.dart';
import 'package:github_repo_list/presentation/common/widgets/app_loader.dart';
import 'package:github_repo_list/presentation/feature/settings_page/components/dark_theme_tile.dart';
import 'package:github_repo_list/presentation/feature/settings_page/components/log_out_button.dart';
import 'package:github_repo_list/presentation/feature/settings_page/components/system_theme_tile.dart';
import 'package:github_repo_list/presentation/feature/settings_page/view_model/settings_state.dart';
import 'package:reeve_state/reeve/reeve_builder.dart';
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
    viewModel = DIModule().get<SettingsViewModel>();
    super.initState();
  }

  void _handleListenerState(ListenerState? state) {
    if (!mounted) return;

    if (state is EmptyState) {
      return;
    } else if (state is ToastMessageState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ReeveInjecter<SettingsViewModel>(
        inject: viewModel,
        child: ReeveBuilder<SettingsState, SettingsViewModel>(
          builder: (context, state) {
            return const Column(
              children: [
                SystemThemeTile(),
                DarkThemeTile(),
                SizedBox(height: 100),
                LogOutButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
