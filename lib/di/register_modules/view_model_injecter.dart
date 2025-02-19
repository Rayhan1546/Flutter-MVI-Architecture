import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/domain/repositories/github_repository.dart';
import 'package:github_repo_list/presentation/feature/github_repo_page/github_repo_view_model.dart';
import 'package:github_repo_list/presentation/feature/login_page/login_view_model.dart';
import 'package:github_repo_list/presentation/feature/splash_page/splash_screen_view_model.dart';

///This class will always be factory
class ViewModelInjecter {
  final diModule = DIModule();

  Future<void> registerViewModels() async {
    final githubRepository = diModule.get<GithubRepository>();

    diModule.registerFactory<SplashScreenViewModel>(SplashScreenViewModel());

    diModule.registerFactory<LoginViewModel>(LoginViewModel());

    diModule.registerFactory<GithubRepoViewModel>(GithubRepoViewModel(
      githubRepository: githubRepository,
    ));
  }
}
