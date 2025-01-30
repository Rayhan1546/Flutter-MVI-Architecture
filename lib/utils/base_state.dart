abstract class BaseState<T> {
  final bool showShimmer;
  final bool showToast;
  final String? toastMessage;

  BaseState({
    this.showShimmer = true,
    this.showToast = true,
    this.toastMessage,
  });

  T copyWith({
    bool? showToast,
    String? toastMessage,
    bool? showShimmer,
  });

  T showToastMessage(String message) {
    return copyWith(
      showToast: true,
      toastMessage: message,
    );
  }

  T resetToastValues() {
    return copyWith(
      showToast: false,
      toastMessage: null,
    );
  }

  T stopShimmer() {
    return copyWith(
      showShimmer: false,
    );
  }
}
