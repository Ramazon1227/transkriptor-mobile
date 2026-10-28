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

    /// A reload is running while the previous rows stay visible.
    @Default(false) bool refreshing,
    Failure? failure,
  }) = _LibraryState;
}

extension LibraryStateX on LibraryState {
  /// The tags on the loaded rows, in first-appearance order.
  List<String> get tags => {for (final i in items) ...i.tags}.toList();

  /// The rows on screen: [LibraryState.items] narrowed by [LibraryState.tag].
  List<LibraryItem> get visibleItems {
    final t = tag;
    return t == null
        ? items
        : [
            for (final i in items)
              if (i.tags.contains(t)) i,
          ];
  }
}
