import 'dart:async';
import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart' show Either, Right;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/api_config.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/files_source.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/library/domain/tag_rules.dart';

part 'library_bloc.freezed.dart';
part 'library_event.dart';
part 'library_state.dart';

@injectable
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc(this._facade, LibraryChanges changes)
    : super(const LibraryState()) {
    // One handler for all of them, so restartable() cancels across them: a
    // late answer for another filter never overwrites the newer one. Events
    // with nothing to do are dropped before restartable() sees them, or they
    // would cancel the request that is running and then do nothing.
    on<LibraryLoadEvent>(
      _onLoad,
      transformer: (events, mapper) =>
          restartable<LibraryLoadEvent>()(events.where(_hasWork), mapper),
    );
    on<_LibraryTagsLoaded>(_onTagsLoaded);
    _changes = changes.stream.listen((_) => add(const LibraryRefreshed()));
  }

  /// Rows asked for at a time.
  static const int pageSize = 30;

  /// What the server gives at most for one request.
  static const int maxPageSize = 100;

  static const Duration searchDebounce = Duration(milliseconds: 300);

  final ILibraryFacade _facade;
  late final StreamSubscription<void> _changes;

  /// While a file is queued or running the list refreshes itself, so a
  /// finished transcript shows up without pull-to-refresh, even when its
  /// job page was never opened.
  Timer? _inFlight;

  /// The last answer had a file still being transcribed.
  bool _polling = false;

  /// False from a search or tag change until its answer: the rows on screen
  /// belong to the old filter, so a refresh must not keep them as a tail.
  bool _rowsMatchFilter = true;

  /// Bumped by every tag fetch; a late list of an older fetch is dropped.
  int _tagsGeneration = 0;

  @override
  Future<void> close() async {
    _inFlight?.cancel();
    await _changes.cancel();
    await super.close();
  }

  bool _hasWork(LibraryLoadEvent event) => switch (event) {
    LibraryQueryChanged(:final query) => _cleanQuery(query) != state.query,
    LibraryTagSelected(:final tag) => tag != state.tag,
    LibraryMoreRequested() =>
      state.status == LibraryStatus.success &&
          state.nextCursor != null &&
          !state.refreshing &&
          !state.loadingMore,
    _ => true,
  };

  /// What the server would make of [raw]: it trims, and refuses a longer
  /// text with a 400.
  static String _cleanQuery(String raw) {
    final text = raw.trim();
    final runes = text.runes;
    return runes.length <= FileRules.maxName
        ? text
        : String.fromCharCodes(runes.take(FileRules.maxName)).trim();
  }

  /// [page]'s count covers rows on pages not loaded yet; [rows] are the
  /// fallback for a server that sends none.
  void _scheduleWhileInFlight(LibraryPage page, List<LibraryItem> rows) {
    _inFlight?.cancel();
    final inFlight = page.inFlight;
    _polling = inFlight != null
        ? inFlight > 0
        : rows.any(
            (i) =>
                i.jobStatus == JobStatus.queued ||
                i.jobStatus == JobStatus.running,
          );
    if (_polling) _pollLater();
  }

  void _pollLater() {
    _inFlight?.cancel();
    _inFlight = Timer(ApiConfig.jobPollMaxInterval, () {
      if (!isClosed) add(const LibraryRefreshed(auto: true));
    });
  }

  /// A failure keeps the previous list and says nothing: the bar is a
  /// convenience, the page works without it.
  void _loadTags(String workspaceId) {
    final generation = ++_tagsGeneration;
    unawaited(
      _facade.getTags(workspaceId: workspaceId).then((result) {
        if (isClosed || generation != _tagsGeneration) return;
        result.fold((_) {}, (tags) => add(_LibraryTagsLoaded(tags)));
      }),
    );
  }

  void _onTagsLoaded(_LibraryTagsLoaded event, Emitter<LibraryState> emit) {
    emit(state.copyWith(tags: event.tags));
    // Renamed or deleted, here or elsewhere: it would filter to nothing.
    final selected = state.tag;
    if (selected != null && !event.tags.contains(selected)) {
      add(const LibraryTagSelected(null));
    }
  }

  Future<Either<Failure, LibraryPage>> _fetch(
    String workspaceId, {
    required int limit,
    String? cursor,
  }) {
    final query = state.query;
    return _facade.getItems(
      workspaceId: workspaceId,
      folderId: state.folderId,
      source: state.source.serverSource,
      meeting: state.source.meeting,
      query: query.isEmpty ? null : query,
      tag: state.tag,
      limit: limit,
      cursor: cursor,
    );
  }

  /// [count] rows from the top, one server-sized request at a time. A failed
  /// request answers for the whole walk; a newer event stops it.
  Future<Either<Failure, LibraryPage>> _fetchRows(
    String workspaceId,
    int count,
    Emitter<LibraryState> emit,
  ) async {
    final rows = <LibraryItem>[];
    String? cursor;
    while (true) {
      final limit = min(count - rows.length, maxPageSize);
      final result = await _fetch(workspaceId, limit: limit, cursor: cursor);
      final page = result.fold((_) => null, (p) => p);
      if (page == null || emit.isDone) return result;
      rows.addAll(page.items);
      cursor = page.nextCursor;
      if (cursor == null || page.items.length < limit || rows.length >= count) {
        return Right(page.copyWith(items: rows));
      }
    }
  }

  Future<void> _onLoad(
    LibraryLoadEvent event,
    Emitter<LibraryState> emit,
  ) async {
    if (event is LibraryMoreRequested) {
      await _loadMore(emit);
      return;
    }

    final workspaceId = switch (event) {
      LibraryStarted(:final workspaceId) => workspaceId,
      _ => state.workspaceId,
    };
    if (workspaceId == null) return;

    if (event is LibraryStarted || (event is LibraryRefreshed && !event.auto)) {
      _loadTags(workspaceId);
    }

    // Another folder or source tab is another list: its first load blanks
    // the rows and drops the tag. A refresh keeps the rows on screen.
    if (event is LibraryFolderSelected || event is LibrarySourceSelected) {
      _inFlight?.cancel();
      emit(
        state.copyWith(
          status: LibraryStatus.loading,
          items: const [],
          nextCursor: null,
          total: 0,
          folderId: switch (event) {
            LibraryFolderSelected(:final folderId) => folderId,
            _ => state.folderId,
          },
          source: switch (event) {
            LibrarySourceSelected(:final source) => source,
            _ => state.source,
          },
          tag: null,
          refreshing: false,
          loadingMore: false,
          failure: null,
        ),
      );
    }

    // A search or a tag narrows the same list: the rows stay until the
    // answer, but they can no longer be continued with the old cursor.
    final filterChanged =
        event is LibraryQueryChanged || event is LibraryTagSelected;
    if (filterChanged) {
      _inFlight?.cancel();
      _rowsMatchFilter = false;
    }

    final oldRows = state.items;
    final hasItems = oldRows.isNotEmpty;
    emit(
      state.copyWith(
        status: hasItems ? state.status : LibraryStatus.loading,
        refreshing: hasItems,
        loadingMore: false,
        workspaceId: workspaceId,
        nextCursor: filterChanged ? null : state.nextCursor,
        query: switch (event) {
          LibraryQueryChanged(:final query) => _cleanQuery(query),
          _ => state.query,
        },
        tag: switch (event) {
          LibraryTagSelected(:final tag) => tag,
          _ => state.tag,
        },
        failure: null,
      ),
    );

    // Inside the cancellable flow: the next keystroke restarts this handler,
    // which then stops here without asking anything.
    if (event is LibraryQueryChanged) {
      await Future<void>.delayed(searchDebounce);
      if (emit.isDone) return;
    }

    // A refresh asks again for everything the person has scrolled through:
    // nothing is thrown away, and a file deleted or renamed far down the list
    // does not stay on screen as it was.
    final count = event is LibraryRefreshed && _rowsMatchFilter
        ? max(oldRows.length, pageSize)
        : pageSize;

    final result = await _fetchRows(workspaceId, count, emit);
    if (emit.isDone) return;

    result.fold(
      // A failed refresh keeps the rows and only reports the failure. A
      // file still being transcribed keeps the poll going (MB-9): one
      // dropped request must not freeze its status.
      (failure) {
        emit(
          state.copyWith(
            status: hasItems ? state.status : LibraryStatus.failure,
            refreshing: false,
            failure: failure,
          ),
        );
        if (_polling && event is LibraryRefreshed) _pollLater();
      },
      (page) {
        _rowsMatchFilter = true;
        final rows = page.items;
        emit(
          state.copyWith(
            status: rows.isEmpty && !state.hasFilter
                ? LibraryStatus.empty
                : LibraryStatus.success,
            refreshing: false,
            items: rows,
            nextCursor: page.nextCursor,
            total: page.total,
          ),
        );
        _scheduleWhileInFlight(page, rows);
      },
    );
  }

  Future<void> _loadMore(Emitter<LibraryState> emit) async {
    final workspaceId = state.workspaceId;
    final cursor = state.nextCursor;
    if (workspaceId == null || cursor == null) return;

    emit(state.copyWith(loadingMore: true, failure: null));
    final result = await _fetch(workspaceId, limit: pageSize, cursor: cursor);
    if (emit.isDone) return;

    result.fold(
      // The rows and the cursor stay; the next scroll to the end tries again.
      (failure) => emit(state.copyWith(loadingMore: false, failure: failure)),
      (page) {
        // A file added meanwhile shifts the pages: a row can come twice.
        final seen = {for (final i in state.items) i.mediaId};
        emit(
          state.copyWith(
            loadingMore: false,
            items: [
              ...state.items,
              ...page.items.where((i) => seen.add(i.mediaId)),
            ],
            nextCursor: page.nextCursor,
            total: page.total,
          ),
        );
      },
    );
  }
}
