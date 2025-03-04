import 'package:github_repo_list/presentation/base/base_view_model.dart';
import '../argument/counter_argument.dart';
import 'counter_state.dart';
import 'counter_intent.dart';

class CounterViewModel extends BaseViewModel<CounterArgument, CounterState> {
  CounterViewModel() : super(CounterState.initial());

  @override
  void onViewReady({CounterArgument? argument}) {}

  void dispatchIntent(CounterIntent intent) {
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
