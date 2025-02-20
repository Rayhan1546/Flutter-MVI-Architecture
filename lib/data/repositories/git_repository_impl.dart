import 'package:github_repo_list/data/data_sources/local/drift/github_database/github_dao.dart';
import 'package:github_repo_list/data/data_sources/remote/git_api_service.dart';
import 'package:github_repo_list/data/mapper/git_repository_mapper.dart';
import 'package:github_repo_list/domain/entities/repository.dart';
import 'package:github_repo_list/domain/repositories/git_repository.dart';

class GitRepositoryImpl extends GitRepository {
  final GitApiService gitHubApiService;
  final GithubDao githubDao;

  GitRepositoryImpl({
    required this.gitHubApiService,
    required this.githubDao,
  });

  @override
  Future<List<Repository>> getGitRepositories() async {
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
