import 'package:github_repo_list/data/api_client/github_api_service.dart';
import 'package:github_repo_list/database/drift_database/github_database/github_dao.dart';
import 'package:github_repo_list/domain/model/repository.dart';
import 'package:github_repo_list/domain/repository/github_repository.dart';

class GithubRepositoryImpl extends GithubRepository {
  final GitHubApiService gitHubApiService;
  final GithubDao githubDao;

  GithubRepositoryImpl({
    required this.gitHubApiService,
    required this.githubDao,
  });

  @override
  Future<List<Repository>> getGithubRepository() async {
    try {
      final repositories = await gitHubApiService.fetchRepositories();

      final List<Repository> repoList = repositories.map((repo) {
        return Repository(
          id: repo.id,
          name: repo.fullName,
          description: repo.description,
          imgUrl: repo.owner.avatarUrl,
        );
      }).toList();

      for (var repo in repoList) {
        await githubDao.insertRepo(
          id: repo.id,
          name: repo.name,
          description: repo.description,
          imgUrl: repo.imgUrl,
        );
      }

      return repoList;
    } catch (e) {
      final localData = await githubDao.getAllRepos();

      return localData.map((repo) {
        return Repository(
          id: repo.id,
          name: repo.name,
          description: repo.description ?? '',
          imgUrl: repo.imgUrl ?? '',
        );
      }).toList();
    }
  }
}
