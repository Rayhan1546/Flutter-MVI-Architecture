import 'package:github_repo_list/domain/entities/repository.dart';

abstract class GitRepository {
  Future<List<Repository>> getGitRepositories();
}
