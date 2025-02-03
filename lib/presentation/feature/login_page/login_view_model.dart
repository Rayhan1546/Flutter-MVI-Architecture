import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/common/enum/navigation_type.dart';
import 'package:github_repo_list/presentation/feature/change_password_page/change_password_ui.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_ui.dart';
import 'package:github_repo_list/presentation/feature/login_page/state/login_states.dart';

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
    navigate(
      routePage: GithubRepoUi.routeName,
      navigationType: NavigationType.replace,
    );
  }

  void onTapChangeButton() {
    navigate(
      routePage: ChangePasswordUi.routeName,
      navigationType: NavigationType.push,
    );
  }

  @override
  void onDispose() {
    _loginStates.dispose();
    super.onDispose();
  }
}
