import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class DataManager<T> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  abstract String storeKey;

  Future<void> saveValue(T value);
  Future<T?> getValue();
  Future<void> deleteValue();
}
