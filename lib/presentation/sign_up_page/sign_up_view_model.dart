import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/sign_up_page/state/password_tab_states.dart';

class SignUpViewModel {
  //ValueNotifier Initialization
  final _passwordTabStates = ValueNotifier<SignUpStates>(
    SignUpStates.initial(),
  );

  //ValueListenable for UI
  ValueListenable<SignUpStates> get passwordStates => _passwordTabStates;

  //State getter to handle state
  SignUpStates get _state => _passwordTabStates.value;

  void onChangedOldPassword({required String? oldPassword}) {
    _passwordTabStates.value = _state.validateOldPassword(oldPassword);

    _checkUpdateButtonState();
  }

  void onChangedNewPassword({required String? newPassword}) {
    _passwordTabStates.value = _state.validateNewPassword(newPassword);

    _checkUpdateButtonState();
  }

  void onChangedConfirmNewPassword({required String? confirmNewPassword}) {
    _passwordTabStates.value = _state.validateConfirmPassword(
      confirmNewPassword,
    );

    _checkUpdateButtonState();
  }

  void togglePasswordEditBtnState(bool value) {
    _passwordTabStates.value = _state.copyWith(isPasswordEditMode: value);
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled = _state.oldPassword != null &&
        _state.oldPassword!.isNotEmpty &&
        _state.newPassword != null &&
        _state.newPassword!.isNotEmpty &&
        _state.confirmNewPassword != null &&
        _state.confirmNewPassword!.isNotEmpty;

    final hasNoErrors = _state.oldPasswordErrorText == null &&
        _state.newPasswordErrorText == null &&
        _state.confirmNewPasswordErrorText == null;

    _passwordTabStates.value = _state.copyWith(
      showButton: hasAllFieldsFilled && hasNoErrors,
    );
  }

  void onTapUpdatePasswordBtn() {
    _passwordTabStates.value = _state.copyWith(
      showSuccessMessage: true,
      isPasswordEditMode: false,
    );
  }

  void onDispose() {
    _passwordTabStates.dispose();
  }
}
