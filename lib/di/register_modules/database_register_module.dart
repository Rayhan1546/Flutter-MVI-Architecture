import 'package:github_repo_list/data/data_sources/local/drift/app_database/app_database.dart';
import 'package:github_repo_list/data/data_sources/local/drift/github_database/github_dao.dart';
import 'package:github_repo_list/data/data_sources/local/shared_preference/pref_github_repo_storage.dart';
import 'package:github_repo_list/data/data_sources/local/sqflite/gitub_repo_storage_manager.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';

/// This class should always be LazySingleTon
class DatabaseRegisterModule {
  final diModule = DIModule();

  Future<void> registerDatabase() async {
    diModule.registerLazySingleton<GithubDao>(GithubDao(AppDatabase()));

    diModule.registerLazySingleton<GithubRepoStorageManager>(
      GithubRepoStorageManager(),
    );

    diModule.registerLazySingleton<PrefGithubRepoStorageManager>(
      PrefGithubRepoStorageManager(),
    );
  }
}
