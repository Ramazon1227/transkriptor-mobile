import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/notes/application/note_cubit.dart';
import 'package:transkriptor_uz/features/notes/application/notes_cubit.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/i_notes_facade.dart';

class _MockNotesFacade extends Mock implements INotesFacade;

const _a = NoteSummary(id: 'n1', title: 'Majlis', excerpt: 'kun tartibi');
const _b = NoteSummary(id: 'n2', excerpt: 'Sud qarori');
const _c = NoteSummary(id: 'n3', title: 'Uchinchi');
const _note = Note(id: 'n1', title: 'Majlis', revision: 2);

void main() {
  late _MockNotesFacade facade;

  setUp(() => facade = _MockNotesFacade());

  group('NotesCubit', () {
    blocTest<NotesCubit, NotesState>(
      'loads the first page and keeps the cursor',
      setUp: () => when(() => facade.list(workspaceId: 'w1')).thenAnswer(
        (_) async => const Right(NotesPage(items: [_a, _b], nextCursor: 'c')),
      ),
      build: () => NotesCubit(facade),
      act: (c) => c.load('w1'),
      expect: () => const [
        NotesState(status: NotesStatus.loading),
        NotesState(
          status: NotesStatus.success,
          items: [_a, _b],
          nextCursor: 'c',
        ),
      ],
    );

    blocTest<NotesCubit, NotesState>(
      'no notes is empty, not failure',
      setUp: () =>
          when(() => facade.list(workspaceId: 'w1'))
              .thenAnswer((_) async => const Right(NotesPage())),
      build: () => NotesCubit(facade),
      act: (c) => c.load('w1'),
      skip: 1,
      expect: () => const [NotesState(status: NotesStatus.empty)],
    );

    blocTest<NotesCubit, NotesState>(
      'the next page is appended; the last one clears the cursor',
      setUp: () {
        when(() => facade.list(workspaceId: 'w1')).thenAnswer(
          (_) async => const Right(NotesPage(items: [_a, _b], nextCursor: 'c')),
        );
        when(() => facade.list(workspaceId: 'w1', cursor: 'c'))
            .thenAnswer((_) async => const Right(NotesPage(items: [_c])));
      },
      build: () => NotesCubit(facade),
      act: (c) async {
        await c.load('w1');
        await c.loadMore();
        await c.loadMore(); // no cursor: nothing is sent
      },
      skip: 2,
      expect: () => const [
        NotesState(
          status: NotesStatus.success,
          items: [_a, _b],
          nextCursor: 'c',
          loadingMore: true,
        ),
        NotesState(status: NotesStatus.success, items: [_a, _b, _c]),
      ],
      verify: (_) =>
          verify(() => facade.list(workspaceId: 'w1', cursor: 'c')).called(1),
    );

    blocTest<NotesCubit, NotesState>(
      'a failed refresh keeps the rows',
      setUp: () {
        var calls = 0;
        when(() => facade.list(workspaceId: 'w1')).thenAnswer(
          (_) async => calls++ == 0
              ? const Right(NotesPage(items: [_a]))
              : const Left(Failure.network()),
        );
      },
      build: () => NotesCubit(facade),
      act: (c) async {
        await c.load('w1');
        await c.refresh();
      },
      skip: 3,
      expect: () => const [
        NotesState(
          status: NotesStatus.success,
          items: [_a],
          failure: Failure.network(),
        ),
      ],
    );

    test('the search matches title or excerpt, any case', () {
      const state = NotesState(items: [_a, _b, _c], query: 'SUD');
      expect(state.visibleItems, [_b]);
      expect(state.copyWith(query: 'majl').visibleItems, [_a]);
      expect(state.copyWith(query: '').visibleItems, [_a, _b, _c]);
    });
  });

  group('NoteCubit', () {
    blocTest<NoteCubit, NoteState>(
      'rename sends the revision it has and keeps the answer',
      setUp: () {
        when(() => facade.get('n1'))
            .thenAnswer((_) async => const Right(_note));
        when(() => facade.rename(id: 'n1', title: 'Yangi', revision: 2))
            .thenAnswer(
              (_) async =>
                  const Right(Note(id: 'n1', title: 'Yangi', revision: 3)),
            );
      },
      build: () => NoteCubit(facade),
      act: (c) async {
        await c.load('n1');
        await c.rename('Yangi');
      },
      skip: 2,
      expect: () => const [
        NoteState(
          status: NoteStatus.success,
          noteId: 'n1',
          note: _note,
          actionStatus: NoteActionStatus.busy,
        ),
        NoteState(
          status: NoteStatus.success,
          noteId: 'n1',
          note: Note(id: 'n1', title: 'Yangi', revision: 3),
          actionStatus: NoteActionStatus.done,
          changed: true,
        ),
      ],
    );

    blocTest<NoteCubit, NoteState>(
      'a stale rename stays as a failure; the note is unchanged',
      setUp: () {
        when(() => facade.get('n1'))
            .thenAnswer((_) async => const Right(_note));
        when(
          () => facade.rename(id: 'n1', title: 'Yangi', revision: 2),
        ).thenAnswer((_) async => const Left(Failure.server(statusCode: 409)));
      },
      build: () => NoteCubit(facade),
      act: (c) async {
        await c.load('n1');
        await c.rename('Yangi');
      },
      skip: 3,
      expect: () => const [
        NoteState(
          status: NoteStatus.success,
          noteId: 'n1',
          note: _note,
          actionStatus: NoteActionStatus.failure,
          actionFailure: Failure.server(statusCode: 409),
        ),
      ],
    );

    blocTest<NoteCubit, NoteState>(
      'delete marks the note deleted and changed',
      setUp: () {
        when(() => facade.get('n1'))
            .thenAnswer((_) async => const Right(_note));
        when(() => facade.delete('n1'))
            .thenAnswer((_) async => const Right(unit));
      },
      build: () => NoteCubit(facade),
      act: (c) async {
        await c.load('n1');
        await c.delete();
      },
      verify: (c) {
        expect(c.state.deleted, isTrue);
        expect(c.state.changed, isTrue);
        expect(c.state.actionStatus, NoteActionStatus.done);
      },
    );

    blocTest<NoteCubit, NoteState>(
      'the same title sends nothing',
      setUp: () =>
          when(() => facade.get('n1'))
              .thenAnswer((_) async => const Right(_note)),
      build: () => NoteCubit(facade),
      act: (c) async {
        await c.load('n1');
        await c.rename('Majlis');
      },
      verify: (c) {
        expect(c.state.actionStatus, NoteActionStatus.done);
        expect(c.state.changed, isFalse);
        verifyNever(
          () => facade.rename(
            id: any(named: 'id'),
            title: any(named: 'title'),
            revision: any(named: 'revision'),
          ),
        );
      },
    );
  });
}
