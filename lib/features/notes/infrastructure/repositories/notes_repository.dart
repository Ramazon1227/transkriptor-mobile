import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/notes/infrastructure/models/note_models.dart';

@lazySingleton
class NotesRepository {
  NotesRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, NoteListModel>> list({
    required String workspaceId,
    String? cursor,
  }) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.notes,
        queryParameters: {'workspace_id': workspaceId, 'cursor': ?cursor},
      );
      return NoteListModel.fromJson(envelopeData(response.data));
    });
  }

  Future<Either<Failure, NoteModel>> get(String id) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(Endpoints.note(id));
      return _note(response.data);
    });
  }

  /// `PATCH /notes/:id` with only the title: the body is not sent, so it
  /// stays as it is.
  Future<Either<Failure, NoteModel>> rename({
    required String id,
    required String title,
    required int revision,
  }) {
    return runRequest(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        Endpoints.note(id),
        data: {'title': title, 'revision': revision},
      );
      return _note(response.data);
    });
  }

  Future<Either<Failure, Unit>> delete(String id) {
    return runRequest(() async {
      await _dio.delete<Map<String, dynamic>>(Endpoints.note(id));
      return unit;
    });
  }

  static NoteModel _note(Map<String, dynamic>? body) =>
      NoteModel.fromJson(envelopeData(body)['note'] as Map<String, dynamic>);
}
