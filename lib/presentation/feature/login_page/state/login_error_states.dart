import 'package:github_repo_list/presentation/common/mixin/email_validator_mixin.dart';
import 'package:github_repo_list/presentation/common/mixin/password_validator_mixin.dart';
import 'package:github_repo_list/presentation/common/enum/validation_error.dart';

class LoginErrorStates with EmailValidator, PasswordValidatorMixIn {
  final ValidationError? emailErrorText;
  final ValidationError? passwordErrorText;

  LoginErrorStates({
    this.emailErrorText,
    this.passwordErrorText,
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
      emailErrorText:
          emailErrorText != null ? emailErrorText() : this.emailErrorText,
      passwordErrorText: passwordErrorText != null
          ? passwordErrorText()
          : this.passwordErrorText,
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
