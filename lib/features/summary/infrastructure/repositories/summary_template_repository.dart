import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/models/summary_template_model.dart';

/// `/summary-templates`: the list and the per-user star. Creating and
/// editing templates is web-only for now.
@lazySingleton
class SummaryTemplateRepository {
  SummaryTemplateRepository(this._dio);

  final Dio _dio;

  Future<
    Either<
      Failure,
      (List<SummaryTemplateCategoryModel>, List<SummaryTemplateModel>)
    >
  >
  list() {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.summaryTemplates,
      );
      final data = envelopeData(response.data);
      final categories = (data['categories'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(SummaryTemplateCategoryModel.fromJson)
          .toList();
      final templates = (data['templates'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(SummaryTemplateModel.fromJson)
          .toList();
      return (categories, templates);
    });
  }

  /// `PUT` stars, `DELETE` unstars; both answer `{favorite}`.
  Future<Either<Failure, bool>> setFavorite(
    String templateId, {
    required bool favorite,
  }) {
    return runRequest(() async {
      final path = Endpoints.summaryTemplateFavorite(templateId);
      final response = favorite
          ? await _dio.put<Map<String, dynamic>>(path)
          : await _dio.delete<Map<String, dynamic>>(path);
      return envelopeData(response.data)['favorite'] as bool? ?? favorite;
    });
  }
}
