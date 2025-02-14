import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_view_model.dart';

class LoginButton extends StatelessWidget {
  final LoginViewModel viewModel;

  const LoginButton({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return viewModel.loginStates.buildFor(
      select: (state) => state.showButton,
      builder: (context, state) {
        return PrimaryButton(
          label: "LOG IN",
          onPressed: () => viewModel.onTapLoginButton(),
          minWidth: double.infinity,
          isDisabled: !state.showButton,
        );
      },
    );
  }
}
