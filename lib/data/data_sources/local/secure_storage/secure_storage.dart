import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/storage_interface.dart';

class SecureStorage extends StorageInterface {
  SecureStorage._privateConstructor();

  static final SecureStorage _instance = SecureStorage._privateConstructor();

  factory SecureStorage() => _instance;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> save<T>(String key, T value) async {
    String stringValue;

    if (value is String) {
      stringValue = value;
    } else if (value is int || value is double || value is bool) {
      stringValue = value.toString();
    } else if (value is Map<String, dynamic>) {
      stringValue = jsonEncode(value);
    } else if (value is List<T>) {
      stringValue = jsonEncode(value);
    } else {
      stringValue = value.toString();
    }

    await _secureStorage.write(key: key, value: stringValue);
  }

  @override
  Future<T?> get<T>(String key) async {
    final value = await _secureStorage.read(key: key);

    if (value == null) return null;

    if (T == String) {
      return value as T?;
    } else if (T == int) {
      return int.tryParse(value) as T?;
    } else if (T == double) {
      return double.tryParse(value) as T?;
    } else if (T == bool) {
      return (value.toLowerCase() == 'true') as T?;
    } else if (T == Map<String, dynamic>) {
      try {
        return jsonDecode(value) as T?;
      } catch (e) {
        throw ArgumentError('Failed to decode JSON: $e');
      }
    } else {
      try {
        return jsonDecode(value) as T?;
      } catch (e) {
        throw ArgumentError('Failed to decode JSON: $e');
      }
    }
  }

  @override
  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
