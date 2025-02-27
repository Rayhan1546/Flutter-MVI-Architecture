import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/common/extension/context_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_text_field.dart';
import 'package:github_repo_list/presentation/feature/login_page/view_model/login_intend.dart';
import 'package:github_repo_list/presentation/feature/login_page/view_model/login_view_model.dart';

class LoginEmailField extends StatefulWidget {
  const LoginEmailField({super.key});

  @override
  State<LoginEmailField> createState() => _LoginEmailFieldState();
}

class _LoginEmailFieldState extends State<LoginEmailField> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getViewModel<LoginViewModel>();

    return viewModel.stateListener.buildFor(
      select: (state) => state.emailError,
      builder: (context, state) {
        return CustomTextField(
          controller: _emailController,
          textFieldName: 'Email',
          textFieldType: TextFieldType.email,
          errorText: state.emailError.getError(),
          onChanged: (email) {
            viewModel.dispatchIntent(LoginEmailIntent(email: email));
          },
        );
      },
    );
  }
}
