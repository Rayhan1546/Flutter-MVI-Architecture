import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:github_repo_list/presentation/base/base_argument.dart';

abstract class BaseState<T> {
  BaseState();

  T copyWith();
}

class NavigateState extends BaseState<NavigateState> {
  final String routePath;
  final BaseArgument? arguments;
  final bool isReplace;
  final bool isClearBackStack;

  NavigateState({
    required this.routePath,
    this.arguments,
    required this.isReplace,
    required this.isClearBackStack,
  });

  @override
  NavigateState copyWith() {
    throw UnimplementedError();
  }
}

class ConfirmationDialogState extends BaseState<ConfirmationDialogState> {
  final String title;
  final String subTitle;
  final String rightBtnText;
  final String leftBtnText;
  final VoidCallback onTapRightBtn;
  final VoidCallback onTapLeftBtn;
  final IconData icon;

  ConfirmationDialogState({
    required this.title,
    required this.subTitle,
    required this.rightBtnText,
    required this.leftBtnText,
    required this.onTapRightBtn,
    required this.onTapLeftBtn,
    required this.icon,
  });

  @override
  ConfirmationDialogState copyWith() {
    throw UnimplementedError();
  }
}
