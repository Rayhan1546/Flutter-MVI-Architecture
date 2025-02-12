import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/base/base_arguments.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';

abstract class BaseViewModel {
  final _baseState = ValueNotifier<BaseState?>(null);

  ValueListenable<BaseState?> get baseState => _baseState;

  void navigateTo({
    required String routePath,
    required BaseArguments arguments,
    bool isReplace = false,
    bool isClearBackStack = false,
  }) {
    _baseState.value = NavigateState(
      routePath: routePath,
      arguments: arguments,
      isReplace: isReplace,
      isClearBackStack: isClearBackStack,
    );
  }

  void onDispose() {
    _baseState.dispose();
  }
}
