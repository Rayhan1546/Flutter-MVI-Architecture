import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_ui.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/argument/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/login_page/components/login_button.dart';
import 'package:github_repo_list/presentation/feature/login_page/components/login_email_field.dart';
import 'package:github_repo_list/presentation/feature/login_page/components/login_password_field.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  final LoginArgument? arguments;

  const LoginScreen({super.key, this.arguments});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseAdaptiveUI<LoginScreen> {
  final _viewModel = LoginViewModel();

  @override
  BaseViewModel viewModel() => _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel.onViewReady(argument: widget.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN IN"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            LoginEmailField(viewModel: _viewModel),
            const SizedBox(height: 24),
            LoginPasswordField(viewModel: _viewModel),
            const SizedBox(height: 40),
            LoginButton(viewModel: _viewModel),
          ],
        ),
      ),
    );
  }
}
