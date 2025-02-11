import 'package:github_repo_list/domain/model/repository.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';

class GithubRepoState extends BaseState<GithubRepoState> {
  final List<Repository> repoList;
  final List<String> words;
  final bool isLoading;

  GithubRepoState({
    this.repoList = const [],
    this.words = const ['a', 'b', 'c'],
    this.isLoading = true,
  });

  @override
  GithubRepoState copyWith({
    bool? isLoading,
    List<Repository>? repoList,
    List<String>? words,
  }) {
    return GithubRepoState(
      isLoading: isLoading ?? this.isLoading,
      repoList: repoList ?? this.repoList,
      words: words ?? this.words,
    );
  }
}
