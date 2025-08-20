import 'package:github_repo_list/data/data_sources/local/storage_manager/app_storage_manager.dart';

mixin Mappable<T> {
  Map<String, dynamic> toJson(T value);

  T fromJson(Map<String, dynamic> json);
}

abstract class MappableStorageManager<T> extends AppStorageManager
    with Mappable<T> {
  Future<T?> getFromStorage() async {
    final json = await getValue<Map<String, dynamic>>();

    if (json == null) return null;

    return fromJson(json);
  }

  Future<void> saveToStorage(T value) async {
    final json = toJson(value);

    await saveValue<Map<String, dynamic>>(json);
  }
}
