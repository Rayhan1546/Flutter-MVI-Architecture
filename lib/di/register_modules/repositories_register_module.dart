import 'package:github_repo_list/data/data_sources/local/drift/github_database/github_dao.dart';
import 'package:github_repo_list/data/data_sources/remote/git_api_service.dart';
import 'package:github_repo_list/data/repositories/git_repository_impl.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/domain/repositories/git_repository.dart';

/// This class should always be LazySingleTon
class RepositoriesRegisterModule {
  final diModule = DIModule();

  Future<void> registerRepositories() async {
    final gitHubService = diModule.get<GitApiService>();
    final githubDao = diModule.get<GithubDao>();

    diModule.registerLazySingleton<GitRepository>(GitRepositoryImpl(
      gitHubApiService: gitHubService,
      githubDao: githubDao,
    ));
  }
}
