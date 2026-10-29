import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/sentiment/infrastructure/models/sentiment_model.dart';

/// `GET` / `POST /transcript/:id/sentiment`. Both answer
/// `{"sentiment": {...} | null}`.
///
/// A refusal (409 / 503) carries its reason in the envelope's
/// `data.error` — «transkriptda matn yoʻq», «ish maydonida bir vaqtda 3
/// tadan ortiq tahlil ketmaydi…», «AI band…» — while `description` is
/// only the generic «ziddiyat» / «xizmat vaqtincha mavjud emas». The
/// shared mapper reads `description`; here the reason replaces it, so the
/// person learns why (review 2026-10-29).
@lazySingleton
class SentimentRepository {
  SentimentRepository(this._dio);

  final Dio _dio;

  /// Null: never requested.
  Future<Either<Failure, SentimentModel?>> get(String transcriptId) {
    return _run(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.transcriptSentiment(transcriptId),
      );
      return _parse(envelopeData(response.data));
    });
  }

  Future<Either<Failure, SentimentModel>> analyze(String transcriptId) {
    return _run(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.transcriptSentiment(transcriptId),
      );
      final model = _parse(envelopeData(response.data));
      if (model == null) {
        throw const FormatException('202 without a sentiment');
      }
      return model;
    });
  }

  /// [runRequest], keeping the error body to read `data.error` from.
  static Future<Either<Failure, T>> _run<T>(Future<T> Function() call) async {
    Object? body;
    final result = await runRequest(() async {
      try {
        return await call();
      } on DioException catch (e) {
        body = e.response?.data;
        rethrow;
      }
    });
    return result.leftMap((failure) => _withReason(failure, body));
  }

  static Failure _withReason(Failure failure, Object? body) {
    if (failure is! ServerFailure || body is! Map<String, dynamic>) {
      return failure;
    }
    final data = body['data'];
    final reason = data is Map<String, dynamic> ? data['error'] : null;
    if (reason is! String || reason.trim().isEmpty) return failure;
    return Failure.server(statusCode: failure.statusCode, message: reason);
  }

  static SentimentModel? _parse(Map<String, dynamic> data) {
    final raw = data['sentiment'];
    if (raw == null) return null;
    if (raw is! Map<String, dynamic>) {
      throw const FormatException('sentiment is not an object');
    }
    return SentimentModel.fromJson(raw);
  }
}
