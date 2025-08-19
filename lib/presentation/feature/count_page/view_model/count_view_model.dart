import 'package:github_repo_list/presentation/common/listener/listener_state.dart';
import 'package:github_repo_list/presentation/navigation/routes_config.dart';
import 'package:reeve_state/reeve/reeve.dart';

import 'count_state.dart';

class CountViewModel extends Reeve<CountState> {
  CountViewModel() : super(CountState.initial());

  void onViewReady() {
    Future.delayed(const Duration(seconds: 2), () {
      set(value.copyWith(isLoading: false));
    });
  }

  void incrementCounter() {
    set(value.copyWith(counter: value.counter + 1));
  }

  void decrementCounter() {
    if (value.counter > 0) {
      set(value.copyWith(counter: value.counter - 1));
    }
  }

  void resetCounter() {
    set(value.copyWith(counter: 0));
  }

  void reset2Counter() {
    set(value.copyWith());
  }

  void onTapCountNavButton() {
    set(value.copyWith(
      listenerState: NavigationState(routePath: RoutePaths.settings),
    ));
  }

  void showToast() {
    set(value.copyWith(
      listenerState: ToastMessageState(message: 'Hello'),
    ));
  }
}
