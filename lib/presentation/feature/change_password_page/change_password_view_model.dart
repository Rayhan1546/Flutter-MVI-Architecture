import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/feature/change_password_page/state/change_password_states.dart';

class ChangePasswordViewModel {
  //ValueNotifier Initialization
  final _passwordTabStates = ValueNotifier<ChangePasswordStates>(
    ChangePasswordStates.initial(),
  );

  //ValueListenable for UI
  ValueListenable<ChangePasswordStates> get passwordStates => _passwordTabStates;

  //State getter to handle state
  ChangePasswordStates get _state => _passwordTabStates.value;

  void onChangedOldPassword({required String? oldPassword}) {
    final errorStates = _state.errorStates.validateOldPassword(oldPassword);

    _passwordTabStates.value = _state.copyWith(
      errorStates: errorStates,
      oldPassword: oldPassword,
    );

    _checkUpdateButtonState();
  }

  void onChangedNewPassword({required String? newPassword}) {
    final errorStates = _state.errorStates.validateNewPassword(newPassword);

    _passwordTabStates.value = _state.copyWith(
      errorStates: errorStates,
      newPassword: newPassword,
    );

    if (_state.confirmNewPassword.isNotEmpty) {
      final errorStates = _state.errorStates.validateConfirmPassword(
        newPassword,
        _state.confirmNewPassword,
      );

      _passwordTabStates.value = _state.copyWith(
        errorStates: errorStates,
      );
    }

    _checkUpdateButtonState();
  }

  void onChangedConfirmNewPassword({required String? confirmNewPassword}) {
    if (_state.newPassword.isEmpty) {
      return;
    }

    final errorStates = _state.errorStates.validateConfirmPassword(
      _state.newPassword,
      confirmNewPassword,
    );

    _passwordTabStates.value = _state.copyWith(
      errorStates: errorStates,
      confirmNewPassword: confirmNewPassword,
    );

    _checkUpdateButtonState();
  }

  void togglePasswordEditBtnState(bool value) {
    _passwordTabStates.value = _state.copyWith(isPasswordEditMode: value);
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled = _state.oldPassword.isNotEmpty &&
        _state.newPassword.isNotEmpty &&
        _state.confirmNewPassword.isNotEmpty;

    final hasNoErrors = _state.errorStates.oldPasswordErrorText == null &&
        _state.errorStates.newPasswordErrorText == null &&
        _state.errorStates.confirmNewPasswordErrorText == null;

    _passwordTabStates.value = _state.copyWith(
      showButton: hasAllFieldsFilled && hasNoErrors,
    );
  }

  void onTapUpdatePasswordBtn() {
    _passwordTabStates.value = _state.copyWith(
      showSuccessMessage: true,
      isPasswordEditMode: false,
    );

    Future.delayed(const Duration(seconds: 3), () {
      _passwordTabStates.value = _state.copyWith(showSuccessMessage: false);
    });
  }

  void onDispose() {
    _passwordTabStates.dispose();
  }
}
