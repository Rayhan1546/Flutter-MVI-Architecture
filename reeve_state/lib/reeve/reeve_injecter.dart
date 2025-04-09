import 'package:flutter/material.dart';

class ReeveInjecter<T> extends InheritedWidget {
  final T inject;

  const ReeveInjecter({
    super.key,
    required this.inject,
    required super.child,
  });

  static T of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ReeveInjecter<T>>();
    if (provider == null) {
      throw FlutterError(
        'No ReeveInjecter<$T> found in context. '
        'Make sure you have wrapped your widget tree with ReeveInjecter<$T>.',
      );
    }
    return provider.inject;
  }

  @override
  bool updateShouldNotify(ReeveInjecter<T> oldWidget) {
    return inject != oldWidget.inject;
  }
}
