import 'package:github_repo_list/presentation/common/validation/email_validator.dart';
import 'package:github_repo_list/presentation/common/validation/password_validator.dart';
import 'package:github_repo_list/presentation/common/validation/validation_error.dart';

class LoginStates {
  final ValidationError? emailErrorText;
  final ValidationError? passwordErrorText;
  final String? email;
  final String? password;
  final bool showButton;

  LoginStates({
    this.emailErrorText,
    this.passwordErrorText,
    this.email,
    this.password,
    this.showButton = false,
  });

  factory LoginStates.initial() {
    return LoginStates(
      emailErrorText: null,
      passwordErrorText: null,
      email: null,
      password: null,
      showButton: false,
    );
  }

  LoginStates copyWith({
    ValidationError? Function()? emailErrorText,
    ValidationError? Function()? passwordErrorText,
    String? Function()? email,
    String? Function()? password,
    bool? showButton,
  }) {
    return LoginStates(
      emailErrorText:
          emailErrorText != null ? emailErrorText() : this.emailErrorText,
      passwordErrorText: passwordErrorText != null
          ? passwordErrorText()
          : this.passwordErrorText,
      email: email != null ? email() : this.email,
      password: password != null ? password() : this.password,
      showButton: showButton ?? this.showButton,
    );
  }

  LoginStates validateEmail(String? email) {
    return copyWith(
      email: () => email,
      emailErrorText: () => EmailValidator.getValidationError(email),
    );
  }

  LoginStates validatePassword(String? password) {
    return copyWith(
      password: () => password,
      passwordErrorText: () => PasswordValidator.getValidationError(password),
    );
  }
}
