import 'package:github_repo_list/data/data_sources/local/drift_database/github_database/github_dao.dart';
import 'package:github_repo_list/data/data_sources/remote/git_api_service.dart';
import 'package:github_repo_list/data/repositories/github_repository_impl.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/domain/repositories/github_repository.dart';

/// This class should always be LazySingleTon
class RepositoriesInjecter {
  final diModule = DIModule();

  Future<void> registerRepositories() async {
    final gitHubService = diModule.get<GitApiService>();
    final githubDao = diModule.get<GithubDao>();

    diModule.registerLazySingleton<GithubRepository>(GithubRepositoryImpl(
      gitHubApiService: gitHubService,
      githubDao: githubDao,
    ));
  }
}
