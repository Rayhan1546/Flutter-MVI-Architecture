import 'package:github_repo_list/data/data_sources/remote/git_api_service.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';

/// This class should always be LazySingleTon
class ApiServiceInjecter {
  final diModule = DIModule();

  Future<void> registerApiServices() async {
    diModule.registerLazySingleton<GitApiService>(GitApiService());
  }
}