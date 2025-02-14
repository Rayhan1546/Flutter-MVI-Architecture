import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/login_page/argument/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/login_page/state/login_states.dart';
import 'package:github_repo_list/presentation/navigation/route_path.dart';

class LoginViewModel extends BaseViewModel<LoginArgument> {
  final _loginStates = ValueNotifier<LoginStates>(
    LoginStates.initial(),
  );

  LoginStates get _states => _loginStates.value;

  ValueListenable<LoginStates> get loginStates => _loginStates;

  @override
  void onViewReady({LoginArgument? argument}) {
    // TODO: implement onViewReady
    super.onViewReady(argument: argument);
  }

  void onChangedEmail({required String? email}) {
    if (email == null || email.isEmpty) {
      return;
    }

    final errorState = _states.errorStates.validateEmail(email);

    _loginStates.value = _states.copyWith(
      errorStates: errorState,
      email: email,
    );

    _checkUpdateButtonState();
  }

  void onChangedPassword({required String? password}) {
    if (password == null || password.isEmpty) {
      return;
    }

    final errorState = _states.errorStates.validatePassword(password);

    _loginStates.value = _states.copyWith(
      errorStates: errorState,
      password: password,
    );

    _checkUpdateButtonState();
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled =
        _states.email.isNotEmpty && _states.password.isNotEmpty;

    final hasNoErrors = _states.errorStates.emailErrorText == null &&
        _states.errorStates.passwordErrorText == null;

    _loginStates.value = _states.copyWith(
      showButton: hasNoErrors && hasAllFieldsFilled,
    );
  }

  void onTapLoginButton() {
    navigateTo(
      routePath: RoutePaths.githubRepoPage,
      arguments: GithubRepoArgument(
        email: _states.email.trim(),
        password: _states.password.trim(),
      ),
      isClearBackStack: true,
    );
  }

  @override
  void onDispose() {
    _loginStates.dispose();
    super.onDispose();
  }
}
