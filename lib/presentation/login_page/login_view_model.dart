import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/login_page/state/login_states.dart';

class LoginViewModel {
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
    final hasAllFieldsFilled =
        _state.emailEmpty == false && _state.passwordEmpty == false;

    final hasNoErrors = _state.errorStates.emailErrorText == null &&
        _state.errorStates.passwordErrorText == null;

    _loginStates.value = _state.copyWith(
      showButton: hasNoErrors && hasAllFieldsFilled,
    );
  }

  void onTapLoginButton() {
    _loginStates.value = _state.copyWith(
      showButton: false,
    );
  }

  void onDispose() {
    _loginStates.dispose();
  }
}
