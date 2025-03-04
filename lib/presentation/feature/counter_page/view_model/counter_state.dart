import 'package:github_repo_list/presentation/base/base_state.dart';

class CounterState extends BaseState<CounterState> {
  final int counter;
  
  CounterState({
    required this.counter,
  });

  factory CounterState.initial() {
    return CounterState(
      counter: 0,
    );
  }

  @override
  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}
