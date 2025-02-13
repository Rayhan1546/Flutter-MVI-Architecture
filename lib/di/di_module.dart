import 'package:github_repo_list/data/api_client/github_api_service.dart';
import 'package:github_repo_list/data/repository/github_repository_impl.dart';
import 'package:github_repo_list/database/drift_database/app_database.dart';
import 'package:github_repo_list/database/drift_database/github_database/github_dao.dart';
import 'package:github_repo_list/di/get_it_module.dart';
import 'package:github_repo_list/domain/repository/github_repository.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_view_model.dart';

class DIModule {
  DIModule._internal();
  static final DIModule _instance = DIModule._internal();
  factory DIModule() => _instance;

  final getIt = GetItModule();

  Future<void> injectDependencies() async {
    await _registerDatabase();
    await _registerApiServices();
    await _registerRepositories();
    await _registerViewModels();
  }

  Future<void> _registerDatabase() async {
    getIt.registerLazySingleton<GithubDao>(GithubDao(AppDatabase()));
  }

  Future<void> _registerApiServices() async {
    getIt.registerLazySingleton<GitHubApiService>(GitHubApiService());
  }

  Future<void> _registerRepositories() async {
    final gitHubService = getIt.get<GitHubApiService>();
    final githubDao = getIt.get<GithubDao>();

    getIt.registerLazySingleton<GithubRepository>(
      GithubRepositoryImpl(
        gitHubApiService: gitHubService,
        githubDao: githubDao,
      ),
    );
  }

  Future<void> _registerViewModels() async {
    final githubRepository = getIt.get<GithubRepository>();

    getIt.registerFactory(
      GithubRepoViewModel(githubRepository: githubRepository),
    );
  }

  Future<void> removeDependencies() async {
    getIt.reset();
  }
}
