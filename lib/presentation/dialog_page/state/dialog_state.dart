import 'package:github_repo_list/utils/base_state.dart';

class DialogStates extends BaseState {
  final bool showButton;
  final bool shouldNavigate;

  DialogStates({
    this.showButton = false,
    this.shouldNavigate = false,
    super.showShimmer,
    super.showToast,
    super.toastMessage,
  });

  @override
  DialogStates copyWith({
    bool? showToast,
    String? toastMessage,
    bool? showShimmer,
    bool? showButton,
    bool? shouldNavigate,
  }) {
    return DialogStates(
      showButton: showButton ?? this.showButton,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
      showToast: showToast ?? this.showToast,
      showShimmer: showShimmer ?? this.showShimmer,
      toastMessage: toastMessage ?? this.toastMessage,
    );
  }
}
