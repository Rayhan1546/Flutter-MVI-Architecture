import 'package:github_repo_list/presentation/base/base_state.dart';

class UserProfileState extends BaseState<UserProfileState> {
  final int counter;
  
  UserProfileState({
    required this.counter,
  });

  factory UserProfileState.initial() {
    return UserProfileState(
      counter: 0,
    );
  }

  @override
  UserProfileState copyWith({
    int? counter,
  }) {
    return UserProfileState(
      counter: counter ?? this.counter,
    );
  }
}
