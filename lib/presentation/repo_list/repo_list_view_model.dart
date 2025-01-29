import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/repo_list/state/password_tab_states.dart';

class RepoListViewModel {
  final _passwordTabStates = ValueNotifier<PasswordTabState>(
    PasswordTabState.initial(),
  );

  ValueListenable<PasswordTabState> get passwordStates => _passwordTabStates;

  PasswordTabState get state => _passwordTabStates.value;

  void onChangedOldPassword({required String? oldPassword}) {
    _passwordTabStates.value = state.validateOldPassword(oldPassword);

    _checkUpdateButtonState();
  }

  void onChangedNewPassword({required String? newPassword}) {
    _passwordTabStates.value = state.validateNewPassword(newPassword);

    _checkUpdateButtonState();
  }

  void onChangedConfirmNewPassword({required String? confirmNewPassword}) {
    _passwordTabStates.value = state.validateConfirmPassword(
      confirmNewPassword,
    );

    _checkUpdateButtonState();
  }

  void togglePasswordEditBtnState(bool value) {
    _passwordTabStates.value = state.copyWith(isPasswordEditMode: value);
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled = state.oldPassword != null &&
        state.oldPassword!.isNotEmpty &&
        state.newPassword != null &&
        state.newPassword!.isNotEmpty &&
        state.confirmNewPassword != null &&
        state.confirmNewPassword!.isNotEmpty;

    final hasNoErrors = state.oldPasswordErrorText == null &&
        state.newPasswordErrorText == null &&
        state.confirmNewPasswordErrorText == null;

    _passwordTabStates.value = state.copyWith(
      showButton: hasAllFieldsFilled && hasNoErrors,
    );
  }

  void onTapUpdatePasswordBtn() {
    _passwordTabStates.value = state.copyWith(
      showSuccessMessage: true,
      isPasswordEditMode: false,
    );
  }

  void onDispose() {
    _passwordTabStates.dispose();
  }
}
