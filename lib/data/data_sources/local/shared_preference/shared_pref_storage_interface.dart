import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorageInterface implements StorageInterface {
  SharedPrefStorageInterface._privateConstructor();

  static final SharedPrefStorageInterface _instance =
      SharedPrefStorageInterface._privateConstructor();

  factory SharedPrefStorageInterface() => _instance;

  final SharedPreferencesAsync _preferencesAsync = SharedPreferencesAsync();

  @override
  Future<void> save(String key, String value) async {
    await _preferencesAsync.setString(key, value);
  }

  @override
  Future<String?> get(String key) async {
    return await _preferencesAsync.getString(key);
  }

  @override
  Future<void> remove(String key) async {
    await _preferencesAsync.remove(key);
  }

  @override
  Future<void> clear() async {
    await _preferencesAsync.clear();
  }
}
