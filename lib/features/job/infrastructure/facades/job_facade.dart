import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';
import 'package:transkriptor_uz/features/job/infrastructure/repositories/job_repository.dart';

@LazySingleton(as: IJobFacade)
class JobFacade implements IJobFacade {
  JobFacade(this._repository, this._changes);

  final JobRepository _repository;
  final LibraryChanges _changes;

  @override
  Future<Either<Failure, Job>> getJob(String id) async {
    final result = await _repository.getJob(id);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Job>> createJob({
    required String mediaId,
    int? numSpeakers,
  }) async {
    final result = await _repository.createJob(
      mediaId: mediaId,
      numSpeakers: numSpeakers,
    );
    // Minutes were reserved and the file now has a job.
    if (result.isRight()) _changes.notify();
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Job>> cancel(String id) async {
    final result = await _repository.cancel(id);
    if (result.isRight()) _changes.notify();
    return result.map((m) => m.toEntity());
  }
}
