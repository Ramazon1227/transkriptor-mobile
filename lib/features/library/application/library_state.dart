part of 'library_bloc.dart';

enum LibraryStatus { initial, loading, success, empty, failure }

@freezed
abstract class LibraryState with _$LibraryState {
  const factory LibraryState({
    @Default(LibraryStatus.initial) LibraryStatus status,
    @Default(<LibraryItem>[]) List<LibraryItem> items,
    String? workspaceId,

    /// The open folder; null is every file.
    String? folderId,

    /// The tag the rows are narrowed to; null shows them all.
    String? tag,

    /// The source tab; [LibraryState.items] already match it.
    @Default(FilesSource.all) FilesSource source,

    /// The search text; empty shows every row.
    @Default('') String query,

    /// A reload is running while the previous rows stay visible.
    @Default(false) bool refreshing,
    Failure? failure,
  }) = _LibraryState;
}

extension LibraryStateX on LibraryState {
  /// The tags on the loaded rows, in first-appearance order.
  List<String> get tags => {for (final i in items) ...i.tags}.toList();

  /// The rows on screen: [LibraryState.items] narrowed by
  /// [LibraryState.tag] and by [LibraryState.query] (name, any case).
  List<LibraryItem> get visibleItems {
    final t = tag;
    final q = query.trim().toLowerCase();
    if (t == null && q.isEmpty) return items;
    return [
      for (final i in items)
        if ((t == null || i.tags.contains(t)) &&
            (q.isEmpty || i.name.toLowerCase().contains(q)))
          i,
    ];
  }
}
