import 'package:github_repo_list/utils/base_state.dart';

class DialogStates extends BaseState<DialogStates> {
  final bool showButton;
  final bool shouldNavigate;

  DialogStates({
    this.showButton = false,
    this.shouldNavigate = false,
    super.showShimmer,
  });

  @override
  DialogStates copyWith({
    bool? showShimmer,
    bool? showButton,
    bool? shouldNavigate,
  }) {
    return DialogStates(
      showButton: showButton ?? this.showButton,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
      showShimmer: showShimmer ?? this.showShimmer,
    );
  }
}
