import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/common/enum/navigation_type.dart';
import 'package:github_repo_list/presentation/navigation/route_params.dart';

abstract class BaseViewModel<T extends BaseState<T>> {
  final _baseState = ValueNotifier<BaseState?>(null);

  ValueListenable<BaseState?> get baseState => _baseState;

  ValueListenable<T> getValue();
  ValueListenable<T> get stateListener => getValue();
  T get stateSetter => getValue().value;


  void navigateTo({
    required String routePath,
    required RouteParams routeParams,
    bool isReplace = false,
    bool isClearBackStack = false,
  }) {
    _baseState.value = NavigateState(
      routePath: routePath,
      routeParams: routeParams,
      isReplace: isReplace,
      isClearBackStack: isClearBackStack,
    );
  }

  void onDispose() {
    _baseState.dispose();
  }
}
