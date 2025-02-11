extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> copyWithMap() => Map.from(this);

  Map<K, V> addItem(K key, V value) => {...this, key: value};

  Map<K, V> addItems(Map<K, V> items) => {...this, ...items};

  Map<K, V> removeKey(K key) {
    final map = copyWithMap();
    map.remove(key);
    return map;
  }

  Map<K, V> updateItem(K key, V value) => {...this}..update(key, (_) => value);

  Map<K, V> clear() => {};

  Map<K, V> updateWhere(
    bool Function(K key, V value) condition,
    V Function(V value) update,
  ) {
    final map = copyWithMap();
    map.forEach((key, value) {
      if (condition(key, value)) {
        map[key] = update(value);
      }
    });
    return map;
  }
}
