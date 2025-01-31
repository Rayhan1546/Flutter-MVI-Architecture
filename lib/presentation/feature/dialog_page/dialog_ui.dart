import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/feature/dialog_page/dialog_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_ui.dart';
import 'package:github_repo_list/state_handler/builder_extension.dart';

class DialogUi extends StatefulWidget {
  const DialogUi({super.key});

  @override
  State<DialogUi> createState() => _DialogUiState();
}

class _DialogUiState extends State<DialogUi> {
  final viewModel = DialogViewModel();

  @override
  void dispose() {
    viewModel.onDispose();
    super.dispose();
  }

  void _navigate(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginUi(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return viewModel.dialogStates.build(
      buildWhen: (prev, now) {
        return prev.showShimmer != now.showShimmer ||
            prev.shouldNavigate != now.shouldNavigate;
      },
      builder: (context, states, _) {
        if (states.showShimmer) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (states.shouldNavigate) {
          _navigate(context);
        }

        return Center(
          child: PrimaryButton(
            label: 'Navigate',
            onPressed: () => viewModel.navigate(),
          ),
        );
      },
    );
  }
}
