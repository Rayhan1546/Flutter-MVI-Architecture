import 'package:get_it/get_it.dart';

class GetItModule {
  GetItModule._internal();
  static final GetItModule _instance = GetItModule._internal();
  factory GetItModule() => _instance;

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
