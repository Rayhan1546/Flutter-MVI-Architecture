import 'package:github_repo_list/presentation/common/enum/navigation_type.dart';
import 'package:github_repo_list/presentation/navigation/route_params.dart';

abstract class BaseState<T> {
  BaseState();

  T copyWith();
}

class NavigationState extends BaseState<NavigationState> {
  final String routePage;
  final NavigationType navigationType;

  NavigationState({
    required this.routePage,
    required this.navigationType,
  });

  @override
  NavigationState copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class NavigateState extends BaseState<NavigationState> {
  final String routePath;
  final RouteParams routeParams;
  final bool isReplace;
  final bool isClearBackStack;

  NavigateState({
    required this.routePath,
    required this.routeParams,
    required this.isReplace,
    required this.isClearBackStack,
  });

  @override
  NavigationState copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
