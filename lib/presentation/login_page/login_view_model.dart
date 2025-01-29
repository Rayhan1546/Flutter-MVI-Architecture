import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/login_page/state/login_states.dart';

class LoginViewModel {
  //ValueNotifier Initialization
  final _passwordTabStates = ValueNotifier<LoginStates>(
    LoginStates.initial(),
  );

  //ValueListenable for UI
  ValueListenable<LoginStates> get passwordStates => _passwordTabStates;

  //State getter to handle state
  LoginStates get _state => _passwordTabStates.value;

  void onChangedEmail({required String? email}) {
    _passwordTabStates.value = _state.validateEmail(email);

    _checkUpdateButtonState();
  }

  void onChangedPassword({required String? password}) {
    _passwordTabStates.value = _state.validatePassword(password);

    _checkUpdateButtonState();
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled = _state.email != null &&
        _state.email!.isNotEmpty &&
        _state.password != null &&
        _state.password!.isNotEmpty;

    final hasNoErrors =
        _state.emailErrorText == null && _state.passwordErrorText == null;

    _passwordTabStates.value = _state.copyWith(
      showButton: hasAllFieldsFilled && hasNoErrors,
    );
  }

  void onDispose() {
    _passwordTabStates.dispose();
  }
}
