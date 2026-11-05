import 'dart:async';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';
import 'package:transkriptor_uz/features/glossary/domain/entities/glossary.dart';
import 'package:transkriptor_uz/features/glossary/domain/i_glossary_facade.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/upload/application/advanced_settings_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/advanced_rules.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/advanced_options.dart';

class _Library extends Mock implements ILibraryFacade;

class _Glossaries extends Mock implements IGlossaryFacade;

class _Billing extends Mock implements IBillingFacade;

const _personal = Workspace(
  id: 'w1',
  name: 'Shaxsiy',
  isPersonal: true,
  balanceSeconds: 600,
  role: WorkspaceRole.owner,
);
const _team = Workspace(id: 'w2', name: 'Jamoa', role: WorkspaceRole.member);
const _readOnly = Workspace(
  id: 'w3',
  name: 'Arxiv',
  role: WorkspaceRole.viewer,
);
const _source = HintSource(key: '/a.mp3', name: 'a.mp3', path: '/a.mp3');

void main() {
  late _Library library;
  late _Glossaries glossaries;
  late _Billing billing;

  setUp(() {
    library = _Library();
    glossaries = _Glossaries();
    billing = _Billing();
    when(() => library.getFolders(workspaceId: 'w1')).thenAnswer(
      (_) async => const Right([Folder(id: 'f1', name: 'Hisobotlar')]),
    );
    when(() => glossaries.glossaries(workspaceId: 'w1')).thenAnswer(
      (_) async =>
          const Right([Glossary(id: 'g1', name: 'Kengash', termCount: 4)]),
    );
    when(() => billing.balance('w1'))
        .thenAnswer((_) async => const Right(Balance(balanceSeconds: 1200)));
    when(
      () => library.getFolders(workspaceId: 'w2'),
    ).thenAnswer((_) async => const Right([Folder(id: 'f2', name: 'Loyiha')]));
    when(() => glossaries.glossaries(workspaceId: 'w2'))
        .thenAnswer((_) async => const Right([]));
    when(() => billing.balance('w2'))
        .thenAnswer((_) async => const Right(Balance(balanceSeconds: 60)));
  });

  AdvancedSettingsCubit make() =>
      AdvancedSettingsCubit(library, glossaries, billing);

  Future<AdvancedSettingsCubit> started({
    AdvancedOptions initial = const AdvancedOptions(workspaceId: 'w1'),
    bool locked = false,
    List<HintSource> sources = const [_source],
  }) async {
    final cubit = make()
      ..start(
        initial: initial,
        workspaces: const [_personal, _team, _readOnly],
        sources: sources,
        destinationLocked: locked,
      );
    await pumpEventQueue();
    return cubit;
  }

  test(
    'start keeps writable workspaces and loads the destination’s lists',
    () async {
      final cubit = await started();
      final s = cubit.state;
      expect(s.workspaces.map((w) => w.id), ['w1', 'w2']);
      expect(s.draft.workspaceName, 'Shaxsiy');
      expect(s.folders.single.name, 'Hisobotlar');
      expect(s.glossaries.single.name, 'Kengash');
      expect(s.balanceSeconds, 1200);
      expect(s.foldersStatus, AdvancedLoad.success);
      expect(s.open, isNull); // every fold starts closed
      expect(s.source, _source);
      await cubit.close();
    },
  );

  test('one failed list keeps the others', () async {
    when(() => glossaries.glossaries(workspaceId: 'w1'))
        .thenAnswer((_) async => const Left(Failure.network()));
    final cubit = await started();
    expect(cubit.state.glossariesStatus, AdvancedLoad.failure);
    expect(cubit.state.foldersStatus, AdvancedLoad.success);
    expect(cubit.state.balanceSeconds, 1200);
    await cubit.close();
  });

  test('changing the workspace clears folder and list, then reloads', () async {
    final cubit = await started();
    cubit
      ..selectFolder(const Folder(id: 'f1', name: 'Hisobotlar'))
      ..selectGlossary(const Glossary(id: 'g1', name: 'Kengash'));
    expect(cubit.state.draft.folderId, 'f1');
    cubit.selectWorkspace(_team);
    final draft = cubit.state.draft;
    expect(draft.workspaceId, 'w2');
    expect(draft.workspaceName, 'Jamoa');
    expect(draft.folderId, isNull);
    expect(draft.folderName, '');
    expect(draft.glossaryId, isNull);
    await pumpEventQueue();
    expect(cubit.state.folders.single.id, 'f2');
    expect(cubit.state.balanceSeconds, 60);
    await cubit.close();
  });

  test('a late answer for the previous workspace is dropped', () async {
    final slow = Completer<Either<Failure, List<Folder>>>();
    when(() => library.getFolders(workspaceId: 'w1'))
        .thenAnswer((_) => slow.future);
    final cubit = await started();
    cubit.selectWorkspace(_team);
    await pumpEventQueue();
    slow.complete(const Right([Folder(id: 'f1', name: 'Hisobotlar')]));
    await pumpEventQueue();
    expect(cubit.state.folders.single.id, 'f2');
    await cubit.close();
  });

  test('a locked destination does not change', () async {
    final cubit = await started(locked: true);
    cubit
      ..selectWorkspace(_team)
      ..selectFolder(const Folder(id: 'f1', name: 'Hisobotlar'));
    expect(cubit.state.draft.workspaceId, 'w1');
    expect(cubit.state.draft.folderId, isNull);
    await cubit.close();
  });

  test('only one fold is open; tapping it again closes it', () async {
    final cubit = await started();
    cubit.toggle(AdvancedSection.hints);
    expect(cubit.state.open, AdvancedSection.hints);
    cubit.toggle(AdvancedSection.hints);
    expect(cubit.state.open, isNull);
    await cubit.close();
  });

  group('hints', () {
    test('adds, merges one person and refuses another over it', () async {
      final cubit = await started();
      expect(
        cubit.addHint(label: 'Sarvar', start: '0:10', end: '0:20'),
        isTrue,
      );
      expect(
        cubit.addHint(label: 'sarvar', start: '0:15', end: '0:25'),
        isTrue,
      );
      expect(cubit.state.sourceHints, const [
        SpeakerHint(label: 'Sarvar', startMs: 10000, endMs: 25000),
      ]);
      expect(
        cubit.addHint(label: 'Dilnoza', start: '0:24', end: '0:30'),
        isFalse,
      );
      expect(cubit.state.hintProblem, isA<HintOverlap>());
      await cubit.close();
    });

    test('a bad time and an end past the file are refused', () async {
      final cubit = await started();
      expect(cubit.addHint(label: 'A', start: 'x', end: '0:20'), isFalse);
      expect(cubit.state.hintProblem, isA<HintBadTime>());
      expect(
        cubit.addHint(
          label: 'A',
          start: '0:10',
          end: '0:40',
          length: const Duration(seconds: 30),
        ),
        isFalse,
      );
      expect(cubit.state.hintProblem, isA<HintPastEnd>());
      await cubit.close();
    });

    test('hints belong to the chosen file', () async {
      const other = HintSource(key: '/b.mp3', name: 'b.mp3', path: '/b.mp3');
      final cubit = await started(sources: const [_source, other]);
      cubit
        ..addHint(label: 'A', start: '0:00', end: '0:05')
        ..selectSource('/b.mp3');
      expect(cubit.state.sourceHints, isEmpty);
      cubit.addHint(label: 'B', start: '0:00', end: '0:05');
      expect(cubit.state.draft.hints.keys, ['/a.mp3', '/b.mp3']);
      cubit.removeHint(cubit.state.sourceHints.single);
      expect(cubit.state.draft.hints.keys, ['/a.mp3']);
      await cubit.close();
    });

    test('no file to play: nothing is added', () async {
      final cubit = await started(sources: const []);
      expect(cubit.state.source, isNull);
      expect(cubit.addHint(label: 'A', start: '0:00', end: '0:05'), isFalse);
      await cubit.close();
    });
  });

  test('save is blocked while terms or people break a rule', () async {
    final cubit = await started();
    cubit
      ..addHint(label: 'A', start: '0:00', end: '0:05')
      ..addHint(label: 'B', start: '0:10', end: '0:15')
      ..setSpeakers(1);
    expect(cubit.state.problem, isA<PeopleExceedSpeakers>());
    expect(cubit.save(), isNull);
    cubit
      ..setSpeakers(2)
      ..setTerms('ж' * 121);
    expect(cubit.state.problem, isA<TermTooLong>());
    cubit.setTerms('IT Park');
    final saved = cubit.save();
    expect(saved?.numSpeakers, 2);
    expect(saved?.terms, ['IT Park']);
    expect(saved?.hintCount, 2);
    await cubit.close();
  });
}
