import 'package:github_repo_list/domain/entities/repository.dart';
import 'package:github_repo_list/domain/repositories/git_repository.dart';

class GitRepoUseCase {
  final GitRepository gitRepository;

  GitRepoUseCase({required this.gitRepository});

  Future<List<Repository>> getGitRepositories() async {
    return await gitRepository.getGithubRepository();
  }
}
