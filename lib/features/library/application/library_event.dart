part of 'library_bloc.dart';

sealed class LibraryEvent {
  const LibraryEvent();
}

/// Events that fetch the list. They share one restartable handler, so a
/// late answer never overwrites a newer one.
sealed class LibraryLoadEvent extends LibraryEvent {
  const LibraryLoadEvent();
}

/// First load. [workspaceId] comes from the signed-in account.
final class LibraryStarted extends LibraryLoadEvent {
  const LibraryStarted(this.workspaceId);

  final String workspaceId;
}

/// Pull to refresh, retry, or back from a finished job.
final class LibraryRefreshed extends LibraryLoadEvent {
  const LibraryRefreshed();
}

/// Show one folder's files; null shows every file.
final class LibraryFolderSelected extends LibraryLoadEvent {
  const LibraryFolderSelected(this.folderId);

  final String? folderId;
}

/// Show one source tab's files. Like a folder, it is another list.
final class LibrarySourceSelected extends LibraryLoadEvent {
  const LibrarySourceSelected(this.source);

  final FilesSource source;
}

/// The search field: after a short pause the list reloads from the top
/// with `q`. The previous rows stay until the answer.
final class LibraryQueryChanged extends LibraryLoadEvent {
  const LibraryQueryChanged(this.query);

  final String query;
}

/// Reload the list from the top with one tag; null clears it. The previous
/// rows stay until the answer.
final class LibraryTagSelected extends LibraryLoadEvent {
  const LibraryTagSelected(this.tag);

  final String? tag;
}

/// The end of the list came near: fetch the next page, if there is one.
final class LibraryMoreRequested extends LibraryLoadEvent {
  const LibraryMoreRequested();
}

/// The workspace's tag list arrived. Not a load event: it must not cancel
/// the list's own request.
final class _LibraryTagsLoaded extends LibraryEvent {
  const _LibraryTagsLoaded(this.tags);

  final List<String> tags;
}
