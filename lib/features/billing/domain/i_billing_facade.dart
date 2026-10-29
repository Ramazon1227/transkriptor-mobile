import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';

abstract interface class IBillingFacade {
  /// The workspace's balance, plan and subscription state.
  Future<Either<Failure, Balance>> balance(String workspaceId);

  /// Every plan, in the server's order. Open without a session.
  Future<Either<Failure, List<Plan>>> plans();
}
