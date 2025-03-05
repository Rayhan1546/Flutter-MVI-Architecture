import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/context_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/feature/settings_page/view_model/settings_intent.dart';
import 'package:github_repo_list/presentation/feature/settings_page/view_model/settings_view_model.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getViewModel<SettingsViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: PrimaryButton(
        label: 'Logout',
        onPressed: () => viewModel.dispatchIntent(const LogOutIntent()),
        minWidth: double.infinity,
        leadingIcon: Icons.logout,
      ),
    );
  }
}
