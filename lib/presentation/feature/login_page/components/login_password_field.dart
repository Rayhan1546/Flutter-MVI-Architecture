import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_provider.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_text_field.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_view_model.dart';

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
    final viewModel = BaseProvider.of<LoginViewModel>(context);

    return viewModel.stateListener.buildFor(
      select: (state) => state.errorStates.passwordErrorText,
      builder: (context, state) {
        return CustomTextField(
          controller: _passwordController,
          textFieldName: 'Password',
          errorText: state.errorStates.passwordErrorText?.getError(),
          textFieldType: TextFieldType.password,
          onChanged: (password) {
            viewModel.onChangedPassword(password: password);
          },
        );
      },
    );
  }
}
