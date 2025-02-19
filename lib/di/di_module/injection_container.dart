import 'package:github_repo_list/di/di_module/di_module.dart';
import 'package:github_repo_list/di/register_modules/api_service_injecter.dart';
import 'package:github_repo_list/di/register_modules/database_injecter.dart';
import 'package:github_repo_list/di/register_modules/repositories_injecter.dart';
import 'package:github_repo_list/di/register_modules/use_case_injecter.dart';
import 'package:github_repo_list/di/register_modules/view_model_injecter.dart';

class InjectionContainer {
  InjectionContainer._internal();
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;

  final diModule = DIModule();

  Future<void> injectDependencies() async {
    await DatabaseInjecter().registerDatabase();
    await ApiServiceInjecter().registerApiServices();
    await RepositoriesInjecter().registerRepositories();
    await UseCaseInjecter().registerUseCases();
    await ViewModelInjecter().registerViewModels();
  }

  Future<void> removeDependencies() async {
    diModule.reset();
  }
}
