import 'package:github_repo_list/data/data_sources/local/drift/app_database/app_database.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';

class DriftStorageInterface implements StorageInterface {
  DriftStorageInterface._privateConstructor();

  static final DriftStorageInterface _instance =
      DriftStorageInterface._privateConstructor();

  factory DriftStorageInterface() => _instance;

  final AppDatabase _database = AppDatabase();

  @override
  Future<void> save(String key, String value) {
    // TODO: implement setString
    throw UnimplementedError();
  }

  @override
  Future<String?> get(String key) {
    // TODO: implement getString
    throw UnimplementedError();
  }

  @override
  Future<void> remove(String key) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }
}
