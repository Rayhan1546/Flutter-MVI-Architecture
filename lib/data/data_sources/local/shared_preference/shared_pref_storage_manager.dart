import 'package:github_repo_list/data/data_sources/local/shared_preference/app_storage_manager.dart';
import 'package:github_repo_list/data/data_sources/local/shared_preference/shared_pref_manager.dart';

mixin Mappable<T> {
  Map<String, dynamic> toJson(T value);

  T fromJson(Map<String, dynamic> json);
}

abstract class SharedPrefStorageManager<T> with Mappable<T> {
  String get key;

  final AppStorageManager appStorageManager = SharedPrefManager();

  Future<T?> getFromSharedPref() async {
    final json = await appStorageManager.getValue<Map<String, dynamic>>(key);

    if (json == null) return null;

    return fromJson(json);
  }

  Future<void> saveToSharedPref(T value) async {
    final json = toJson(value);

    await appStorageManager.saveValue<Map<String, dynamic>>(key, json);
  }
}
