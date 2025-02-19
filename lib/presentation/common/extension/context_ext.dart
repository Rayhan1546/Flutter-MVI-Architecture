import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_provider.dart';

extension ViewModelContext on BuildContext {
  T getViewModel<T>() {
    final provider = dependOnInheritedWidgetOfExactType<BaseProvider<T>>();
    assert(provider != null, 'No BaseProvider<$T> found in context');
    return provider!.viewModel;
  }
}
