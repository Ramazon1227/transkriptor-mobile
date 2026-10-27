import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/share/application/share_cubit.dart';
import 'package:transkriptor_uz/features/share/domain/entities/share_link.dart';
import 'package:transkriptor_uz/features/share/domain/i_share_facade.dart';
import 'package:transkriptor_uz/features/share/infrastructure/facades/share_facade.dart';
import 'package:transkriptor_uz/features/share/infrastructure/models/share_link_model.dart';
import 'package:transkriptor_uz/features/share/infrastructure/repositories/share_repository.dart';

class _MockShareFacade extends Mock implements IShareFacade;

class _MockShareRepository extends Mock implements ShareRepository;

void main() {
  late _MockShareFacade facade;

  const old = ShareLink(id: 'l0', viewCount: 3);
  const made = ShareLink(
    id: 'l1',
    includeMedia: true,
    url: 'https://app.test/s/tok',
  );

  setUp(() => facade = _MockShareFacade());

  void listAnswers(List<ShareLink> links) =>
      when(() => facade.listLinks('t1')).thenAnswer((_) async => Right(links));

  blocTest<ShareCubit, ShareState>(
    'loads the live links',
    setUp: () => listAnswers(const [old]),
    build: () => ShareCubit(facade),
    act: (cubit) => cubit.load('t1'),
    expect: () => const [
      ShareState(listStatus: ShareListStatus.loading),
      ShareState(listStatus: ShareListStatus.success, links: [old]),
    ],
  );

  blocTest<ShareCubit, ShareState>(
    'no links is empty, not failure',
    setUp: () => listAnswers(const []),
    build: () => ShareCubit(facade),
    act: (cubit) => cubit.load('t1'),
    skip: 1,
    expect: () => const [ShareState(listStatus: ShareListStatus.empty)],
  );

  blocTest<ShareCubit, ShareState>(
    'create sends the chosen options, keeps the link, reloads the list',
    setUp: () {
      listAnswers(const [old]);
      when(
        () => facade.createLink(
          transcriptId: 't1',
          includeMedia: false,
          expiresDays: 7,
        ),
      ).thenAnswer((_) async => const Right(made));
    },
    build: () => ShareCubit(facade),
    act: (cubit) async {
      await cubit.load('t1');
      listAnswers(const [made, old]);
      cubit
        ..setIncludeMedia(value: false)
        ..setExpiresDays(7);
      await cubit.create();
    },
    skip: 4,
    expect: () => const [
      ShareState(
        listStatus: ShareListStatus.success,
        links: [old],
        actionStatus: ShareActionStatus.busy,
        includeMedia: false,
        expiresDays: 7,
      ),
      ShareState(
        listStatus: ShareListStatus.success,
        links: [old],
        created: made,
        includeMedia: false,
        expiresDays: 7,
      ),
      ShareState(
        listStatus: ShareListStatus.success,
        links: [made, old],
        created: made,
        includeMedia: false,
        expiresDays: 7,
      ),
    ],
  );

  blocTest<ShareCubit, ShareState>(
    'a failed create keeps the list',
    setUp: () {
      listAnswers(const [old]);
      when(
        () => facade.createLink(
          transcriptId: any(named: 'transcriptId'),
          includeMedia: any(named: 'includeMedia'),
          expiresDays: any(named: 'expiresDays'),
        ),
      ).thenAnswer((_) async => const Left(Failure.server(statusCode: 403)));
    },
    build: () => ShareCubit(facade),
    act: (cubit) async {
      await cubit.load('t1');
      await cubit.create();
    },
    verify: (cubit) {
      expect(cubit.state.links, const [old]);
      expect(cubit.state.created, isNull);
      expect(cubit.state.actionFailure, const Failure.server(statusCode: 403));
    },
  );

  blocTest<ShareCubit, ShareState>(
    'revoke removes the link, and forgets it if it was the new one',
    setUp: () =>
        when(() => facade.revokeLink('l1'))
            .thenAnswer((_) async => const Right(unit)),
    build: () => ShareCubit(facade),
    seed: () => const ShareState(
      listStatus: ShareListStatus.success,
      links: [made, old],
      created: made,
    ),
    act: (cubit) => cubit.revoke('l1'),
    skip: 1,
    expect: () => const [
      ShareState(listStatus: ShareListStatus.success, links: [old]),
    ],
  );

  blocTest<ShareCubit, ShareState>(
    'revoking the last link leaves the list empty',
    setUp: () =>
        when(() => facade.revokeLink('l0'))
            .thenAnswer((_) async => const Right(unit)),
    build: () => ShareCubit(facade),
    seed: () =>
        const ShareState(listStatus: ShareListStatus.success, links: [old]),
    act: (cubit) => cubit.revoke('l0'),
    skip: 1,
    expect: () => const [ShareState(listStatus: ShareListStatus.empty)],
  );

  test('a late list answer never overwrites a newer one', () async {
    final slow = Completer<Either<Failure, List<ShareLink>>>();
    var calls = 0;
    when(() => facade.listLinks('t1')).thenAnswer((_) {
      calls++;
      return calls == 1 ? slow.future : Future.value(const Right([made]));
    });
    final cubit = ShareCubit(facade);
    addTearDown(cubit.close);

    final first = cubit.load('t1');
    await cubit.load('t1');
    slow.complete(const Right([old]));
    await first;
    expect(cubit.state.links, const [made]);
  });

  test('an unknown expiry is ignored', () {
    final cubit = ShareCubit(facade)..setExpiresDays(12);
    addTearDown(cubit.close);
    expect(cubit.state.expiresDays, 30);
  });

  test('a created link without url is a parsing failure', () async {
    final repository = _MockShareRepository();
    when(
      () => repository.createLink(
        transcriptId: 't1',
        includeMedia: true,
        expiresDays: 30,
      ),
    ).thenAnswer((_) async => const Right(ShareLinkModel(id: 'l1')));
    final result = await ShareFacade(repository)
        .createLink(transcriptId: 't1', includeMedia: true, expiresDays: 30);
    expect(result.fold((f) => f, (_) => null), const Failure.parsing());
  });
}
