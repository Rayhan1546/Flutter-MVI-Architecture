import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/common/enum/navigation_type.dart';

abstract class BaseViewModel<T extends BaseState<T>> {
  final _baseState = ValueNotifier<BaseState?>(null);

  ValueListenable<BaseState?> get baseState => _baseState;

  ValueListenable<T> getValue();
  ValueListenable<T> get stateListener => getValue();
  T get stateSetter => getValue().value;

  void navigate({
    required String routePage,
    required NavigationType navigationType,
  }) {
    _baseState.value = NavigationState(
      routePage: routePage,
      navigationType: navigationType,
    );
  }

  void onDispose() {
    _baseState.dispose();
  }
}
