import 'package:github_repo_list/data/data_sources/local/drift_database/app_database.dart';
import 'package:github_repo_list/data/data_sources/local/drift_database/github_database/github_dao.dart';
import 'package:github_repo_list/data/data_sources/remote/git_api_service.dart';
import 'package:github_repo_list/data/repositories/github_repository_impl.dart';
import 'package:github_repo_list/di/di_module.dart';
import 'package:github_repo_list/domain/repositories/github_repository.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_view_model.dart';

class InjectionContainer {
  InjectionContainer._internal();
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;

  final diModule = DIModule();

  Future<void> injectDependencies() async {
    await _registerDatabase();
    await _registerApiServices();
    await _registerRepositories();
    await _registerViewModels();
  }

  Future<void> _registerDatabase() async {
    diModule.registerLazySingleton<GithubDao>(GithubDao(AppDatabase()));
  }

  Future<void> _registerApiServices() async {
    diModule.registerLazySingleton<GitApiService>(GitApiService());
  }

  Future<void> _registerRepositories() async {
    final gitHubService = diModule.get<GitApiService>();
    final githubDao = diModule.get<GithubDao>();

    diModule.registerLazySingleton<GithubRepository>(GithubRepositoryImpl(
      gitHubApiService: gitHubService,
      githubDao: githubDao,
    ));
  }

  Future<void> _registerViewModels() async {
    final githubRepository = diModule.get<GithubRepository>();

    diModule.registerFactory<LoginViewModel>(LoginViewModel());

    diModule.registerFactory<GithubRepoViewModel>(GithubRepoViewModel(
      githubRepository: githubRepository,
    ));
  }

  Future<void> removeDependencies() async {
    diModule.reset();
  }
}
