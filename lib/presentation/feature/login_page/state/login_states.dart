import 'package:github_repo_list/presentation/feature/login_page/state/login_error_states.dart';
import 'package:github_repo_list/state_handler/base_state.dart';

class LoginStates extends BaseState<LoginStates> {
  final bool emailEmpty;
  final bool passwordEmpty;
  final bool showButton;
  final bool navigate;
  final LoginErrorStates errorStates;

  LoginStates({
    required this.passwordEmpty,
    required this.emailEmpty,
    required this.showButton,
    required this.navigate,
    required this.errorStates,
  });

  factory LoginStates.initial() {
    return LoginStates(
      passwordEmpty: true,
      emailEmpty: true,
      showButton: false,
      navigate: false,
      errorStates: LoginErrorStates.initial(),
    );
  }

  @override
  LoginStates copyWith({
    bool? showShimmer,
    bool? emailEmpty,
    bool? passwordEmpty,
    bool? showButton,
    bool? navigate,
    LoginErrorStates? errorStates,
  }) {
    return LoginStates(
      emailEmpty: emailEmpty ?? this.emailEmpty,
      passwordEmpty: passwordEmpty ?? this.passwordEmpty,
      showButton: showButton ?? this.showButton,
      navigate: navigate ?? this.navigate,
      errorStates: errorStates ?? this.errorStates,
    );
  }
}
