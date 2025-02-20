import 'package:github_repo_list/data/data_sources/local/hive/data_manager.dart';

class ThemeManager extends DataManager<String> {
  @override
  String storeKey = 'Theme_data';

  @override
  Future<void> saveValue(String value) {
    return storage.write(key: storeKey, value: value);
  }

  @override
  Future<String?> getValue() {
    return storage.read(key: storeKey);
  }

  @override
  Future<void> deleteValue() {
    return storage.delete(key: storeKey);
  }
}
