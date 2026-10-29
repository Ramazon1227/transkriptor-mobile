import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/billing/application/balance_cubit.dart';
import 'package:transkriptor_uz/features/billing/application/plans_cubit.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';
import 'package:transkriptor_uz/features/billing/infrastructure/facades/billing_facade.dart';
import 'package:transkriptor_uz/features/billing/infrastructure/repositories/billing_repository.dart';

import '../../helpers/fake_http_adapter.dart';

class _MockFacade extends Mock implements IBillingFacade;

void main() {
  group('BillingRepository + facade', () {
    test('balance reads plan, status and period', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/workspaces/w1/balance': (
          200,
          ok({
            'balance': {
              'balance_seconds': 3600,
              'plan': {
                'code': 'pro',
                'name': 'Pro',
                'monthly_seconds': 36000,
                'price_uzs': 99000,
                'max_members': 1,
              },
              'status': 'ACTIVE',
              'period_end': '2026-11-29T00:00:00Z',
              'cancel_at_period_end': true,
            },
          }),
        ),
      });
      final facade = BillingFacade(BillingRepository(fakeDio(http)));

      final b = (await facade.balance('w1'))
          .getOrElse(() => throw StateError('left'));

      expect(b.balanceSeconds, 3600);
      expect(b.plan?.name, 'Pro');
      expect(b.plan?.isFree, isFalse);
      expect(b.status, SubscriptionStatus.active);
      expect(b.periodEnd, isNotNull);
      expect(b.cancelAtPeriodEnd, isTrue);
    });

    test('no subscription: status is omitted and means none', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/workspaces/w1/balance': (
          200,
          ok({
            'balance': {
              'balance_seconds': 0,
              'plan': {'code': 'free', 'name': 'Bepul', 'price_uzs': 0},
              'period_end': null,
            },
          }),
        ),
      });
      final b = (await BillingFacade(
        BillingRepository(fakeDio(http)),
      ).balance('w1')).getOrElse(() => throw StateError('left'));
      expect(b.status, SubscriptionStatus.none);
      expect(b.plan?.isFree, isTrue);
    });

    test('plans keep the server order', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/plans': (
          200,
          ok({
            'items': [
              {'code': 'free', 'name': 'Bepul'},
              {'code': 'pro', 'name': 'Pro', 'price_uzs': 99000},
              {'code': 'team', 'name': 'Jamoa', 'max_members': 10},
            ],
          }),
        ),
      });
      final plans = (await BillingFacade(
        BillingRepository(fakeDio(http)),
      ).plans()).getOrElse(() => throw StateError('left'));
      expect(plans.map((p) => p.code), ['free', 'pro', 'team']);
    });
  });

  group('BalanceCubit', () {
    late _MockFacade facade;
    const balance = Balance(balanceSeconds: 60);

    setUp(() => facade = _MockFacade());

    blocTest<BalanceCubit, BalanceState>(
      'loads a workspace balance',
      setUp: () =>
          when(() => facade.balance('w1'))
              .thenAnswer((_) async => const Right(balance)),
      build: () => BalanceCubit(facade),
      act: (cubit) => cubit.load('w1'),
      expect: () => const [
        BalanceState(status: BalanceStatus.loading, workspaceId: 'w1'),
        BalanceState(
          status: BalanceStatus.success,
          workspaceId: 'w1',
          balance: balance,
        ),
      ],
    );

    test('a late answer for an older workspace is dropped', () async {
      final slow = Completer<Either<Failure, Balance>>();
      when(() => facade.balance('w1')).thenAnswer((_) => slow.future);
      when(() => facade.balance('w2'))
          .thenAnswer((_) async => const Right(Balance(balanceSeconds: 120)));
      final cubit = BalanceCubit(facade);

      final first = cubit.load('w1');
      await cubit.load('w2');
      slow.complete(const Right(balance));
      await first;

      expect(cubit.state.workspaceId, 'w2');
      expect(cubit.state.balance?.balanceSeconds, 120);
      await cubit.close();
    });
  });

  group('PlansCubit', () {
    late _MockFacade facade;

    setUp(() => facade = _MockFacade());

    blocTest<PlansCubit, PlansState>(
      'an empty plan list is empty',
      setUp: () =>
          when(() => facade.plans())
              .thenAnswer((_) async => const Right(<Plan>[])),
      build: () => PlansCubit(facade),
      act: (cubit) => cubit.load(),
      expect: () => const [
        PlansState(status: PlansStatus.loading),
        PlansState(status: PlansStatus.empty),
      ],
    );

    blocTest<PlansCubit, PlansState>(
      'a failure is reported',
      setUp: () =>
          when(() => facade.plans())
              .thenAnswer((_) async => const Left(Failure.timeout())),
      build: () => PlansCubit(facade),
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => const [
        PlansState(status: PlansStatus.failure, failure: Failure.timeout()),
      ],
    );
  });
}
