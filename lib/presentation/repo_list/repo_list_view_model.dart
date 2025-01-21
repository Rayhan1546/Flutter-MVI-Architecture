import 'package:flutter/cupertino.dart';
import 'package:github_repo_list/presentation/repo_list/state/password_tab_states.dart';

class RepoListViewModel extends ChangeNotifier {
  final states = ValueNotifier<PasswordTabState>(PasswordTabState.initial());

  void onChangedOldPassword({required String? oldPassword}) {
    states.value = states.value.validateOldPassword(oldPassword);
  }

  void onChangedNewPassword({required String? newPassword}) {
    states.value = states.value.validateNewPassword(newPassword);

    _checkUpdateButtonState();
  }

  void onChangedConfirmNewPassword({required String? confirmNewPassword}) {
    states.value = states.value.validateConfirmPassword(confirmNewPassword);

    _checkUpdateButtonState();
  }

  void togglePasswordEditBtnState(bool value) {
    states.value = states.value.copyWith(isPasswordEditMode: value);

    _checkUpdateButtonState();
  }

  void _checkUpdateButtonState() {
    final state = states.value;

    final hasAllFieldsFilled = state.oldPassword != null &&
        state.oldPassword!.isNotEmpty &&
        state.newPassword != null &&
        state.newPassword!.isNotEmpty &&
        state.confirmNewPassword != null &&
        state.confirmNewPassword!.isNotEmpty;

    final hasNoErrors = state.oldPasswordErrorText == null &&
        state.newPasswordErrorText == null &&
        state.confirmNewPasswordErrorText == null;

    states.value = state.copyWith(
      showButton: hasAllFieldsFilled && hasNoErrors,
    );
  }
}
