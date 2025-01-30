import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/login_page/login_view_model.dart';
import 'package:github_repo_list/presentation/widgets/custom_text_field.dart';
import 'package:github_repo_list/utils/Builder_extension.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final viewModel = LoginViewModel();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    viewModel.onDispose();
    super.dispose();
  }

  void onTapLogIn() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN IN"),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            _buildEmailField(context),
            const SizedBox(height: 24),
            _buildPasswordField(context),
            const SizedBox(height: 40),
            _buildLogInButton(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return viewModel.loginStates.buildFor(
      select: (state) => state.errorStates.emailErrorText,
      builder: (context, state, _) {
        return CustomTextField(
          controller: _emailController,
          textFieldName: 'Email',
          textFieldType: TextFieldType.email,
          errorText: state.errorStates.emailErrorText?.getError(),
          onChanged: (email) => viewModel.onChangedEmail(email: email),
        );
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return viewModel.loginStates.buildFor(
      select: (state) => state.errorStates.passwordErrorText,
      builder: (context, state, _) {
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

  Widget _buildLogInButton(BuildContext context) {
    return viewModel.loginStates.buildFor(
      select: (state) => state.showButton,
      builder: (context, state, _) {
        return PrimaryButton(
          label: "LOG IN",
          onPressed: () {
            onTapLogIn();
            viewModel.onTapLoginButton();
          },
          minWidth: double.infinity,
          isDisabled: !state.showButton,
        );
      },
    );
  }
}
