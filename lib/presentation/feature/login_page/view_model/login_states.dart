import 'package:github_repo_list/domain/entities/login_credentials.dart';
import 'package:github_repo_list/presentation/common/enum/validation_error.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/common/validator/email_validator.dart';
import 'package:github_repo_list/presentation/common/validator/password_validator.dart';

class LoginStates extends BaseState<LoginStates> {
  final String email;
  final String password;
  final bool showButton;
  final ValidationError emailError;
  final ValidationError passwordError;
  final LoginCredentials? loginCredentials;

  LoginStates({
    required this.email,
    required this.password,
    required this.showButton,
    required this.emailError,
    required this.passwordError,
    this.loginCredentials,
  });

  factory LoginStates.initial() {
    return LoginStates(
      email: '',
      password: '',
      showButton: false,
      emailError: ValidationError.none,
      passwordError: ValidationError.none,
      loginCredentials: null,
    );
  }

  @override
  LoginStates copyWith({
    String? email,
    String? password,
    bool? showButton,
    ValidationError? emailError,
    ValidationError? passwordError,
    LoginCredentials? loginCredential,
  }) {
    return LoginStates(
      email: email ?? this.email,
      password: password ?? this.password,
      showButton: showButton ?? this.showButton,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      loginCredentials: loginCredential ?? this.loginCredentials,
    );
  }

  LoginStates validateEmail(String email) {
    return copyWith(
      email: email,
      emailError: EmailValidator.getEmailValidation(email),
    );
  }

  LoginStates validatePassword(String password) {
    return copyWith(
      password: password,
      passwordError: PasswordValidator.getPasswordValidation(password),
    );
  }
}
