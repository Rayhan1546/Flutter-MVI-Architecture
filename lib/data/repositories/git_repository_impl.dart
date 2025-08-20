import 'package:github_repo_list/data/data_sources/local/drift/github_database/github_dao.dart';
import 'package:github_repo_list/data/data_sources/local/shared_preference/pref_github_repo_storage.dart';
import 'package:github_repo_list/data/data_sources/local/sqflite/gitub_repo_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/remote/git_api_service.dart';
import 'package:github_repo_list/data/mapper/git_repository_mapper.dart';
import 'package:github_repo_list/domain/entities/repository.dart';
import 'package:github_repo_list/domain/repositories/git_repository.dart';

class GitRepositoryImpl extends GitRepository {
  final GitApiService gitHubApiService;
  final GithubDao githubDao;
  final GithubRepoStorageManager githubRepoStorageManager;
  final PrefGithubRepoStorageManager prefGithubRepoStorageManager;

  GitRepositoryImpl({
    required this.gitHubApiService,
    required this.githubDao,
    required this.githubRepoStorageManager,
    required this.prefGithubRepoStorageManager,
  });

  @override
  Future<List<Repository>> getGitRepositories() async {
    try {
      final repositories = await gitHubApiService.fetchRepositories();

      final List<Repository> repoList = GitRepositoryMapper.mapToResponse(
        repositories,
      );

      await prefGithubRepoStorageManager.insertRepoList(repoList);

      final localRepoList = await prefGithubRepoStorageManager.getAllRepos();

      return localRepoList;
    } catch (e) {
      final localData = await prefGithubRepoStorageManager.getAllRepos();

      return localData;
    }
  }
}
