import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/dialog_page/dialog_view_model.dart';
import 'package:github_repo_list/utils/Builder_extension.dart';

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

  @override
  Widget build(BuildContext context) {
    return viewModel.dialogStates.buildFor(
      select: (states) => states.showShimmer,
      builder: (context, states, _) {
        return Scaffold(
          body: Center(
            child: states.showShimmer
                ? const CircularProgressIndicator()
                : const Text('Hello'),
          ),
        );
      },
    );
  }
}
