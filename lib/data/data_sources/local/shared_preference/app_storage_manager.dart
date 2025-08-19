abstract class AppStorageManager {
  Future<void> saveValue<T>(String key, T value);

  Future<T?> getValue<T>(String key);

  Future<bool> delete(String key);

  Future<void> clearAll();
}
