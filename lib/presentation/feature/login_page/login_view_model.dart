import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/state/login_states.dart';
import 'package:github_repo_list/presentation/navigation/route_params.dart';
import 'package:github_repo_list/presentation/navigation/route_path.dart';

class LoginViewModel extends BaseViewModel<LoginStates> {
  final _loginStates = ValueNotifier<LoginStates>(
    LoginStates.initial(),
  );

  @override
  ValueListenable<LoginStates> getValue() => _loginStates;

  void onChangedEmail({required String? email}) {
    if (email == null || email.isEmpty) {
      _loginStates.value = stateSetter.copyWith(
        emailEmpty: true,
      );
      return;
    }

    final errorState = stateSetter.errorStates.validateEmail(email);

    _loginStates.value = stateSetter.copyWith(
      errorStates: errorState,
      emailEmpty: false,
    );

    _checkUpdateButtonState();
  }

  void onChangedPassword({required String? password}) {
    if (password == null || password.isEmpty) {
      _loginStates.value = stateSetter.copyWith(
        passwordEmpty: true,
      );
      return;
    }

    final errorState = stateSetter.errorStates.validatePassword(password);

    _loginStates.value = stateSetter.copyWith(
      errorStates: errorState,
      passwordEmpty: false,
    );

    _checkUpdateButtonState();
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled =
        !stateSetter.emailEmpty && !stateSetter.passwordEmpty;

    final hasNoErrors = stateSetter.errorStates.emailErrorText == null &&
        stateSetter.errorStates.passwordErrorText == null;

    _loginStates.value = stateSetter.copyWith(
      showButton: hasNoErrors && hasAllFieldsFilled,
    );
  }

  void onTapLoginButton() {
    navigateTo(
      routePath: RoutePaths.githubRepoPage,
      routeParams: GithubRepoParams(
        email: 'herjrj',
        password: 'fdhvufv',
      ),
      isClearBackStack: true,
    );
  }

  void onTapChangeButton() {
    navigateTo(
      routePath: RoutePaths.changePassword,
      routeParams: ChangePasswordParams(),
    );
  }

  @override
  void onDispose() {
    _loginStates.dispose();
    super.onDispose();
  }
}
