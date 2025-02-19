import 'package:github_repo_list/data/data_sources/local/drift_database/app_database.dart';
import 'package:github_repo_list/data/data_sources/local/drift_database/github_database/github_dao.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';

/// This class should always be LazySingleTon
class DatabaseInjecter {
  final diModule = DIModule();

  Future<void> registerDatabase() async {
    diModule.registerLazySingleton<GithubDao>(GithubDao(AppDatabase()));
  }
}