import 'dart:convert';
import 'package:github_repo_list/data/data_sources/local/shared_preference/app_storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager extends AppStorageManager {
  final SharedPreferencesAsync preferencesAsync = SharedPreferencesAsync();

  SharedPrefManager._privateConstructor();

  static final SharedPrefManager _instance =
      SharedPrefManager._privateConstructor();

  factory SharedPrefManager() => _instance;

  @override
  Future<void> saveValue<T>(String key, T value) async {
    late final String stringValue;

    if (value is bool) {
      stringValue = value.toString();
    } else if (value is int) {
      stringValue = value.toString();
    } else if (value is double) {
      stringValue = value.toString();
    } else if (value is String) {
      stringValue = value;
    } else if (value is Map<String, dynamic>) {
      stringValue = jsonEncode(value);
    } else if (value is List) {
      stringValue = jsonEncode(value);
    } else {
      throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }

    await preferencesAsync.setString(key, stringValue);
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final stringValue = await preferencesAsync.getString(key);
    if (stringValue == null) return null;

    if (T == bool) {
      return (stringValue.toLowerCase() == 'true') as T?;
    } else if (T == int) {
      return int.tryParse(stringValue) as T?;
    } else if (T == double) {
      return double.tryParse(stringValue) as T?;
    } else if (T == String) {
      return stringValue as T?;
    } else if (T == Map<String, dynamic>) {
      try {
        return jsonDecode(stringValue) as T?;
      } catch (e) {
        return null;
      }
    } else if (T == List) {
      try {
        return jsonDecode(stringValue) as T?;
      } catch (e) {
        return null;
      }
    } else {
      throw ArgumentError('Unsupported type: $T');
    }
  }

  @override
  Future<bool> delete(String key) async {
    try {
      await preferencesAsync.remove(key);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await preferencesAsync.clear();
    } catch (e) {
      rethrow;
    }
  }
}
