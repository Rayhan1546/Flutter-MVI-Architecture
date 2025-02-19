import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/domain/repositories/git_repository.dart';
import 'package:github_repo_list/domain/use_cases/git_repo_use_case.dart';

/// This class should always be LazySingleTon
class UseCaseRegisterModule {
  final diModule = DIModule();

  Future<void> registerUseCases() async {
    final gitRepository = diModule.get<GitRepository>();

    diModule.registerLazySingleton<GitRepoUseCase>(GitRepoUseCase(
      gitRepository: gitRepository,
    ));
  }
}
