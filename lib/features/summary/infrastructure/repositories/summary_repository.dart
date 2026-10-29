import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/route_missing.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/models/summary_model.dart';

/// One answer of the summary routes. `routeMissing`: the server has no
/// summary API (backend without `feat/meeting-ai`); `summary` is then
/// null and means nothing.
typedef SummaryAnswer = ({bool routeMissing, SummaryModel? summary});

/// `/transcript/:id/summary` (backend `api/handler/summary.go`). Every
/// answer is `{summary: TranscriptSummary | null}`; GET with no summary
/// yet is 200 with null, not 404. POST answers 202 with a PENDING row and
/// a background worker writes the text; the caller polls GET.
@lazySingleton
class SummaryRepository {
  SummaryRepository(this._dio);

  /// What the backend reads as «the default template» (the first system
  /// one, «Asosiy xulosa»).
  static const String defaultTemplateId = 'basic';

  final Dio _dio;

  Future<Either<Failure, SummaryAnswer>> get(String transcriptId) => _call(
    () => _dio.get<Map<String, dynamic>>(
      Endpoints.transcriptSummary(transcriptId),
    ),
  );

  /// [templateId] null: the default. 409 = a summary is being written
  /// already (or the transcript has no text), 503 = summaries are off or
  /// the queue is full, 403 = VIEWER.
  Future<Either<Failure, SummaryAnswer>> generate(
    String transcriptId, {
    String? templateId,
  }) => _call(
    () => _dio.post<Map<String, dynamic>>(
      Endpoints.transcriptSummary(transcriptId),
      data: {'template_id': templateId ?? defaultTemplateId},
    ),
  );

  /// The transcript stays; deleting nothing is not an error.
  Future<Either<Failure, Unit>> delete(String transcriptId) async {
    final result = await _call(
      () => _dio.delete<Map<String, dynamic>>(
        Endpoints.transcriptSummary(transcriptId),
      ),
    );
    return result.map((_) => unit);
  }

  Future<Either<Failure, SummaryAnswer>> _call(
    Future<Response<Map<String, dynamic>>> Function() send,
  ) {
    return runRequest(() async {
      try {
        final response = await send();
        final raw = envelopeData(response.data)['summary'];
        return (
          routeMissing: false,
          summary: raw is Map<String, dynamic>
              ? SummaryModel.fromJson(raw)
              : null,
        );
      } on DioException catch (e) {
        if (isRouteMissing(e)) return (routeMissing: true, summary: null);
        rethrow;
      }
    });
  }
}
