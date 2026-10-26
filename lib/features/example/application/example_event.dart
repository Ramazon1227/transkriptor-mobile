part of 'example_bloc.dart';

sealed class ExampleEvent {
  const ExampleEvent();
}

/// First load. [userId] is the initial filter, passed in from outside.
final class ExampleStarted extends ExampleEvent {
  const ExampleStarted({this.userId});

  final int? userId;
}

/// Filter change. `null` means every user.
final class ExampleUserChanged extends ExampleEvent {
  const ExampleUserChanged(this.userId);

  final int? userId;
}

/// Reload with the current filter (pull to refresh, retry).
final class ExampleRefreshed extends ExampleEvent {
  const ExampleRefreshed();
}
