import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/context_ext.dart';
import 'package:github_repo_list/presentation/common/extension/sume_builder.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/feature/login_page/view_model/login_intend.dart';
import 'package:github_repo_list/presentation/feature/login_page/view_model/login_states.dart';
import 'package:github_repo_list/presentation/feature/login_page/view_model/login_view_model.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getViewModel<LoginViewModel>();

    return SumeBuilder<LoginViewModel, LoginStates>(
      buildWhen: (p, n) => p.showButton != n.showButton,
      builder: (context, state) {
        return PrimaryButton(
          label: "LOG IN",
          onPressed: () => viewModel.dispatchIntent(const LoginButtonIntent()),
          minWidth: double.infinity,
          isDisabled: !state.showButton,
        );
      },
    );
  }
}
