import 'package:github_repo_list/presentation/change_password_page/state/change_password_error_states.dart';

class ChangePasswordStates {
  final bool isPasswordEditMode;
  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;
  final ChangePasswordErrorStates errorStates;
  final bool showButton;
  final bool showSuccessMessage;

  const ChangePasswordStates({
    required this.isPasswordEditMode,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
    required this.errorStates,
    required this.showButton,
    required this.showSuccessMessage,
  });

  factory ChangePasswordStates.initial() {
    return ChangePasswordStates(
      isPasswordEditMode: false,
      oldPassword: '',
      newPassword: '',
      confirmNewPassword: '',
      errorStates: ChangePasswordErrorStates.initial(),
      showButton: false,
      showSuccessMessage: false,
    );
  }

  ChangePasswordStates copyWith({
    bool? isPasswordEditMode,
    String? oldPassword,
    String? newPassword,
    String? confirmNewPassword,
    ChangePasswordErrorStates? errorStates,
    bool? showButton,
    bool? showSuccessMessage,
  }) {
    return ChangePasswordStates(
      isPasswordEditMode: isPasswordEditMode ?? this.isPasswordEditMode,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      errorStates: errorStates ?? this.errorStates,
      showButton: showButton ?? this.showButton,
      showSuccessMessage: showSuccessMessage ?? this.showSuccessMessage,
    );
  }
}
