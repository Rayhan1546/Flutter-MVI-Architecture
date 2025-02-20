import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/common/enum/validation_error.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/login_page/argument/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/login_page/view_model/login_states.dart';
import 'package:github_repo_list/presentation/navigation/route_path.dart';

class LoginViewModel extends BaseViewModel<LoginArgument, LoginStates> {
  LoginViewModel() : super(LoginStates.initial());

  void onChangedEmail({required String? email}) {
    if (email == null || email.isEmpty) return;

    updateState(currentState.validateEmail(email));

    _checkUpdateButtonState();
  }

  void onChangedPassword({required String? password}) {
    if (password == null || password.isEmpty) return;

    updateState(currentState.validatePassword(password));

    _checkUpdateButtonState();
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled =
        currentState.email.isNotEmpty && currentState.password.isNotEmpty;

    final hasNoErrors = currentState.emailError == ValidationError.none &&
        currentState.passwordError == ValidationError.none;

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
