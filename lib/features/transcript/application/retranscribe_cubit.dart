import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';

part 'retranscribe_cubit.freezed.dart';

enum RetranscribeStatus { idle, busy, started, failure }

@freezed
abstract class RetranscribeState with _$RetranscribeState {
  const factory RetranscribeState({
    @Default(RetranscribeStatus.idle) RetranscribeStatus status,

    /// The new job, once the server took it: the page opens it.
    String? jobId,
    Failure? failure,
  }) = _RetranscribeState;
}

/// «Qayta transkripsiya»: the same file as a new job. It spends balance,
/// so the sheet asks first; every confirmed tap carries a new idempotency
/// key (the job facade makes one per call), and a second tap while the
/// first runs sends nothing.
@injectable
class RetranscribeCubit extends Cubit<RetranscribeState> {
  RetranscribeCubit(this._jobs) : super(const RetranscribeState());

  final IJobFacade _jobs;

  Future<void> start(String mediaId) async {
    if (mediaId.isEmpty || state.status == RetranscribeStatus.busy) return;
    if (state.status == RetranscribeStatus.started) return;
    emit(state.copyWith(status: RetranscribeStatus.busy, failure: null));
    final result = await _jobs.createJob(mediaId: mediaId);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(status: RetranscribeStatus.failure, failure: failure),
      ),
      (job) => emit(
        state.copyWith(status: RetranscribeStatus.started, jobId: job.id),
      ),
    );
  }
}
