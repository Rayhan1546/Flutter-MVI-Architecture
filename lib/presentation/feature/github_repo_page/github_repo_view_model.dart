import 'package:github_repo_list/domain/repositories/github_repository.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/state/github_repo_state.dart';

class GithubRepoViewModel extends BaseViewModel<GithubRepoArgument, GithubRepoState> {
  final GithubRepository githubRepository;

  GithubRepoViewModel({
    required this.githubRepository,
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
    final repoList = await githubRepository.getGithubRepository();

    updateState(currentState.copyWith(
      repoList: repoList,
      isLoading: false,
    ));
  }
}
