import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/billing/application/quota_warning_cubit.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';
import 'package:transkriptor_uz/features/billing/domain/i_quota_warning_facade.dart';
import 'package:transkriptor_uz/features/billing/domain/quota.dart';

class _Billing extends Mock implements IBillingFacade;

/// In-memory store, like the keychain.
class _Store implements IQuotaWarningFacade {
  final map = <String, String>{};

  @override
  Future<String?> closedPeriod(String workspaceId) async => map[workspaceId];

  @override
  Future<void> close(String workspaceId, String period) async =>
      map[workspaceId] = period;

  @override
  Future<void> forget(String workspaceId) async => map.remove(workspaceId);
}

const _pro = Plan(
  code: 'pro',
  name: 'Pro',
  monthlySeconds: 36000,
  priceUzs: 99000,
  maxMembers: 1,
);

Balance _balance(int left, {DateTime? end, Plan? plan = _pro}) => Balance(
  balanceSeconds: left,
  plan: plan,
  status: SubscriptionStatus.active,
  periodEnd: end ?? DateTime.utc(2026, 12),
);

void main() {
  // The web runs the same file (tr-frontend/src/lib/quota.fixtures.json);
  // copy it here when the rule changes, do not edit it by hand.
  final shared = jsonDecode(
    File('test/fixtures/quota_cases.json').readAsStringSync(),
  ) as Map<String, dynamic>;

  group('Quota.level, shared with the web', () {
    for (final c in (shared['cases'] as List).cast<Map<String, dynamic>>()) {
      test(
        '${c['left']} / ${c['allowance']} → ${c['level']} (${c['why']})',
        () {
          expect(
            Quota.level(c['left'] as int, c['allowance'] as int).percent,
            c['level'],
          );
        },
      );
    }
  });

  group('QuotaWarningCubit', () {
    late _Billing billing;
    late _Store store;

    setUp(() {
      billing = _Billing();
      store = _Store();
    });

    void answer(Balance b) =>
        when(() => billing.balance('w1')).thenAnswer((_) async => Right(b));

    test('nothing while most of the plan is left', () async {
      answer(_balance(30000));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1');
      expect(cubit.state.level, QuotaLevel.none);
      expect(cubit.state.banner, isFalse);
      await cubit.close();
    });

    test('80 %: marked, no banner', () async {
      answer(_balance(7200));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1');
      expect(cubit.state.level, QuotaLevel.low);
      expect(cubit.state.banner, isFalse);
      await cubit.close();
    });

    test('95 %: banner until closed, then not again this period', () async {
      answer(_balance(1200));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1');
      expect(cubit.state.level, QuotaLevel.critical);
      expect(cubit.state.banner, isTrue);
      expect(cubit.state.balance?.balanceSeconds, 1200);

      await cubit.dismiss();
      expect(cubit.state.banner, isFalse);
      expect(cubit.state.level, QuotaLevel.critical);
      await cubit.close();

      final again = QuotaWarningCubit(billing, store);
      await again.load('w1');
      expect(again.state.banner, isFalse);
      await again.close();
    });

    test('the next period warns again', () async {
      answer(_balance(1200));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1');
      await cubit.dismiss();
      answer(_balance(1200, end: DateTime.utc(2027)));
      await cubit.load('w1');
      expect(cubit.state.banner, isTrue);
      await cubit.close();
    });

    test('a top-up above 20 % forgets the closed warning', () async {
      answer(_balance(1200));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1');
      await cubit.dismiss();
      answer(_balance(30000));
      await cubit.load('w1');
      expect(store.map, isEmpty);
      answer(_balance(1200));
      await cubit.load('w1');
      expect(cubit.state.banner, isTrue);
      await cubit.close();
    });

    test('a plan without minutes never warns', () async {
      answer(_balance(0, plan: _pro.copyWith(monthlySeconds: 0)));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1');
      expect(cubit.state.level, QuotaLevel.none);
      await cubit.close();
    });

    test('a failed balance call shows nothing and keeps nothing', () async {
      when(() => billing.balance('w1'))
          .thenAnswer((_) async => const Left(Failure.network()));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1');
      expect(cubit.state.level, QuotaLevel.none);
      expect(cubit.state.banner, isFalse);
      await cubit.close();
    });

    test('a late answer for another workspace is dropped', () async {
      final slow = Completer<void>();
      when(() => billing.balance('w1')).thenAnswer((_) async {
        await slow.future;
        return Right(_balance(1200));
      });
      when(() => billing.balance('w2'))
          .thenAnswer((_) async => Right(_balance(30000)));
      final cubit = QuotaWarningCubit(billing, store);
      final first = cubit.load('w1');
      await cubit.load('w2');
      slow.complete();
      await first;
      expect(cubit.state.workspaceId, 'w2');
      expect(cubit.state.banner, isFalse);
      await cubit.close();
    });
  });
}
