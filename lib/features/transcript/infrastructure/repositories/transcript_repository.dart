import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/models/transcript_model.dart';

@lazySingleton
class TranscriptRepository {
  TranscriptRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, TranscriptModel>> getTranscript(String id) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.transcript(id),
      );
      return TranscriptModel.fromJson(envelopeData(response.data));
    });
  }

  /// [revision] is the one this text was edited against; a stale one is
  /// a 409.
  Future<Either<Failure, SegmentEditModel>> updateSegmentText({
    required String transcriptId,
    required String segmentId,
    required String text,
    required int revision,
  }) {
    return runRequest(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        Endpoints.transcriptSegment(transcriptId, segmentId),
        data: {'text': text, 'revision': revision},
      );
      return SegmentEditModel.fromJson(envelopeData(response.data));
    });
  }

  /// The same route as a text edit, with `speaker_id` or
  /// `new_speaker: true` instead of `text` — the server takes one of them
  /// per request. A null [speakerId] opens a new speaker.
  Future<Either<Failure, SegmentEditModel>> assignSpeaker({
    required String transcriptId,
    required String segmentId,
    required String? speakerId,
    required int revision,
  }) {
    return runRequest(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        Endpoints.transcriptSegment(transcriptId, segmentId),
        data: {
          if (speakerId == null)
            'new_speaker': true
          else
            'speaker_id': speakerId,
          'revision': revision,
        },
      );
      return SegmentEditModel.fromJson(envelopeData(response.data));
    });
  }

  /// [at] counts characters (runes) of the stored text, as Go does. An
  /// answer without exactly two parts is a parsing failure.
  Future<Either<Failure, SegmentSplitModel>> splitSegment({
    required String transcriptId,
    required String segmentId,
    required int at,
    required int revision,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.transcriptSegmentSplit(transcriptId, segmentId),
        data: {'at': at, 'revision': revision},
      );
      final split = SegmentSplitModel.fromJson(envelopeData(response.data));
      if (split.segments.length != 2) {
        throw const FormatException('split: expected two segments');
      }
      return split;
    });
  }

  Future<Either<Failure, SegmentMergeModel>> mergeNext({
    required String transcriptId,
    required String segmentId,
    required int revision,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.transcriptSegmentMergeNext(transcriptId, segmentId),
        data: {'revision': revision},
      );
      return SegmentMergeModel.fromJson(envelopeData(response.data));
    });
  }

  /// A rename does not take part in the revision: segments only point at
  /// the speaker id.
  Future<Either<Failure, SpeakerModel>> renameSpeaker({
    required String transcriptId,
    required String speakerId,
    required String label,
  }) {
    return runRequest(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        Endpoints.transcriptSpeaker(transcriptId, speakerId),
        data: {'label': label},
      );
      return SpeakerEditModel.fromJson(envelopeData(response.data)).speaker;
    });
  }

  /// The title takes part in the revision: a stale one is a 409.
  Future<Either<Failure, TranscriptMetaModel>> renameTranscript({
    required String transcriptId,
    required String title,
    required int revision,
  }) {
    return runRequest(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        Endpoints.transcript(transcriptId),
        data: {'title': title, 'revision': revision},
      );
      return TranscriptMetaModel.fromJson(envelopeData(response.data));
    });
  }

  /// The revision goes in the query: many clients drop a DELETE body.
  Future<Either<Failure, SegmentDeletedModel>> deleteSegment({
    required String transcriptId,
    required String segmentId,
    required int revision,
  }) {
    return runRequest(() async {
      final response = await _dio.delete<Map<String, dynamic>>(
        Endpoints.transcriptSegment(transcriptId, segmentId),
        queryParameters: {'revision': revision},
      );
      return SegmentDeletedModel.fromJson(envelopeData(response.data));
    });
  }
}
