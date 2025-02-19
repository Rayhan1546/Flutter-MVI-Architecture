import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_adaptive_screen.dart';
import 'package:github_repo_list/presentation/feature/login_page/argument/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/login_page/components/login_button.dart';
import 'package:github_repo_list/presentation/feature/login_page/components/login_email_field.dart';
import 'package:github_repo_list/presentation/feature/login_page/components/login_password_field.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_view_model.dart';

class LoginScreen extends BaseAdaptiveScreen<LoginViewModel, LoginArgument> {
  const LoginScreen({super.key, required super.arguments});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
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
    );
  }
}
