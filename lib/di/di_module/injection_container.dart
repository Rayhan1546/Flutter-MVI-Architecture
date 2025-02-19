import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/di/register_modules/api_service_register_module.dart';
import 'package:github_repo_list/di/register_modules/database_register_module.dart';
import 'package:github_repo_list/di/register_modules/repositories_register_module.dart';
import 'package:github_repo_list/di/register_modules/use_case_register_module.dart';
import 'package:github_repo_list/di/register_modules/view_model_register_module.dart';

class InjectionContainer {
  InjectionContainer._internal();
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;

  final diModule = DIModule();

  Future<void> injectDependencies() async {
    await DatabaseRegisterModule().registerDatabase();
    await ApiServiceRegisterModule().registerApiServices();
    await RepositoriesRegisterModule().registerRepositories();
    await UseCaseRegisterModule().registerUseCases();
    await ViewModelRegisterModule().registerViewModels();
  }

  Future<void> removeDependencies() async {
    diModule.reset();
  }
}
