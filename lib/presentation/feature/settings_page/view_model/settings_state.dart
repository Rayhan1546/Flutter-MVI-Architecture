import 'package:github_repo_list/presentation/base/base_state.dart';

class SettingsState extends BaseState<SettingsState> {
  final int counter;

  SettingsState({
    required this.counter,
  });

  factory SettingsState.initial() {
    return SettingsState(
      counter: 0,
    );
  }

  @override
  SettingsState copyWith({
    int? counter,
  }) {
    return SettingsState(
      counter: counter ?? this.counter,
    );
  }
}
