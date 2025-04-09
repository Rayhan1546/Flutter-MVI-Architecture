import 'package:flutter/material.dart';
import 'package:reeve_state/reeve/reeve_injecter.dart';

extension ReeveContextExtension on BuildContext {
  T getReeve<T>() {
    final provider = dependOnInheritedWidgetOfExactType<ReeveInjecter<T>>();
    assert(provider != null, 'No BaseProvider<$T> found in context');
    return provider!.inject;
  }
}
