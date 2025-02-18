import 'package:github_repo_list/presentation/base/base_argument.dart';

abstract class BaseState<T> {
  BaseState();

  T copyWith();
}

class NavigateState extends BaseState<NavigateState> {
  final String routePath;
  final BaseArgument arguments;
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
    throw UnimplementedError();
  }
}
