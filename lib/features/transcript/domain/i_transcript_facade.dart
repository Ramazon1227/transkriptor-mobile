import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

abstract interface class ITranscriptFacade {
  Future<Either<Failure, Transcript>> getTranscript(String id);

  Future<Either<Failure, SegmentEdit>> updateSegmentText({
    required String transcriptId,
    required String segmentId,
    required String text,
    required int revision,
  });

  Future<Either<Failure, Speaker>> renameSpeaker({
    required String transcriptId,
    required String speakerId,
    required String label,
  });
}
