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
}
