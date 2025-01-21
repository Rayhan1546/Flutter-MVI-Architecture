import 'package:github_repo_list/domain/model/repository.dart';

abstract class GithubRepository {
  Future<List<Repository>> getGithubRepository();
}