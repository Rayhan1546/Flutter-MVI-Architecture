import 'package:flutter/foundation.dart';
import 'package:github_repo_list/presentation/feature/dialog_page/state/dialog_state.dart';

class DialogViewModel {
  final _dialogSates = ValueNotifier<DialogStates>(DialogStates());

  ValueListenable<DialogStates> get dialogStates => _dialogSates;

  DialogStates get _states => _dialogSates.value;

  DialogViewModel() {
    showShimmer();
  }

  void showShimmer() {
    Future.delayed(const Duration(seconds: 3), () {
      _dialogSates.value = _states.stopShimmer();
    });
  }

  void navigate() {
    _dialogSates.value = _states.copyWith(
      shouldNavigate: true,
    );
  }

  void onDispose() {
    _dialogSates.dispose();
  }
}
