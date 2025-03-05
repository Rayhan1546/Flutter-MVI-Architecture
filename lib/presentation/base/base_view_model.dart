import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/base/base_argument.dart';
import 'package:github_repo_list/presentation/base/base_state.dart';

abstract class BaseViewModel<A extends BaseArgument, S extends BaseState> {
  final _baseState = ValueNotifier<BaseState?>(null);
  final ValueNotifier<S> _state;

  ValueListenable<BaseState?> get baseState => _baseState;
  ValueListenable<S> get stateListener => _state;

  @protected
  S get state => _state.value;

  BaseViewModel(S initialState) : _state = ValueNotifier(initialState);

  void onViewReady({A? argument}) {}

  @protected
  void updateState(S newState) {
    _state.value = newState;
  }

  @protected
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

  @protected
  void showConfirmationDialog({
    required String title,
    required String subTitle,
    required String rightBtnText,
    required String leftBtnText,
    required VoidCallback onTapRightBtn,
    required VoidCallback onTapLeftBtn,
    required IconData icon,
  }) {
    _baseState.value = ConfirmationDialogState(
      title: title,
      subTitle: subTitle,
      rightBtnText: rightBtnText,
      leftBtnText: leftBtnText,
      onTapRightBtn: onTapRightBtn,
      onTapLeftBtn: onTapLeftBtn,
      icon: icon,
    );
  }

  void onDispose() {
    _baseState.dispose();
    _state.dispose();
  }
}
