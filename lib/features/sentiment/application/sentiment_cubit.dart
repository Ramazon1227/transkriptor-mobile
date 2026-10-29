import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/sentiment/application/sentiment_poll_policy.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';
import 'package:transkriptor_uz/features/sentiment/domain/i_sentiment_facade.dart';

part 'sentiment_cubit.freezed.dart';

enum SentimentViewStatus { initial, loading, success, failure }

@freezed
abstract class SentimentState with _$SentimentState {
  const factory SentimentState({
    @Default(SentimentViewStatus.initial) SentimentViewStatus status,

    /// Null on success: never requested.
    SentimentAnalysis? analysis,

    /// The first load failed: nothing to show but a retry.
    Failure? failure,

    /// The start request is on its way.
    @Default(false) bool starting,

    /// Starting failed (403 VIEWER, 409, 503…); the panel stays as it was.
    Failure? startFailure,

    /// Asking about a pending analysis failed; retried when transient.
    Failure? pollFailure,
  }) = _SentimentState;

  const SentimentState._();

  bool get pending => analysis?.isPending ?? false;

  /// A start is allowed: loaded, nothing running, nothing on its way.
  bool get canStart =>
      status == SentimentViewStatus.success && !starting && !pending;

  /// Segment id → label for the transcript's markers; empty unless the
  /// analysis is `DONE`.
  Map<String, SentimentLabel> get labels =>
      (analysis?.isDone ?? false) ? analysis!.labels : const {};
}

/// One transcript's sentiment analysis. Started by a button; while it is
/// `PENDING` the cubit polls every [SentimentPollPolicy.interval] — only
/// while the tab is active, and never after `DONE` / `FAILED` / close.
@injectable
class SentimentCubit extends Cubit<SentimentState> {
  SentimentCubit(this._facade, this._policy) : super(const SentimentState());

  final ISentimentFacade _facade;
  final SentimentPollPolicy _policy;

  String? _transcriptId;
  Timer? _timer;
  bool _active = true;

  /// Bumped by every load and start: an answer that belongs to an older
  /// one is dropped, so a late poll never overwrites newer state.
  int _generation = 0;

  /// [transcriptId] comes from the editor.
  Future<void> load(String transcriptId) {
    _transcriptId = transcriptId;
    _timer?.cancel();
    final generation = ++_generation;
    emit(const SentimentState(status: SentimentViewStatus.loading));
    return _fetch(generation, initial: true);
  }

  /// Retry after the first load failed.
  Future<void> reload() {
    final id = _transcriptId;
    return id == null ? Future.value() : load(id);
  }

  /// The tab came into view or left it. Leaving stops the polling;
  /// coming back refreshes at once (the text may have been edited in the
  /// meantime, which makes a finished analysis `outdated`).
  Future<void> setActive({required bool active}) async {
    if (_active == active) return;
    _active = active;
    if (!active) {
      _timer?.cancel();
      return;
    }
    if (state.status != SentimentViewStatus.success || state.starting) return;
    _timer?.cancel();
    await _fetch(++_generation);
  }

  /// Starts (or re-runs) the analysis. Returns false when the server did
  /// not accept it; [SentimentState.startFailure] says why.
  Future<bool> analyze() async {
    final id = _transcriptId;
    if (id == null || !state.canStart) return false;
    _timer?.cancel();
    final generation = ++_generation;
    emit(state.copyWith(starting: true, startFailure: null, pollFailure: null));
    final result = await _facade.analyze(id);
    if (isClosed || generation != _generation) return result.isRight();
    final accepted = result.fold(
      (failure) {
        emit(state.copyWith(starting: false, startFailure: failure));
        // The server is the truth after any refusal: a 409 means a run is
        // already going (another member, another device); a 503 while the
        // server shuts down closes the new row as FAILED. Showing the old
        // panel would show a result the server no longer has.
        unawaited(_fetch(generation));
        return false;
      },
      (analysis) {
        emit(state.copyWith(starting: false, analysis: analysis));
        _scheduleIfPending(generation);
        return true;
      },
    );
    return accepted;
  }

  void dismissStartFailure() => emit(state.copyWith(startFailure: null));

  void _scheduleIfPending(int generation) {
    _timer?.cancel();
    if (!_active || !state.pending) return;
    _timer = Timer(_policy.interval, () => _fetch(generation));
  }

  Future<void> _fetch(int generation, {bool initial = false}) async {
    final id = _transcriptId;
    if (id == null) return;
    final result = await _facade.get(id);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) {
        if (initial) {
          emit(
            state.copyWith(
              status: SentimentViewStatus.failure,
              failure: failure,
            ),
          );
          return;
        }
        // 4xx / session gone: the transcript was deleted or is no longer
        // visible — polling cannot recover, so it ends in the failure view
        // with a retry instead of a spinner that promises one.
        if (_isPermanent(failure)) {
          emit(
            state.copyWith(
              status: SentimentViewStatus.failure,
              failure: failure,
              pollFailure: null,
            ),
          );
          return;
        }
        // Anything else (no network, a dropped connection, a 5xx, a broken
        // body behind a captive portal) is retried on the next tick.
        emit(state.copyWith(pollFailure: failure));
        _scheduleIfPending(generation);
      },
      (analysis) {
        emit(
          state.copyWith(
            status: SentimentViewStatus.success,
            analysis: analysis,
            failure: null,
            pollFailure: null,
          ),
        );
        _scheduleIfPending(generation);
      },
    );
  }

  static bool _isPermanent(Failure f) => switch (f) {
    UnauthorizedFailure() => true,
    ServerFailure(:final statusCode?) => statusCode >= 400 && statusCode < 500,
    _ => false,
  };

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
