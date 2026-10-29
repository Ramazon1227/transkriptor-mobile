import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/i_notes_facade.dart';

part 'notes_cubit.freezed.dart';

enum NotesStatus { initial, loading, success, empty, failure }

@freezed
abstract class NotesState with _$NotesState {
  const factory NotesState({
    @Default(NotesStatus.initial) NotesStatus status,
    @Default(<NoteSummary>[]) List<NoteSummary> items,

    /// Null when the last page is loaded.
    String? nextCursor,

    /// The next page is loading below the rows.
    @Default(false) bool loadingMore,

    /// A reload runs while the previous rows stay visible.
    @Default(false) bool refreshing,

    /// The files screen's search text; filters the loaded rows.
    @Default('') String query,
    Failure? failure,
  }) = _NotesState;
}

extension NotesStateX on NotesState {
  /// [NotesState.items] narrowed by the search text (title or excerpt).
  List<NoteSummary> get visibleItems {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return items;
    return [
      for (final n in items)
        if (n.title.toLowerCase().contains(q) ||
            n.excerpt.toLowerCase().contains(q))
          n,
    ];
  }
}

/// The «Eslatmalar» tab: the caller's own notes in the current workspace,
/// a page at a time.
@injectable
class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._facade) : super(const NotesState());

  final INotesFacade _facade;
  String? _workspaceId;

  /// Bumped by every first-page load; a late page of an older list is
  /// dropped, so a refresh never mixes with a stale «load more».
  int _generation = 0;

  /// [workspaceId] comes from the signed-in account.
  Future<void> load(String workspaceId) {
    _workspaceId = workspaceId;
    emit(state.copyWith(status: NotesStatus.loading, failure: null));
    return _first();
  }

  /// Pull to refresh, retry, or back from a changed note.
  Future<void> refresh() => _first();

  void setQuery(String query) => emit(state.copyWith(query: query));

  Future<void> loadMore() async {
    final ws = _workspaceId;
    final cursor = state.nextCursor;
    if (ws == null || cursor == null || state.loadingMore) return;
    final generation = _generation;
    emit(state.copyWith(loadingMore: true));
    final result = await _facade.list(workspaceId: ws, cursor: cursor);
    if (isClosed || generation != _generation) return;
    result.fold(
      // The rows stay; the next scroll to the end tries again.
      (failure) => emit(state.copyWith(loadingMore: false, failure: failure)),
      (page) => emit(
        state.copyWith(
          loadingMore: false,
          items: [...state.items, ...page.items],
          nextCursor: page.nextCursor,
          failure: null,
        ),
      ),
    );
  }

  Future<void> _first() async {
    final ws = _workspaceId;
    if (ws == null) return;
    final generation = ++_generation;
    final hasItems = state.items.isNotEmpty;
    emit(state.copyWith(refreshing: hasItems, loadingMore: false));
    final result = await _facade.list(workspaceId: ws);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: hasItems ? state.status : NotesStatus.failure,
          refreshing: false,
          failure: failure,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: page.items.isEmpty ? NotesStatus.empty : NotesStatus.success,
          items: page.items,
          nextCursor: page.nextCursor,
          refreshing: false,
          failure: null,
        ),
      ),
    );
  }
}
