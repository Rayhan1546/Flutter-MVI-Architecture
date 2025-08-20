import 'dart:convert';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';

abstract class AppStorageManager {
  StorageInterface get storage;

  String get key;

  Future<void> saveValue<T>(T value) async {
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

    await storage.save(key, stringValue);
  }

  Future<T?> getValue<T>() async {
    final stringValue = await storage.get(key);
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
