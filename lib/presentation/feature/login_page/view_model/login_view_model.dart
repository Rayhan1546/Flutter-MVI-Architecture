import 'package:github_repo_list/data/data_sources/local/app_config/login_state_manager.dart';
import 'package:github_repo_list/data/data_sources/local/app_config/token_manager.dart';
import 'package:github_repo_list/domain/entities/login_credentials.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/common/enum/validation_error.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/login_page/argument/login_arguments.dart';
import 'package:github_repo_list/presentation/feature/login_page/view_model/login_intend.dart';
import 'package:github_repo_list/presentation/feature/login_page/view_model/login_states.dart';
import 'package:github_repo_list/presentation/navigation/routes_config.dart';

class LoginViewModel extends BaseViewModel<LoginArgument, LoginStates> {
  final LoginStateManager loginStateManager;
  final TokenManager tokenManager;

  LoginViewModel({
    required this.loginStateManager,
    required this.tokenManager,
  }) : super(LoginStates.initial());

  void dispatchIntent(LoginIntent intent) {
    if (intent is LoginEmailIntent) {
      _validateEmail(email: intent.email);
    } else if (intent is LoginPasswordIntent) {
      _validatePassword(password: intent.password);
    } else if (intent is LoginButtonIntent) {
      _proceedLogin();
    }
  }

  void _validateEmail({required String? email}) {
    if (email == null || email.isEmpty) return;

    updateState(state.validateEmail(email));

    _checkLoginButtonState();
  }

  void _validatePassword({required String? password}) {
    if (password == null || password.isEmpty) return;

    updateState(state.validatePassword(password));

    _checkLoginButtonState();
  }

  void _checkLoginButtonState() {
    final hasAllFieldsFilled =
        state.email.isNotEmpty && state.password.isNotEmpty;

    final hasNoErrors = state.emailError == ValidationError.none &&
        state.passwordError == ValidationError.none;

    updateState(state.copyWith(
      showButton: hasNoErrors && hasAllFieldsFilled,
    ));
  }

  void _proceedLogin() {
    saveLoginCredential();
    navigateTo(
      routePath: RoutePaths.githubRepoPage,
      arguments: GithubRepoArgument(
        email: state.email.trim(),
        password: state.password.trim(),
      ),
      isClearBackStack: true,
    );
    // navigateTo(
    //   routePath: RoutePaths.counter,
    //   arguments: CounterArgument(),
    //   isClearBackStack: true,
    // );
  }

  void saveLoginCredential() async {
    await loginStateManager.saveValue(true);
    await tokenManager.saveLoginToken(
      loginCredential: LoginCredentials(
        token: 'djnvkdfnvkhfdbvfdbhvjhbfd',
        refreshToken: 'fjnvdfnvhbdjfvjdfvd',
        userName: 'Rayhan Mahmud',
      ),
    );
  }
}
