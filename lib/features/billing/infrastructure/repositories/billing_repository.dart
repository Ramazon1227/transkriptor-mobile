import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/billing/infrastructure/models/billing_models.dart';

@lazySingleton
class BillingRepository {
  BillingRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, BalanceModel>> balance(String workspaceId) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.workspaceBalance(workspaceId),
      );
      return BalanceResponseModel.fromJson(envelopeData(response.data)).balance;
    });
  }

  Future<Either<Failure, PlanListModel>> plans() {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(Endpoints.plans);
      return PlanListModel.fromJson(envelopeData(response.data));
    });
  }
}
