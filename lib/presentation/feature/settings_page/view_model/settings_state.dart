import 'package:github_repo_list/presentation/common/listener/listener_state.dart';

class SettingsState {
  final ListenerState listenerState;

  SettingsState({
    required this.listenerState,
  });

  factory SettingsState.initial() {
    return SettingsState(listenerState: EmptyState());
  }

  SettingsState copyWith({
    ListenerState? listenerState,
  }) {
    return SettingsState(
      listenerState: listenerState ?? this.listenerState,
    );
  }
}
