import 'package:github_repo_list/domain/entities/repository.dart';

abstract class GithubRepository {
  Future<List<Repository>> getGithubRepository();
}
