part of 'library_bloc.dart';

enum LibraryStatus { initial, loading, success, empty, failure }

@freezed
abstract class LibraryState with _$LibraryState {
  const factory LibraryState({
    @Default(LibraryStatus.initial) LibraryStatus status,
    @Default(<LibraryItem>[]) List<LibraryItem> items,

    /// Null when the last page is loaded, or while a new filter's first
    /// page is awaited.
    String? nextCursor,

    /// Every row matching the filters, not only the loaded ones.
    @Default(0) int total,
    String? workspaceId,

    /// The open folder; null is every file.
    String? folderId,

    /// The tag the server narrows the rows to; null shows them all.
    String? tag,

    /// The workspace's tags, most used first. Kept when a fetch fails.
    @Default(<String>[]) List<String> tags,

    /// The source tab; [LibraryState.items] already match it.
    @Default(FilesSource.all) FilesSource source,

    /// The search text as sent to the server, trimmed; empty shows every row.
    @Default('') String query,

    /// A reload is running while the previous rows stay visible.
    @Default(false) bool refreshing,

    /// The next page is loading below the rows.
    @Default(false) bool loadingMore,
    Failure? failure,
  }) = _LibraryState;
}

extension LibraryStateX on LibraryState {
  /// A search or a tag narrows the list: no rows then means no match, not an
  /// empty library.
  bool get hasFilter => query.isNotEmpty || tag != null;
}
