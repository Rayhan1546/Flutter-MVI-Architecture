import 'dart:convert';
import 'package:github_repo_list/data/data_sources/local/drift/app_database/app_database.dart';
import 'package:github_repo_list/data/data_sources/local/drift/config_database/app_config_dao.dart';

abstract class ConfigManager<T> {
  final AppConfigDao dao = AppConfigDao(AppDatabase());

  String get key;

  Future<void> saveValue(T value) async {
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
    } else {
      throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }

    await dao.setConfig(key, stringValue);
  }

  Future<T?> getValue() async {
    final stringValue = await dao.getConfig(key);
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
    } else {
      throw ArgumentError('Unsupported type: $T');
    }
  }

  Future<bool> delete() async {
    return await dao.removeConfig(key);
  }

  Future<void> clearAllConfiguration() async {
    return await dao.clearAllConfigs();
  }
}
