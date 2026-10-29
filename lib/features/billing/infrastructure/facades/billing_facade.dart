import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';
import 'package:transkriptor_uz/features/billing/infrastructure/repositories/billing_repository.dart';

@LazySingleton(as: IBillingFacade)
class BillingFacade implements IBillingFacade {
  BillingFacade(this._repository);

  final BillingRepository _repository;

  @override
  Future<Either<Failure, Balance>> balance(String workspaceId) async {
    final result = await _repository.balance(workspaceId);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, List<Plan>>> plans() async {
    final result = await _repository.plans();
    return result.map((m) => m.items.map((p) => p.toEntity()).toList());
  }
}
