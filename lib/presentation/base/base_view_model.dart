import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/base/base_argument.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';

abstract class BaseViewModel<A extends BaseArgument> {
  final _baseState = ValueNotifier<BaseState?>(null);

  ValueListenable<BaseState?> get baseState => _baseState;

  void onViewReady({A? argument}) {}

  void navigateTo({
    required String routePath,
    required BaseArgument arguments,
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
