import 'package:github_repo_list/state_handler/navigation_type.dart';

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
