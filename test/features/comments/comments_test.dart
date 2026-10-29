import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/comments/application/comments_cubit.dart';
import 'package:transkriptor_uz/features/comments/domain/entities/comment.dart';
import 'package:transkriptor_uz/features/comments/domain/i_comments_facade.dart';
import 'package:transkriptor_uz/features/comments/infrastructure/repositories/comments_repository.dart';

import '../../helpers/fake_http_adapter.dart';

class _MockFacade extends Mock implements ICommentsFacade;

const _c1 = Comment(
  id: 'c1',
  segmentId: 'g2',
  body: 'ism xato',
  authorId: 'u1',
);
const _c2 = Comment(id: 'c2', segmentId: 'g1', body: 'shovqin', authorId: 'u2');

Map<String, Object?> _json(String id, String seg, String body) => {
  'id': id,
  'transcript_id': 't1',
  'segment_id': seg,
  'author_id': 'u1',
  'author_name': 'Dilnoza',
  'body': body,
  'resolved_at': null,
  'created_at': '2026-10-29T09:30:00Z',
  'updated_at': '2026-10-29T09:30:00Z',
};

void main() {
  group('CommentsRepository', () {
    test('lists, creates with segment_id + body, patches body only', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/transcript/t1/comments': (
          200,
          ok({
            'items': [_json('c1', 'g1', 'salom')],
            'role': 'MEMBER',
          }),
        ),
        'POST /api/v1/transcript/t1/comments': (
          201,
          ok({'comment': _json('c2', 'g1', 'yangi')}),
        ),
        'PATCH /api/v1/transcript/t1/comments/c2': (
          200,
          ok({'comment': _json('c2', 'g1', 'tuzatildi')}),
        ),
        'DELETE /api/v1/transcript/t1/comments/c2': (
          200,
          ok({'deleted': true}),
        ),
      });
      final repo = CommentsRepository(fakeDio(http));

      final list = (await repo.list('t1'))
          .getOrElse(() => throw StateError(''));
      final entity = list.single.toEntity();
      expect(entity.authorName, 'Dilnoza');
      expect(entity.createdAt, DateTime.utc(2026, 10, 29, 9, 30));

      await repo.create(transcriptId: 't1', segmentId: 'g1', body: 'yangi');
      expect(http.sent.last.body, {'segment_id': 'g1', 'body': 'yangi'});

      final edited = await repo.update(
        transcriptId: 't1',
        commentId: 'c2',
        body: 'tuzatildi',
      );
      expect(edited.isRight(), isTrue);
      // `resolved` is never sent: a comment is a note, not a task.
      expect(http.sent.last.body, {'body': 'tuzatildi'});

      expect(
        (await repo.delete(transcriptId: 't1', commentId: 'c2')).isRight(),
        isTrue,
      );
      expect(http.sent.last.options.method, 'DELETE');
    });
  });

  group('CommentsCubit', () {
    late _MockFacade facade;
    setUp(() => facade = _MockFacade());

    blocTest<CommentsCubit, CommentsState>(
      'loads; none is the empty state',
      setUp: () =>
          when(() => facade.list('t1'))
              .thenAnswer((_) async => const Right([])),
      build: () => CommentsCubit(facade),
      act: (c) => c.load('t1'),
      expect: () => [
        const CommentsState(status: CommentsStatus.loading),
        const CommentsState(status: CommentsStatus.empty),
      ],
    );

    blocTest<CommentsCubit, CommentsState>(
      'adds the stored comment, trimmed text sent',
      setUp: () {
        when(() => facade.list('t1')).thenAnswer((_) async => const Right([]));
        when(
          () => facade.create(transcriptId: 't1', segmentId: 'g1', body: 'ok'),
        ).thenAnswer((_) async => const Right(_c2));
      },
      build: () => CommentsCubit(facade),
      act: (c) async {
        await c.load('t1');
        await c.add('g1', '  ok  ');
      },
      skip: 2,
      expect: () => [
        const CommentsState(
          status: CommentsStatus.empty,
          actionStatus: CommentActionStatus.busy,
        ),
        const CommentsState(
          status: CommentsStatus.success,
          comments: [_c2],
          actionStatus: CommentActionStatus.done,
        ),
      ],
    );

    blocTest<CommentsCubit, CommentsState>(
      'a failed delete keeps the comment and says why',
      setUp: () {
        when(() => facade.list('t1'))
            .thenAnswer((_) async => const Right([_c1]));
        when(
          () => facade.delete(transcriptId: 't1', commentId: 'c1'),
        ).thenAnswer((_) async => const Left(Failure.server(statusCode: 403)));
      },
      build: () => CommentsCubit(facade),
      act: (c) async {
        await c.load('t1');
        await c.delete('c1');
      },
      verify: (c) {
        expect(c.state.comments, [_c1]);
        expect(c.state.actionStatus, CommentActionStatus.failure);
        expect(c.state.actionFailure, const Failure.server(statusCode: 403));
      },
    );

    blocTest<CommentsCubit, CommentsState>(
      'edit replaces in place; delete removes',
      setUp: () {
        when(() => facade.list('t1'))
            .thenAnswer((_) async => const Right([_c1, _c2]));
        when(
          () => facade.update(transcriptId: 't1', commentId: 'c1', body: 'ism'),
        ).thenAnswer((_) async => Right(_c1.copyWith(body: 'ism')));
        when(() => facade.delete(transcriptId: 't1', commentId: 'c2'))
            .thenAnswer((_) async => const Right(unit));
      },
      build: () => CommentsCubit(facade),
      act: (c) async {
        await c.load('t1');
        await c.edit('c1', 'ism');
        await c.delete('c2');
      },
      verify: (c) {
        expect(c.state.comments, [_c1.copyWith(body: 'ism')]);
        expect(c.state.status, CommentsStatus.success);
      },
    );

    test('blank or too long text sends nothing', () async {
      when(() => facade.list('t1')).thenAnswer((_) async => const Right([]));
      final c = CommentsCubit(facade);
      await c.load('t1');
      await c.add('g1', '   ');
      await c.add('g1', 'x' * (CommentRules.maxRunes + 1));
      verifyNever(
        () => facade.create(
          transcriptId: any(named: 'transcriptId'),
          segmentId: any(named: 'segmentId'),
          body: any(named: 'body'),
        ),
      );
      await c.close();
    });

    test('grouped follows the transcript order of segments', () {
      const state = CommentsState(comments: [_c1, _c2]);
      final groups = state.grouped(['g1', 'g2']);
      expect(groups.map((g) => g.$1), ['g1', 'g2']);
      expect(state.grouped(['g2']).map((g) => g.$1), ['g2', 'g1']);
    });
  });
}
