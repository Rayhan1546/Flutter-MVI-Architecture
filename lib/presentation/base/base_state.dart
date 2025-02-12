import 'package:github_repo_list/presentation/base/base_arguments.dart';

abstract class BaseState<T> {
  BaseState();

  T copyWith();
}

class NavigateState extends BaseState<NavigateState> {
  final String routePath;
  final BaseArguments arguments;
  final bool isReplace;
  final bool isClearBackStack;

  NavigateState({
    required this.routePath,
    required this.arguments,
    required this.isReplace,
    required this.isClearBackStack,
  });

  @override
  NavigateState copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
