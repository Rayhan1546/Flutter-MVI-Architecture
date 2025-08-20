import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';

abstract class AppStorageManager<T> {
  StorageInterface get storage;

  String get key;

  Future<void> saveValue(T value) async {
    await storage.save<T>(key, value);
  }

  Future<T?> getValue() async {
    final stringValue = await storage.get<T?>(key);

    return stringValue;
  }

  Future<bool> delete() async {
    try {
      await storage.remove(key);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAll() async {
    try {
      await storage.clear();
    } catch (e) {
      rethrow;
    }
  }
}
