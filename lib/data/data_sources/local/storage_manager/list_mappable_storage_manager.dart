import 'package:github_repo_list/data/data_sources/local/storage_manager/app_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/mappable_mixin.dart';

abstract class ListMappableStorageManager<T> extends AppStorageManager
    with Mappable<T> {
  Future<List<T>?> getListFromStorage() async {
    final jsonList = await getValue();

    if (jsonList == null) return null;

    try {
      if (jsonList is List) {
        return jsonList.map((json) {
          return fromJson(json as Map<String, dynamic>);
        }).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveListToStorage(List<T> values) async {
    final jsonList = values.map((value) => toJson(value)).toList();
    await saveValue(jsonList);
  }

  Future<void> addToList(T value) async {
    final currentList = await getListFromStorage() ?? <T>[];
    currentList.add(value);
    await saveListToStorage(currentList);
  }

  Future<void> removeFromList(T value) async {
    final currentList = await getListFromStorage();
    if (currentList != null) {
      currentList.remove(value);
      await saveListToStorage(currentList);
    }
  }

  Future<void> removeFromListWhere(bool Function(T) test) async {
    final currentList = await getListFromStorage();
    if (currentList != null) {
      currentList.removeWhere(test);
      await saveListToStorage(currentList);
    }
  }

  Future<void> clearList() async {
    await saveListToStorage(<T>[]);
  }

  Future<bool> containsInList(T value) async {
    final currentList = await getListFromStorage();
    return currentList?.contains(value) ?? false;
  }

  Future<int> getListLength() async {
    final currentList = await getListFromStorage();
    return currentList?.length ?? 0;
  }

  Future<bool> isListEmpty() async {
    final length = await getListLength();
    return length == 0;
  }
}
