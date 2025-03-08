import 'package:github_repo_list/data/data_sources/local/app_config/token_manager.dart';
import 'package:github_repo_list/domain/use_cases/git_repo_use_case.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_arguments.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/view_model/github_repo_state.dart';

class GithubRepoViewModel extends BaseViewModel<GithubRepoState> {
  final GitRepoUseCase gitRepoUseCase;
  final TokenManager tokenManager;

  GithubRepoViewModel({
    required this.gitRepoUseCase,
    required this.tokenManager,
  }) : super(GithubRepoState.initial());

  @override
  void onViewReady() {
    _getRepoList();
  }

  void setArguments({required GithubRepoArguments arguments}) {
    updateState(state.copyWith(arguments: arguments));
  }

  // void _getCredentialData() async {
  //   final loginData = await tokenManager.getLoginCredential();
  //
  //   print(loginData?.userName ?? '');
  //   print(loginData?.refreshToken ?? '');
  //   print(loginData?.token ?? '');
  // }

  Future<void> onRefresh() async {
    updateState(state.copyWith(isLoading: true));

    await _getRepoList();
  }

  Future<void> _getRepoList() async {
    print(state.arguments?.email ?? '');

    final repoList = await gitRepoUseCase.getGitRepositories();

    updateState(state.copyWith(
      repoList: repoList,
      isLoading: false,
    ));
  }
}
