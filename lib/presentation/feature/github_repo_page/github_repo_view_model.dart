import 'package:flutter/foundation.dart';
import 'package:github_repo_list/domain/repositories/github_repository.dart';
import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/route/github_repo_params.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/state/github_repo_state.dart';

class GithubRepoViewModel extends BaseViewModel<GithubRepoArgument> {
  final GithubRepository githubRepository;

  GithubRepoViewModel({required this.githubRepository});

  final _gitRepoState = ValueNotifier<GithubRepoState>(
    GithubRepoState.initial(),
  );

  GithubRepoState get _state => _gitRepoState.value;

  ValueListenable<GithubRepoState> get gitRepoState => _gitRepoState;

  @override
  void onViewReady({GithubRepoArgument? argument}) {
    _getRepoList();
  }

  Future<void> onRefresh() async {
    _gitRepoState.value = _state.copyWith(
      isLoading: true,
    );

    await _getRepoList();
  }

  Future<void> _getRepoList() async {
    final repoList = await githubRepository.getGithubRepository();

    _gitRepoState.value = _state.copyWith(
      repoList: repoList,
      isLoading: false,
    );
  }

  @override
  void onDispose() {
    super.onDispose();
    _gitRepoState.dispose();
  }
}
