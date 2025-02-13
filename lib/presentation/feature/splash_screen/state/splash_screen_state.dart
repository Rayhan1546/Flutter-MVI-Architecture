import 'package:github_repo_list/presentation/base/base_state.dart';

class SplashScreenState extends BaseState<SplashScreenState> {
  final bool isLoggedIn;

  SplashScreenState({
    required this.isLoggedIn,
  });

  factory SplashScreenState.inital() {
    return SplashScreenState(
      isLoggedIn: false,
    );
  }

  @override
  SplashScreenState copyWith({
    bool? isLoggedIn,
  }) {
    return SplashScreenState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
