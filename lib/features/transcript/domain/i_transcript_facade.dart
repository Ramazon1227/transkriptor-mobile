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

  /// Moves one segment to [speakerId], or to a speaker the server opens
  /// when [speakerId] is null. Takes part in the revision like a text edit.
  Future<Either<Failure, SegmentEdit>> assignSpeaker({
    required String transcriptId,
    required String segmentId,
    required String? speakerId,
    required int revision,
  });

  /// Splits a segment at [at], a character (rune) offset into its stored
  /// text. The server splits the time in proportion and answers 422 for a
  /// point at either edge.
  Future<Either<Failure, SegmentSplit>> splitSegment({
    required String transcriptId,
    required String segmentId,
    required int at,
    required int revision,
  });

  /// Folds the next segment (by position) into this one. 422 when there
  /// is no next one.
  Future<Either<Failure, SegmentMerge>> mergeNext({
    required String transcriptId,
    required String segmentId,
    required int revision,
  });

  Future<Either<Failure, Speaker>> renameSpeaker({
    required String transcriptId,
    required String speakerId,
    required String label,
  });

  /// Changes the title against [revision]; 409 when it is stale.
  Future<Either<Failure, TranscriptMeta>> renameTranscript({
    required String transcriptId,
    required String title,
    required int revision,
  });

  /// Removes one segment; answers the transcript's new revision.
  Future<Either<Failure, int>> deleteSegment({
    required String transcriptId,
    required String segmentId,
    required int revision,
  });
}
