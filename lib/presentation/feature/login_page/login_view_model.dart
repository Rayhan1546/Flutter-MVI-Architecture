import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/feature/change_password_page/change_password_ui.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_ui.dart';
import 'package:github_repo_list/presentation/feature/login_page/state/login_states.dart';
import 'package:github_repo_list/state_handler/base_view_model.dart';
import 'package:github_repo_list/state_handler/navigation_type.dart';

class LoginViewModel extends BaseViewModel {
  //ValueNotifier Initialization
  final _loginStates = ValueNotifier<LoginStates>(
    LoginStates.initial(),
  );

  //ValueListenable for UI
  ValueListenable<LoginStates> get loginStates => _loginStates;

  //State getter to handle state
  LoginStates get _state => _loginStates.value;

  void onChangedEmail({required String? email}) {
    if (email == null || email.isEmpty) {
      _loginStates.value = _state.copyWith(
        emailEmpty: true,
      );
      return;
    }

    final errorState = _state.errorStates.validateEmail(email);

    _loginStates.value = _state.copyWith(
      errorStates: errorState,
      emailEmpty: false,
    );

    _checkUpdateButtonState();
  }

  void onChangedPassword({required String? password}) {
    if (password == null || password.isEmpty) {
      _loginStates.value = _state.copyWith(
        passwordEmpty: true,
      );
      return;
    }

    final errorState = _state.errorStates.validatePassword(password);

    _loginStates.value = _state.copyWith(
      errorStates: errorState,
      passwordEmpty: false,
    );

    _checkUpdateButtonState();
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled = !_state.emailEmpty && !_state.passwordEmpty;

    final hasNoErrors = _state.errorStates.emailErrorText == null &&
        _state.errorStates.passwordErrorText == null;

    _loginStates.value = _state.copyWith(
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
  }
}
