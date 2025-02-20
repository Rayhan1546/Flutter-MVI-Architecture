import 'package:github_repo_list/domain/use_cases/git_repo_use_case.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/view_model/github_repo_state.dart';

class GithubRepoViewModel
    extends BaseViewModel<GithubRepoArgument, GithubRepoState> {
  final GitRepoUseCase gitRepoUseCase;

  GithubRepoViewModel({
    required this.gitRepoUseCase,
  }) : super(GithubRepoState.initial());

  @override
  void onViewReady({GithubRepoArgument? argument}) {
    _getRepoList();
  }

  Future<void> onRefresh() async {
    updateState(currentState.copyWith(isLoading: true));

    await _getRepoList();
  }

  Future<void> _getRepoList() async {
    final repoList = await gitRepoUseCase.getGitRepositories();

    updateState(currentState.copyWith(
      repoList: repoList,
      isLoading: false,
    ));
  }
}
