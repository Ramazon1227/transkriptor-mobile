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

/// Its writes wait until released, like a slow keychain.
class _SlowStore extends _Store {
  final _gate = Completer<void>();

  void release() => _gate.complete();

  @override
  Future<void> close(String workspaceId, String period) async {
    await _gate.future;
    await super.close(workspaceId, period);
  }
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
          final allowance = Quota.allowance(
            c['allowance'] as int,
            subscribed: c['subscribed'] as bool? ?? true,
            personal: c['personal'] as bool? ?? true,
          );
          expect(Quota.level(c['left'] as int, allowance).percent, c['level']);
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
      await cubit.load('w1', personal: true);
      expect(cubit.state.level, QuotaLevel.none);
      expect(cubit.state.banner, isFalse);
      await cubit.close();
    });

    test('80 %: marked, no banner', () async {
      answer(_balance(7200));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1', personal: true);
      expect(cubit.state.level, QuotaLevel.low);
      expect(cubit.state.banner, isFalse);
      await cubit.close();
    });

    test('95 %: banner until closed, then not again this period', () async {
      answer(_balance(1200));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1', personal: true);
      expect(cubit.state.level, QuotaLevel.critical);
      expect(cubit.state.banner, isTrue);
      expect(cubit.state.balance?.balanceSeconds, 1200);

      await cubit.dismiss();
      expect(cubit.state.banner, isFalse);
      expect(cubit.state.level, QuotaLevel.critical);
      await cubit.close();

      final again = QuotaWarningCubit(billing, store);
      await again.load('w1', personal: true);
      expect(again.state.banner, isFalse);
      await again.close();
    });

    test('the next period warns again', () async {
      answer(_balance(1200));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1', personal: true);
      await cubit.dismiss();
      answer(_balance(1200, end: DateTime.utc(2027)));
      await cubit.load('w1', personal: true);
      expect(cubit.state.banner, isTrue);
      await cubit.close();
    });

    test('a top-up above 20 % forgets the closed warning', () async {
      answer(_balance(1200));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1', personal: true);
      await cubit.dismiss();
      answer(_balance(30000));
      await cubit.load('w1', personal: true);
      expect(store.map, isEmpty);
      answer(_balance(1200));
      await cubit.load('w1', personal: true);
      expect(cubit.state.banner, isTrue);
      await cubit.close();
    });

    test('an unsubscribed team workspace is never warned', () async {
      // The server answers «Bepul» for it, but free minutes go only to a
      // personal workspace.
      answer(
        const Balance(
          plan: Plan(code: 'free', name: 'Bepul', monthlySeconds: 1800),
        ),
      );
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1', personal: false);
      expect(cubit.state.level, QuotaLevel.none);
      expect(cubit.state.banner, isFalse);
      await cubit.close();
    });

    test(
      'a refresh running while it is closed does not bring it back',
      () async {
        answer(_balance(1200));
        final slowStore = _SlowStore();
        final cubit = QuotaWarningCubit(billing, slowStore);
        await cubit.load('w1', personal: true);
        expect(cubit.state.banner, isTrue);

        final refresh = cubit.load('w1', personal: true);
        final closing = cubit.dismiss();
        await refresh;
        expect(cubit.state.banner, isFalse);
        slowStore.release();
        await closing;
        await cubit.close();
      },
    );

    test('a plan without minutes never warns', () async {
      answer(_balance(0, plan: _pro.copyWith(monthlySeconds: 0)));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1', personal: true);
      expect(cubit.state.level, QuotaLevel.none);
      await cubit.close();
    });

    test('a failed balance call shows nothing and keeps nothing', () async {
      when(() => billing.balance('w1'))
          .thenAnswer((_) async => const Left(Failure.network()));
      final cubit = QuotaWarningCubit(billing, store);
      await cubit.load('w1', personal: true);
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
      final first = cubit.load('w1', personal: true);
      await cubit.load('w2', personal: true);
      slow.complete();
      await first;
      expect(cubit.state.workspaceId, 'w2');
      expect(cubit.state.banner, isFalse);
      await cubit.close();
    });
  });
}
