import 'package:github_repo_list/presentation/base/base_view_model.dart';
import 'user_profile_state.dart';
import 'user_profile_intent.dart';

class UserProfileViewModel extends BaseViewModel<UserProfileState> {
  UserProfileViewModel() : super(UserProfileState.initial());

  @override
  void onViewReady();
  
  void dispatchIntent(UserProfileIntent intent) {
    if (intent is IncrementCounterIntent) {
      _incrementCounter();
    } else if (intent is DecrementCounterIntent) {
      _decrementCounter();
    } else if (intent is ResetCounterIntent) {
      _resetCounter();
    }
  }

  void _incrementCounter() {
    updateState(state.copyWith(
      counter: state.counter + 1,
    ));
  }

  void _decrementCounter() {
    if (state.counter > 0) {
      updateState(state.copyWith(
        counter: state.counter - 1,
      ));
    }
  }

  void _resetCounter() {
    updateState(state.copyWith(counter: 0));
  }
}
