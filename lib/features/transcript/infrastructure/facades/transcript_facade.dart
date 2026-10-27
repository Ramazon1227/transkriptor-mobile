import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/repositories/transcript_repository.dart';

@LazySingleton(as: ITranscriptFacade)
class TranscriptFacade implements ITranscriptFacade {
  TranscriptFacade(this._repository);

  final TranscriptRepository _repository;

  @override
  Future<Either<Failure, Transcript>> getTranscript(String id) async {
    final result = await _repository.getTranscript(id);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, SegmentEdit>> updateSegmentText({
    required String transcriptId,
    required String segmentId,
    required String text,
    required int revision,
  }) async {
    final result = await _repository.updateSegmentText(
      transcriptId: transcriptId,
      segmentId: segmentId,
      text: text,
      revision: revision,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, SegmentEdit>> assignSpeaker({
    required String transcriptId,
    required String segmentId,
    required String? speakerId,
    required int revision,
  }) async {
    final result = await _repository.assignSpeaker(
      transcriptId: transcriptId,
      segmentId: segmentId,
      speakerId: speakerId,
      revision: revision,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, SegmentSplit>> splitSegment({
    required String transcriptId,
    required String segmentId,
    required int at,
    required int revision,
  }) async {
    final result = await _repository.splitSegment(
      transcriptId: transcriptId,
      segmentId: segmentId,
      at: at,
      revision: revision,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, SegmentMerge>> mergeNext({
    required String transcriptId,
    required String segmentId,
    required int revision,
  }) async {
    final result = await _repository.mergeNext(
      transcriptId: transcriptId,
      segmentId: segmentId,
      revision: revision,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Speaker>> renameSpeaker({
    required String transcriptId,
    required String speakerId,
    required String label,
  }) async {
    final result = await _repository.renameSpeaker(
      transcriptId: transcriptId,
      speakerId: speakerId,
      label: label,
    );
    return result.map((m) => m.toEntity());
  }
}
