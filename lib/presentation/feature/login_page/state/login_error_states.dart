import 'package:github_repo_list/presentation/common/validation/email_validator.dart';
import 'package:github_repo_list/presentation/common/validation/password_validator.dart';
import 'package:github_repo_list/presentation/common/validation/validation_error.dart';

class LoginErrorStates with EmailValidator, PasswordValidator {
  final ValidationError? emailErrorText;
  final ValidationError? passwordErrorText;

  LoginErrorStates({
    this.emailErrorText = null,
    this.passwordErrorText = null,
  });

  factory LoginErrorStates.initial() {
    return LoginErrorStates(
      emailErrorText: null,
      passwordErrorText: null,
    );
  }

  LoginErrorStates copyWith({
    ValidationError? Function()? emailErrorText,
    ValidationError? Function()? passwordErrorText,
  }) {
    return LoginErrorStates(
      emailErrorText: emailErrorText != null ? emailErrorText() : this.emailErrorText,
      passwordErrorText: passwordErrorText != null ? passwordErrorText() : this.passwordErrorText,
    );
  }

  LoginErrorStates validateEmail(String? email) {
    return copyWith(
      emailErrorText: () => getEmailValidation(email),
    );
  }

  LoginErrorStates validatePassword(String? password) {
    return copyWith(
      passwordErrorText: () => getPasswordValidationError(password),
    );
  }
}
