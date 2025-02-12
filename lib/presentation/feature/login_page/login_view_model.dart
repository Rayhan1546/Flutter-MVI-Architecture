import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/route/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/login_page/state/login_states.dart';
import 'package:github_repo_list/presentation/navigation/route_path.dart';

class LoginViewModel extends BaseViewModel {
  final _loginStates = ValueNotifier<LoginStates>(
    LoginStates.initial(),
  );

  LoginStates get _states => _loginStates.value;

  ValueListenable<LoginStates> get loginStates => _loginStates;

  void onChangedEmail({required String? email}) {
    if (email == null || email.isEmpty) {
      _loginStates.value = _states.copyWith(
        emailEmpty: true,
      );
      return;
    }

    final errorState = _states.errorStates.validateEmail(email);

    _loginStates.value = _states.copyWith(
      errorStates: errorState,
      emailEmpty: false,
    );

    _checkUpdateButtonState();
  }

  void onChangedPassword({required String? password}) {
    if (password == null || password.isEmpty) {
      _loginStates.value = _states.copyWith(
        passwordEmpty: true,
      );
      return;
    }

    final errorState = _states.errorStates.validatePassword(password);

    _loginStates.value = _states.copyWith(
      errorStates: errorState,
      passwordEmpty: false,
    );

    _checkUpdateButtonState();
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled = !_states.emailEmpty && !_states.passwordEmpty;

    final hasNoErrors = _states.errorStates.emailErrorText == null &&
        _states.errorStates.passwordErrorText == null;

    _loginStates.value = _states.copyWith(
      showButton: hasNoErrors && hasAllFieldsFilled,
    );
  }

  void onTapLoginButton({
    required String email,
    required String password,
  }) {
    navigateTo(
      routePath: RoutePaths.githubRepoPage,
      arguments: GithubRepoArgument(
        email: email,
        password: password,
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
