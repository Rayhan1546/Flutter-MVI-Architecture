import 'package:github_repo_list/presentation/common/listener/listener_state.dart';

class CountState {
  final int counter;
  final int counter2;
  final bool isLoading;
  final ListenerState listenerState;

  CountState({
    required this.counter,
    required this.counter2,
    required this.isLoading,
    required this.listenerState,
  });

  factory CountState.initial() {
    return CountState(
      counter: 0,
      counter2: 2,
      isLoading: true,
      listenerState: EmptyState(),
    );
  }

  CountState copyWith({
    int? counter,
    int? counter2,
    bool? isLoading,
    ListenerState? listenerState,
  }) {
    return CountState(
      counter: counter ?? this.counter,
      counter2: counter2 ?? this.counter2,
      isLoading: isLoading ?? this.isLoading,
      listenerState: listenerState ?? this.listenerState,
    );
  }
}
