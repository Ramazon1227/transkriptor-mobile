import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';

part 'job_cubit.freezed.dart';

enum JobViewStatus { initial, loading, success, failure }

@freezed
abstract class JobState with _$JobState {
  const factory JobState({
    @Default(JobViewStatus.initial) JobViewStatus status,
    String? jobId,
    Job? job,

    /// A cancel or retry request is in flight.
    @Default(false) bool busy,
    Failure? failure,
  }) = _JobState;
}

/// Follows one job until it finishes. Polling, because transcription runs
/// minutes to hours and the backend has no push yet.
@injectable
class JobCubit extends Cubit<JobState> {
  JobCubit(this._facade, this._policy, this._changes) : super(const JobState());

  final IJobFacade _facade;
  final JobPollPolicy _policy;

  /// Told when a job finishes while watched: the files list and the
  /// balance change on the server at that moment.
  final LibraryChanges _changes;

  Timer? _timer;
  late Duration _interval = _policy.first;

  /// Bumped on every [watch]; an answer for an older job is dropped, so a
  /// late response never overwrites the newer one.
  int _generation = 0;

  /// [jobId] comes from outside: the route, or the upload that started it.
  void watch(String jobId) {
    _timer?.cancel();
    final generation = ++_generation;
    _interval = _policy.first;
    emit(JobState(status: JobViewStatus.loading, jobId: jobId));
    unawaited(_poll(generation, jobId));
  }

  /// Retry after a failed poll (no network, server down).
  void refresh() {
    final id = state.jobId;
    if (id != null) watch(id);
  }

  Future<void> _poll(int generation, String jobId) async {
    final result = await _facade.getJob(jobId);
    if (isClosed || generation != _generation) return;

    result.fold(
      (failure) {
        // A job runs for hours; one dropped connection must not freeze the
        // page. Transient failures keep polling at the slowest pace, with
        // the job still on screen and the failure shown beside it.
        if (state.job != null && _isTransient(failure)) {
          emit(state.copyWith(failure: failure));
          _interval = _policy.max;
          _timer = Timer(_interval, () => _poll(generation, jobId));
          return;
        }
        // Anything else (404, 401, nothing shown yet) stops; the page
        // offers a retry.
        emit(state.copyWith(status: JobViewStatus.failure, failure: failure));
      },
      (job) {
        final previous = state.job;
        final changed =
            previous == null ||
            previous.status != job.status ||
            previous.progress != job.progress;
        emit(
          state.copyWith(
            status: JobViewStatus.success,
            job: job,
            failure: null,
          ),
        );
        if (job.status.isTerminal) {
          if (previous != null && !previous.status.isTerminal) {
            _changes.notify();
          }
          return;
        }
        _interval = _policy.next(_interval, changed: changed);
        _timer = Timer(_interval, () => _poll(generation, jobId));
      },
    );
  }

  static bool _isTransient(Failure f) => switch (f) {
    NetworkFailure() || TimeoutFailure() => true,
    ServerFailure(:final statusCode) => statusCode == null || statusCode >= 500,
    _ => false,
  };

  /// Starts the same file again after a failure; follows the new job.
  Future<void> retry() async {
    final job = state.job;
    if (job == null || job.mediaId.isEmpty || state.busy) return;
    emit(state.copyWith(busy: true, failure: null));
    final result = await _facade.createJob(mediaId: job.mediaId);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(busy: false, failure: failure)),
      (created) => watch(created.id),
    );
  }

  Future<void> cancel() async {
    final id = state.jobId;
    if (id == null || state.busy) return;
    emit(state.copyWith(busy: true, failure: null));
    final result = await _facade.cancel(id);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(busy: false, failure: failure)),
      (_) => watch(id),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
