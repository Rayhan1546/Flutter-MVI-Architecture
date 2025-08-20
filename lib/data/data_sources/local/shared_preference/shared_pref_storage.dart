import 'dart:convert';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorage implements StorageInterface {
  SharedPrefStorage._privateConstructor();

  static final SharedPrefStorage _instance =
      SharedPrefStorage._privateConstructor();

  factory SharedPrefStorage() => _instance;

  final SharedPreferencesAsync _preferencesAsync = SharedPreferencesAsync();

  @override
  Future<void> save<T>(String key, T value) async {
    if (value is String) {
      await _preferencesAsync.setString(key, value);
    } else if (value is int) {
      await _preferencesAsync.setInt(key, value);
    } else if (value is double) {
      await _preferencesAsync.setDouble(key, value);
    } else if (value is bool) {
      await _preferencesAsync.setBool(key, value);
    } else if (value is Map<String, dynamic>) {
      await _preferencesAsync.setString(key, jsonEncode(value));
    } else if (value is List<T>) {
      await _preferencesAsync.setString(key, jsonEncode(value));
    } else {
      throw UnsupportedError('Type ${T.toString()} is not supported');
    }
  }

  @override
  Future<T?> get<T>(String key) async {
    if (T == String) {
      return await _preferencesAsync.getString(key) as T?;
    } else if (T == int) {
      return await _preferencesAsync.getInt(key) as T?;
    } else if (T == double) {
      return await _preferencesAsync.getDouble(key) as T?;
    } else if (T == bool) {
      return await _preferencesAsync.getBool(key) as T?;
    } else if (T == Map<String, dynamic>) {
      final stringValue = await _preferencesAsync.getString(key);
      if (stringValue != null) {
        try {
          return jsonDecode(stringValue) as T?;
        } catch (e) {
          throw ArgumentError('Unsupported type: $T');
        }
      }
      return null;
    } else {
      final stringValue = await _preferencesAsync.getString(key);

      if (stringValue != null) {
        try {
          return jsonDecode(stringValue) as T?;
        } catch (e) {
          throw ArgumentError('Unsupported type: $T');
        }
      }
      return null;
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      await _preferencesAsync.remove(key);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clear() async => await _preferencesAsync.clear();
}
