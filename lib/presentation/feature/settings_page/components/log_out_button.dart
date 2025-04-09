import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/feature/settings_page/view_model/settings_view_model.dart';
import 'package:reeve_state/reeve/reeve_context_extension.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getReeve<SettingsViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: PrimaryButton(
        label: 'Logout',
        onPressed: () => viewModel.logout(),
        minWidth: double.infinity,
        leadingIcon: Icons.logout,
      ),
    );
  }
}
