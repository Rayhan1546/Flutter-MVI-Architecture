import 'package:flutter/foundation.dart';

class Reeve<T> extends ChangeNotifier implements ValueListenable<T> {
  Reeve(this._value);

  @override
  T get value => _value;
  T _value;

  void set(T newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }
}
