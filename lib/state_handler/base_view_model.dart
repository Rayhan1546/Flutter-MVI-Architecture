import 'package:flutter/foundation.dart';
import 'package:github_repo_list/state_handler/base_state.dart';
import 'package:github_repo_list/state_handler/navigation_type.dart';

abstract class BaseViewModel {
  final _baseState = ValueNotifier<BaseState?>(null);

  ValueListenable<BaseState?> get baseState => _baseState;

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
