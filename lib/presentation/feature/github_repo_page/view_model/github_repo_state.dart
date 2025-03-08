import 'package:github_repo_list/domain/entities/repository.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/argument/github_repo_arguments.dart';

class GithubRepoState extends BaseState<GithubRepoState> {
  final List<Repository> repoList;
  final bool isLoading;
  final GithubRepoArguments? arguments;

  GithubRepoState({
    required this.repoList,
    required this.isLoading,
    this.arguments,
  });

  factory GithubRepoState.initial() {
    return GithubRepoState(
      repoList: const [],
      isLoading: true,
      arguments: null,
    );
  }

  @override
  GithubRepoState copyWith({
    bool? isLoading,
    List<Repository>? repoList,
    GithubRepoArguments? arguments,
  }) {
    return GithubRepoState(
      isLoading: isLoading ?? this.isLoading,
      repoList: repoList ?? this.repoList,
      arguments: arguments ?? this.arguments,
    );
  }
}
