abstract class StorageInterface {
  Future<void> save(String key, String value);

  Future<String?> get(String key);

  Future<void> remove(String key);

  Future<void> clear();
}