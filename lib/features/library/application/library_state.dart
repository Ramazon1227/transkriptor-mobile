part of 'library_bloc.dart';

enum LibraryStatus { initial, loading, success, empty, failure }

@freezed
abstract class LibraryState with _$LibraryState {
  const factory LibraryState({
    @Default(LibraryStatus.initial) LibraryStatus status,
    @Default(<LibraryItem>[]) List<LibraryItem> items,
    String? workspaceId,

    /// A reload is running while the previous rows stay visible.
    @Default(false) bool refreshing,
    Failure? failure,
  }) = _LibraryState;
}
