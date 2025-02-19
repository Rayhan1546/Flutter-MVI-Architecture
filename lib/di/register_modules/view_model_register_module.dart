import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/domain/use_cases/git_repo_use_case.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_view_model.dart';
import 'package:github_repo_list/presentation/feature/splash_page/splash_screen_view_model.dart';

///This class will always be factory
class ViewModelRegisterModule {
  final diModule = DIModule();

  Future<void> registerViewModels() async {
    final gitRepoUseCase = diModule.get<GitRepoUseCase>();

    diModule.registerFactory<SplashScreenViewModel>(SplashScreenViewModel());

    diModule.registerFactory<LoginViewModel>(LoginViewModel());

    diModule.registerFactory<GithubRepoViewModel>(GithubRepoViewModel(
      gitRepoUseCase: gitRepoUseCase,
    ));
  }
}
