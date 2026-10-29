import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';

/// Creates a note (`POST /notes`). The body is a Tiptap document stored as
/// JSON, never HTML; the server derives the plain text itself.
@lazySingleton
class NoteRepository {
  NoteRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, Unit>> create({
    required String workspaceId,
    required String title,
    required List<String> paragraphs,
  }) {
    return runRequest(() async {
      await _dio.post<Map<String, dynamic>>(
        Endpoints.notes,
        data: {
          'workspace_id': workspaceId,
          'title': title,
          'body': tiptapDoc(paragraphs),
        },
      );
      return unit;
    });
  }
}

/// `{"type":"doc","content":[{"type":"paragraph","content":[text]}]}`.
Map<String, dynamic> tiptapDoc(List<String> paragraphs) => {
  'type': 'doc',
  'content': [
    for (final p in paragraphs)
      {
        'type': 'paragraph',
        'content': [
          {'type': 'text', 'text': p},
        ],
      },
  ],
};
