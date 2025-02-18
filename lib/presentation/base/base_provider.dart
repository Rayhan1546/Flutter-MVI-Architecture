import 'package:flutter/material.dart';

class BaseProvider<T> extends InheritedWidget {
  final T viewModel;

  const BaseProvider({
    super.key,
    required this.viewModel,
    required super.child,
  });

  static T of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BaseProvider<T>>();
    assert(provider != null, 'No BaseProvider<$T> found in context');
    return provider!.viewModel;
  }

  @override
  bool updateShouldNotify(BaseProvider<T> oldWidget) {
    return viewModel != oldWidget.viewModel;
  }
}
