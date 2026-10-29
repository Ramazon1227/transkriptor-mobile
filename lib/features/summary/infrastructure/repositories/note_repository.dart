import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';

/// `POST /notes`. A note made from a transcript is a copy that survives
/// the file; the server takes the workspace from the transcript.
@lazySingleton
class NoteRepository {
  NoteRepository(this._dio);

  final Dio _dio;

  /// [body] is a Tiptap document (`{"type":"doc",...}`); the server
  /// rejects unknown nodes. Returns the new note's id.
  Future<Either<Failure, String>> create({
    required String title,
    required Map<String, Object?> body,
    String? sourceTranscriptId,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.notes,
        data: {
          'title': title,
          'body': body,
          'source_transcript_id': ?sourceTranscriptId,
        },
      );
      final note = envelopeData(response.data)['note'];
      if (note is! Map<String, dynamic> || note['id'] is! String) {
        throw const FormatException('response has no note');
      }
      return note['id'] as String;
    });
  }
}
