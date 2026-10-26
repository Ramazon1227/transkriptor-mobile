part of 'library_bloc.dart';

sealed class LibraryEvent {
  const LibraryEvent();
}

/// First load. [workspaceId] comes from the signed-in account.
final class LibraryStarted extends LibraryEvent {
  const LibraryStarted(this.workspaceId);

  final String workspaceId;
}

/// Pull to refresh, retry, or back from a finished job.
final class LibraryRefreshed extends LibraryEvent {
  const LibraryRefreshed();
}
