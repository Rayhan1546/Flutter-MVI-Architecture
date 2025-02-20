import 'package:github_repo_list/data/data_sources/local/app_config/login_state_manager.dart';
import 'package:github_repo_list/data/data_sources/local/app_config/token_manager.dart';
import 'package:github_repo_list/di/di_module/di_module.dart';

class ConfigManagerRegisterModule {
  final diModule = DIModule();

  Future<void> registerConfigManager() async {
    diModule.registerLazySingleton<LoginStateManager>(LoginStateManager());

    diModule.registerSingleton<TokenManager>(TokenManager());
  }
}
