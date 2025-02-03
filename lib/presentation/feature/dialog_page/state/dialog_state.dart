import 'package:github_repo_list/presentation/base/base_state.dart';
import 'package:github_repo_list/presentation/common/enum/navigation_type.dart';

class DialogStates extends BaseState<DialogStates> {
  final bool showButton;
  final bool shouldNavigate;
  final bool isLoading;

  DialogStates({
    this.showButton = false,
    this.shouldNavigate = false,
    this.isLoading = true,
  });

  @override
  DialogStates copyWith({
    bool? isLoading,
    bool? showButton,
    bool? shouldNavigate,
    bool? navigate,
    String? routePage,
    NavigationType? navigationType,
  }) {
    return DialogStates(
      showButton: showButton ?? this.showButton,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
