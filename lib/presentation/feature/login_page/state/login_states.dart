import 'package:github_repo_list/presentation/feature/login_page/state/login_error_states.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';

class LoginStates extends BaseState<LoginStates> {
  final String email;
  final String password;
  final bool showButton;
  final LoginErrorStates errorStates;

  LoginStates({
    required this.email,
    required this.password,
    required this.showButton,
    required this.errorStates,
  });

  factory LoginStates.initial() {
    return LoginStates(
      email: '',
      password: '',
      showButton: false,
      errorStates: LoginErrorStates.initial(),
    );
  }

  @override
  LoginStates copyWith({
    String? email,
    String? password,
    bool? showButton,
    LoginErrorStates? errorStates,
  }) {
    return LoginStates(
      email: email ?? this.email,
      password: password ?? this.password,
      showButton: showButton ?? this.showButton,
      errorStates: errorStates ?? this.errorStates,
    );
  }
}
