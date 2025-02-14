import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_text_field.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_view_model.dart';

class LoginEmailField extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginEmailField({super.key, required this.viewModel});

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
    return widget.viewModel.loginStates.buildFor(
      select: (state) => state.errorStates.emailErrorText,
      builder: (context, state) {
        return CustomTextField(
          controller: _emailController,
          textFieldName: 'Email',
          textFieldType: TextFieldType.email,
          errorText: state.errorStates.emailErrorText?.getError(),
          onChanged: (email) => widget.viewModel.onChangedEmail(email: email),
        );
      },
    );
  }
}
