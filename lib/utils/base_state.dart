abstract class BaseState<T> {
  final bool showShimmer;

  BaseState({
    this.showShimmer = true,
  });

  T copyWith({
    bool? showShimmer,
  });

  T stopShimmer() {
    return copyWith(
      showShimmer: false,
    );
  }
}
