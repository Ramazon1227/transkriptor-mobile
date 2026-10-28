import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/api_config.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';

part 'library_bloc.freezed.dart';
part 'library_event.dart';
part 'library_state.dart';

@injectable
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc(this._facade, LibraryChanges changes)
    : super(const LibraryState()) {
    // One handler for both events, so restartable() cancels across them:
    // a late answer for another workspace never overwrites the newer one.
    on<LibraryLoadEvent>(_onLoad, transformer: restartable());
    on<LibraryTagSelected>(
      (event, emit) => emit(state.copyWith(tag: event.tag)),
    );
    _changes = changes.stream.listen((_) => add(const LibraryRefreshed()));
  }

  final ILibraryFacade _facade;
  late final StreamSubscription<void> _changes;

  /// While a file is queued or running the list refreshes itself, so a
  /// finished transcript shows up without pull-to-refresh, even when its
  /// job page was never opened.
  Timer? _inFlight;

  @override
  Future<void> close() async {
    _inFlight?.cancel();
    await _changes.cancel();
    await super.close();
  }

  void _scheduleWhileInFlight(List<LibraryItem> items) {
    _inFlight?.cancel();
    final running = items.any(
      (i) =>
          i.jobStatus == JobStatus.queued || i.jobStatus == JobStatus.running,
    );
    if (!running) return;
    _inFlight = Timer(ApiConfig.jobPollMaxInterval, () {
      if (!isClosed) add(const LibraryRefreshed());
    });
  }

  Future<void> _onLoad(
    LibraryLoadEvent event,
    Emitter<LibraryState> emit,
  ) async {
    final workspaceId = switch (event) {
      LibraryStarted(:final workspaceId) => workspaceId,
      LibraryRefreshed() || LibraryFolderSelected() => state.workspaceId,
    };
    if (workspaceId == null) return;

    // Another folder is another list: its first load blanks the rows and
    // drops the tag. A refresh keeps the rows on screen.
    if (event case LibraryFolderSelected(:final folderId)) {
      _inFlight?.cancel();
      emit(
        state.copyWith(
          status: LibraryStatus.loading,
          items: const [],
          folderId: folderId,
          tag: null,
          refreshing: false,
          failure: null,
        ),
      );
    }
    final folderId = state.folderId;

    final hasItems = state.items.isNotEmpty;
    emit(
      state.copyWith(
        status: hasItems ? state.status : LibraryStatus.loading,
        refreshing: hasItems,
        workspaceId: workspaceId,
        failure: null,
      ),
    );

    final result = await _facade.getItems(
      workspaceId: workspaceId,
      folderId: folderId,
    );

    result.fold(
      // A failed refresh keeps the rows and only reports the failure.
      (failure) => emit(
        state.copyWith(
          status: hasItems ? state.status : LibraryStatus.failure,
          refreshing: false,
          failure: failure,
        ),
      ),
      (items) {
        emit(
          state.copyWith(
            status: items.isEmpty ? LibraryStatus.empty : LibraryStatus.success,
            refreshing: false,
            items: items,
            // A tag no row carries any more would filter to nothing.
            tag: items.any((i) => i.tags.contains(state.tag))
                ? state.tag
                : null,
          ),
        );
        _scheduleWhileInFlight(items);
      },
    );
  }
}
