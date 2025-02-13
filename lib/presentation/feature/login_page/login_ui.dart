import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_ui.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_text_field.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_view_model.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/route/login_arguments.dart';

class LoginUi extends StatefulWidget {
  final LoginArguments? arguments;

  const LoginUi({super.key, this.arguments});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends BaseAdaptiveUI<LoginUi> {
  final _viewModel = LoginViewModel();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  BaseViewModel viewModel() => _viewModel;

  @override
  void addPostFrameCallback() {
    _viewModel.onViewReady(argument: widget.arguments);
    super.addPostFrameCallback();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN IN"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          _buildEmailField(context),
          const SizedBox(height: 24),
          _buildPasswordField(context),
          const SizedBox(height: 40),
          _buildLogInButton(context),
        ],
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return _viewModel.loginStates.buildFor(
      select: (state) => state.errorStates.emailErrorText,
      builder: (context, state) {
        return CustomTextField(
          controller: _emailController,
          textFieldName: 'Email',
          textFieldType: TextFieldType.email,
          errorText: state.errorStates.emailErrorText?.getError(),
          onChanged: (email) => _viewModel.onChangedEmail(email: email),
        );
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return _viewModel.loginStates.buildFor(
      select: (state) => state.errorStates.passwordErrorText,
      builder: (context, state) {
        return CustomTextField(
          controller: _passwordController,
          textFieldName: 'Password',
          errorText: state.errorStates.passwordErrorText?.getError(),
          textFieldType: TextFieldType.password,
          onChanged: (password) {
            _viewModel.onChangedPassword(password: password);
          },
        );
      },
    );
  }

  Widget _buildLogInButton(BuildContext context) {
    return _viewModel.loginStates.buildFor(
      select: (state) => state.showButton,
      builder: (context, state) {
        return PrimaryButton(
          label: "LOG IN",
          onPressed: () {
            _viewModel.onTapLoginButton(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );
          },
          minWidth: double.infinity,
          isDisabled: !state.showButton,
        );
      },
    );
  }
}
