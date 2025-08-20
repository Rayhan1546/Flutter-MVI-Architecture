import 'package:github_repo_list/data/data_sources/local/storage_manager/app_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/mappable_mixin.dart';

abstract class JsonMappableStorageManager<T> extends AppStorageManager
    with MappableMixin<T> {
  Future<T?> getFromStorage() async {
    final json = await getValue();

    if (json == null) return null;

    return fromJson(json);
  }

  Future<void> saveToStorage(T value) async {
    final json = toJson(value);

    await saveValue(json);
  }
}
