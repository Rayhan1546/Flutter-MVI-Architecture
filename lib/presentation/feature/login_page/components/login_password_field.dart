import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/common/extension/context_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_text_field.dart';
import 'package:github_repo_list/presentation/feature/login_page/view_model/login_view_model.dart';

class LoginPasswordField extends StatefulWidget {
  const LoginPasswordField({super.key});

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getViewModel<LoginViewModel>();

    return viewModel.stateListener.buildFor(
      select: (state) => state.passwordError,
      builder: (context, state) {
        return CustomTextField(
          controller: _passwordController,
          textFieldName: 'Password',
          errorText: state.passwordError.getError(),
          textFieldType: TextFieldType.password,
          onChanged: (password) {
            viewModel.onChangedPassword(password: password);
          },
        );
      },
    );
  }
}
