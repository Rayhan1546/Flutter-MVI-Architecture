extension ListExtension<T> on List<T> {
  List<T> copyWithList() => List.from(this);

  List<T> addItem(T item) => [...this, item];

  List<T> addItems(List<T> items) => [...this, ...items];

  List<T> removeItem(T item) => where((element) => element != item).toList();

  List<T> removeAt(int index) {
    final list = copyWithList();
    list.removeAt(index);
    return list;
  }

  List<T> replaceItem(T oldItem, T newItem) {
    return map((item) => item == oldItem ? newItem : item).toList();
  }

  List<T> replaceItemAt(int index, T item) {
    final list = copyWithList();
    list[index] = item;
    return list;
  }

  List<T> clearList() => [];

  List<T> insertAt(int index, T item) {
    final list = copyWithList();
    list.insert(index, item);
    return list;
  }

  List<T> updateWhere(
    bool Function(T element) condition,
    T Function(T element) update,
  ) {
    return map((item) => condition(item) ? update(item) : item).toList();
  }
}
