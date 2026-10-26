import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';

abstract interface class IJobFacade {
  Future<Either<Failure, Job>> getJob(String id);

  /// Starts transcription of an uploaded and confirmed file. [numSpeakers]
  /// null means the server decides.
  Future<Either<Failure, Job>> createJob({
    required String mediaId,
    int? numSpeakers,
  });

  /// Cancels a queued or running job; reserved minutes are refunded.
  Future<Either<Failure, Job>> cancel(String id);
}
