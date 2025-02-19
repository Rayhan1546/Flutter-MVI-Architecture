import 'package:get_it/get_it.dart';

class DIModule {
  DIModule._internal();
  static final DIModule _instance = DIModule._internal();
  factory DIModule() => _instance;

  final _getIt = GetIt.instance;

  T get<T extends Object>() => _getIt<T>();

  void registerSingleton<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }

  void registerLazySingleton<T extends Object>(T instance) {
    _getIt.registerLazySingleton<T>(() => instance);
  }

  void registerFactory<T extends Object>(T instance) {
    _getIt.registerFactory<T>(() => instance);
  }

  Future<void> reset() async {
    await _getIt.reset();
  }
}
