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
    on<LibraryEvent>(_onLoad, transformer: restartable());
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

  Future<void> _onLoad(LibraryEvent event, Emitter<LibraryState> emit) async {
    final workspaceId = switch (event) {
      LibraryStarted(:final workspaceId) => workspaceId,
      LibraryRefreshed() => state.workspaceId,
    };
    if (workspaceId == null) return;

    // A refresh keeps the rows on screen; only the first load blanks them.
    final hasItems = state.items.isNotEmpty;
    emit(
      state.copyWith(
        status: hasItems ? state.status : LibraryStatus.loading,
        refreshing: hasItems,
        workspaceId: workspaceId,
        failure: null,
      ),
    );

    final result = await _facade.getItems(workspaceId: workspaceId);

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
          ),
        );
        _scheduleWhileInFlight(items);
      },
    );
  }
}
