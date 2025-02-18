import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/login_page/argument/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/login_page/state/login_states.dart';
import 'package:github_repo_list/presentation/navigation/route_path.dart';

class LoginViewModel extends BaseViewModel<LoginArgument, LoginStates> {
  LoginViewModel() : super(LoginStates.initial());

  @override
  void onViewReady({LoginArgument? argument}) {
    // TODO: implement onViewReady
    super.onViewReady(argument: argument);
  }

  void onChangedEmail({required String? email}) {
    if (email == null || email.isEmpty) {
      return;
    }

    final errorState = currentState.errorStates.validateEmail(email);

    updateState(currentState.copyWith(
      errorStates: errorState,
      email: email,
    ));

    _checkUpdateButtonState();
  }

  void onChangedPassword({required String? password}) {
    if (password == null || password.isEmpty) {
      return;
    }

    final errorState = currentState.errorStates.validatePassword(password);

    updateState(currentState.copyWith(
      errorStates: errorState,
      password: password,
    ));

    _checkUpdateButtonState();
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled =
        currentState.email.isNotEmpty && currentState.password.isNotEmpty;

    final hasNoErrors = currentState.errorStates.emailErrorText == null &&
        currentState.errorStates.passwordErrorText == null;

    updateState(currentState.copyWith(
      showButton: hasNoErrors && hasAllFieldsFilled,
    ));
  }

  void onTapLoginButton() {
    navigateTo(
      routePath: RoutePaths.githubRepoPage,
      arguments: GithubRepoArgument(
        email: currentState.email.trim(),
        password: currentState.password.trim(),
      ),
      isClearBackStack: true,
    );
  }
}
