import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/feature/count_page/view_model/count_view_model.dart';
import 'package:reeve_state/reeve/reeve_context_extension.dart';

class CountNavButton extends StatelessWidget {
  const CountNavButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getReeve<CountViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: PrimaryButton(
        minWidth: double.infinity,
        label: 'Go',
        onPressed: () => viewModel.onTapCountNavButton(),
      ),
    );
  }
}
