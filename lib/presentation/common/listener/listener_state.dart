sealed class ListenerState {}

class EmptyState extends ListenerState {}

class ToastMessageState extends ListenerState {
  final String message;

  ToastMessageState({required this.message});
}

class NavigationState extends ListenerState {
  final String routePath;

  NavigationState({required this.routePath});
}
