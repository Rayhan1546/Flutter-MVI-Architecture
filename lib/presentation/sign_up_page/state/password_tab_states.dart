import 'package:github_repo_list/presentation/common/validation/password_validator.dart';
import 'package:github_repo_list/presentation/common/validation/validation_error.dart';

class SignUpStates {
  final bool isPasswordEditMode;
  final ValidationError? oldPasswordErrorText;
  final ValidationError? newPasswordErrorText;
  final ValidationError? confirmNewPasswordErrorText;
  final String? oldPassword;
  final String? newPassword;
  final String? confirmNewPassword;
  final bool showButton;
  final bool showSuccessMessage;

  const SignUpStates({
    required this.isPasswordEditMode,
    this.oldPasswordErrorText,
    this.newPasswordErrorText,
    this.confirmNewPasswordErrorText,
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,
    this.showButton = false,
    this.showSuccessMessage = false,
  });

  factory SignUpStates.initial() {
    return const SignUpStates(
      isPasswordEditMode: false,
      oldPasswordErrorText: null,
      newPasswordErrorText: null,
      confirmNewPasswordErrorText: null,
      oldPassword: null,
      newPassword: null,
      confirmNewPassword: null,
      showButton: false,
      showSuccessMessage: false,
    );
  }

  SignUpStates copyWith({
    bool? isPasswordEditMode,
    ValidationError? Function()? oldPasswordErrorText,
    ValidationError? Function()? newPasswordErrorText,
    ValidationError? Function()? confirmNewPasswordErrorText,
    String? Function()? oldPassword,
    String? Function()? newPassword,
    String? Function()? confirmNewPassword,
    bool? showButton,
    bool? showSuccessMessage,
  }) {
    return SignUpStates(
      isPasswordEditMode: isPasswordEditMode ?? this.isPasswordEditMode,
      oldPasswordErrorText: oldPasswordErrorText != null
          ? oldPasswordErrorText()
          : this.oldPasswordErrorText,
      newPasswordErrorText: newPasswordErrorText != null
          ? newPasswordErrorText()
          : this.newPasswordErrorText,
      confirmNewPasswordErrorText: confirmNewPasswordErrorText != null
          ? confirmNewPasswordErrorText()
          : this.confirmNewPasswordErrorText,
      oldPassword: oldPassword != null ? oldPassword() : this.oldPassword,
      newPassword: newPassword != null ? newPassword() : this.newPassword,
      confirmNewPassword: confirmNewPassword != null
          ? confirmNewPassword()
          : this.confirmNewPassword,
      showButton: showButton ?? this.showButton,
      showSuccessMessage: showSuccessMessage ?? this.showSuccessMessage,
    );
  }

  SignUpStates validateOldPassword(String? password) {
    if (password == null || password.isEmpty) {
      return copyWith(
        oldPassword: () => password,
        oldPasswordErrorText: () {
          return PasswordValidator.getValidationError(password);
        },
      );
    }
    return copyWith(
      oldPassword: () => password,
      oldPasswordErrorText: () => null,
    );
  }

  SignUpStates validateNewPassword(String? password) {
    final state = copyWith(
      newPassword: () => password,
      newPasswordErrorText: () {
        return PasswordValidator.getValidationError(password);
      },
    );

    if (confirmNewPassword != null && confirmNewPassword!.isNotEmpty) {
      return state.validateConfirmPassword(confirmNewPassword!);
    }
    return state;
  }

  SignUpStates validateConfirmPassword(String? confirmPassword) {
    return copyWith(
      confirmNewPassword: () => confirmPassword,
      confirmNewPasswordErrorText: () {
        return PasswordValidator.matchTwoPassword(
          newPassword,
          confirmPassword,
        );
      },
    );
  }
}
