import 'package:flutter/material.dart';
import 'package:github_repo_list/di/di_module.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_ui.dart';
import 'package:github_repo_list/presentation/base/base_provider.dart';
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
  final _viewModel = DIModule().get<LoginViewModel>();

  @override
  BaseViewModel viewModel() => _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel.onViewReady(argument: widget.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return BaseProvider<LoginViewModel>(
      viewModel: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("SIGN IN"),
        ),
        body: const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              LoginEmailField(),
              SizedBox(height: 24),
              LoginPasswordField(),
              SizedBox(height: 40),
              LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
