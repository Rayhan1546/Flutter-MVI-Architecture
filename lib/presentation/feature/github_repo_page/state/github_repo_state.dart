import 'package:github_repo_list/domain/model/repository.dart';
import 'package:github_repo_list/state_handler/base_state.dart';

class GithubRepoState extends BaseState<GithubRepoState> {
  final List<Repository> repoList;

  GithubRepoState({
    this.repoList = const [],
    super.showShimmer,
  });

  @override
  GithubRepoState copyWith({
    bool? showShimmer,
    List<Repository>? repoList,
  }) {
    return GithubRepoState(
      showShimmer: showShimmer ?? this.showShimmer,
      repoList: [...repoList ?? this.repoList],
    );
  }
}
