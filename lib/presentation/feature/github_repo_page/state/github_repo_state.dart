import 'package:github_repo_list/domain/model/repository.dart';
import 'package:github_repo_list/state_handler/base_state.dart';
import 'package:github_repo_list/state_handler/navigation_type.dart';

class GithubRepoState extends BaseState<GithubRepoState> {
  final List<Repository> repoList;
  final bool isLoading;

  GithubRepoState({
    this.repoList = const [],
    this.isLoading = true,
  });

  @override
  GithubRepoState copyWith({
    bool? isLoading,
    List<Repository>? repoList,
  }) {
    return GithubRepoState(
      isLoading: isLoading ?? this.isLoading,
      repoList: [...repoList ?? this.repoList],
    );
  }
}
