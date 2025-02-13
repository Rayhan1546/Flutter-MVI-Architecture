import 'package:github_repo_list/presentation/feature/login_page/state/login_error_states.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';

class LoginStates extends BaseState<LoginStates> {
  final bool emailEmpty;
  final bool passwordEmpty;
  final bool showButton;
  final LoginErrorStates errorStates;

  LoginStates({
    required this.passwordEmpty,
    required this.emailEmpty,
    required this.showButton,
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

  @override
  LoginStates copyWith({
    bool? isLoading,
    bool? emailEmpty,
    bool? passwordEmpty,
    bool? showButton,
    LoginErrorStates? errorStates,
    String? routePage,
  }) {
    return LoginStates(
      emailEmpty: emailEmpty ?? this.emailEmpty,
      passwordEmpty: passwordEmpty ?? this.passwordEmpty,
      showButton: showButton ?? this.showButton,
      errorStates: errorStates ?? this.errorStates,
    );
  }
}
