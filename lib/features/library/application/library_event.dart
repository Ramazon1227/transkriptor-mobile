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

/// The search field: narrows the loaded rows by name. Nothing is fetched,
/// `/library` has no search.
final class LibraryQueryChanged extends LibraryEvent {
  const LibraryQueryChanged(this.query);

  final String query;
}

/// Narrow the rows on screen to one tag; null clears it. Nothing is
/// fetched: like the web, the tag filter works on the open folder's rows.
final class LibraryTagSelected extends LibraryEvent {
  const LibraryTagSelected(this.tag);

  final String? tag;
}
