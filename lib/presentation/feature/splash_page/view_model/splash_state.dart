import 'package:github_repo_list/presentation/base/base_state.dart';

class SplashState extends BaseState<SplashState> {
  final bool isLoggedIn;

  SplashState({
    required this.isLoggedIn,
  });

  factory SplashState.inital() {
    return SplashState(
      isLoggedIn: false,
    );
  }

  @override
  SplashState copyWith({
    bool? isLoggedIn,
  }) {
    return SplashState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
