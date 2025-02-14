import 'package:github_repo_list/data/api_client/github_api_service.dart';
import 'package:github_repo_list/data/data_sources/local/drift_database/github_database/github_dao.dart';
import 'package:github_repo_list/data/mapper/git_repository_mapper.dart';
import 'package:github_repo_list/domain/entities/repository.dart';
import 'package:github_repo_list/domain/repositories/github_repository.dart';

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

      final List<Repository> repoList = GitRepositoryMapper.mapToResponse(
        repositories,
      );

      await githubDao.insertRepoList(repoList);

      return repoList;
    } catch (e) {
      final localData = await githubDao.getAllRepos();

      return GitRepositoryMapper.mapToDatabase(localData);
    }
  }
}
