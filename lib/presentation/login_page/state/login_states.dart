import 'package:github_repo_list/presentation/login_page/state/login_error_states.dart';

class LoginStates {
  final bool emailEmpty;
  final bool passwordEmpty;
  final bool showButton;
  final LoginErrorStates errorStates;

  LoginStates({
    required this.passwordEmpty,
    required this.emailEmpty,
    this.showButton = false,
    required this.errorStates,
  });

  factory LoginStates.initial() {
    return LoginStates(
      passwordEmpty: true,
      emailEmpty: true,
      showButton: false,
      errorStates: LoginErrorStates.initial(),
    );
  }

  LoginStates copyWith({
    bool? emailEmpty,
    bool? passwordEmpty,
    bool? showButton,
    LoginErrorStates? errorStates,
  }) {
    return LoginStates(
      emailEmpty: emailEmpty ?? this.emailEmpty,
      passwordEmpty: passwordEmpty ?? this.passwordEmpty,
      showButton: showButton ?? this.showButton,
      errorStates: errorStates ?? this.errorStates,
    );
  }
}
