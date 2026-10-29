import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/infrastructure/repositories/job_repository.dart';
import 'package:transkriptor_uz/features/library/infrastructure/repositories/library_repository.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';
import 'package:transkriptor_uz/features/notes/infrastructure/repositories/notes_repository.dart';

import '../../../helpers/fake_http_adapter.dart';

/// Paths and keys as `tr-backend` declares them (`api/handler/note.go`,
/// `library.go`, `job.go`, 2026-10-29).
void main() {
  group('NotesRepository', () {
    test('list sends workspace_id and the cursor, reads the page', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/notes': (
          200,
          ok({
            'items': [
              {
                'id': 'n1',
                'title': '',
                'excerpt': 'Kun tartibi',
                'source_kind': 'TRANSCRIPT',
                'created_at': '2026-10-28T10:00:00Z',
                'updated_at': '2026-10-29T10:00:00Z',
              },
              {'id': 'n2', 'source_kind': 'SOMETHING_NEW'},
            ],
            'next_cursor': 'c2',
          }),
        ),
      });
      final page = (await NotesRepository(fakeDio(http)).list(
        workspaceId: 'w1',
        cursor: 'c1',
      )).getOrElse(() => throw StateError('left')).toEntity();
      expect(http.sent.single.options.queryParameters, {
        'workspace_id': 'w1',
        'cursor': 'c1',
      });
      expect(page.nextCursor, 'c2');
      expect(page.items.first.excerpt, 'Kun tartibi');
      expect(page.items.first.sourceKind, NoteSourceKind.transcript);
      expect(page.items.first.updatedAt, DateTime.utc(2026, 10, 29, 10));
      expect(page.items.last.sourceKind, NoteSourceKind.unknown);
    });

    test('the last page has a null cursor', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/notes': (
          200,
          ok({'items': <Object>[], 'next_cursor': null}),
        ),
      });
      final page = (await NotesRepository(fakeDio(http)).list(
        workspaceId: 'w1',
      )).getOrElse(() => throw StateError('left')).toEntity();
      expect(page.items, isEmpty);
      expect(page.nextCursor, isNull);
      expect(http.sent.single.options.queryParameters, {'workspace_id': 'w1'});
    });

    test('get reads the body into blocks and the source', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/notes/n1': (
          200,
          ok({
            'note': {
              'id': 'n1',
              'title': 'Majlis',
              'revision': 3,
              'source_kind': 'TRANSCRIPT',
              'source': {
                'transcript_id': 't1',
                'title': 'Yigʻilish',
                'available': false,
              },
              'body': {
                'type': 'doc',
                'content': [
                  {
                    'type': 'paragraph',
                    'content': [
                      {'type': 'text', 'text': 'Salom'},
                    ],
                  },
                ],
              },
            },
          }),
        ),
      });
      final note = (await NotesRepository(fakeDio(http)).get('n1'))
          .getOrElse(() => throw StateError('left'))
          .toEntity();
      expect(note.revision, 3);
      expect(note.blocks.single.text, 'Salom');
      expect(note.origin?.transcriptId, 't1');
      expect(note.origin?.available, isFalse);
    });

    test('rename sends only title and revision; delete by path', () async {
      final http = FakeHttpAdapter({
        'PATCH /api/v1/notes/n1': (
          200,
          ok({
            'note': {'id': 'n1', 'title': 'Yangi', 'revision': 4},
          }),
        ),
        'DELETE /api/v1/notes/n1': (200, ok({'removed': true})),
      });
      final repo = NotesRepository(fakeDio(http));
      final renamed = (await repo.rename(
        id: 'n1',
        title: 'Yangi',
        revision: 3,
      )).getOrElse(() => throw StateError('left'));
      expect(http.sent.first.body, {'title': 'Yangi', 'revision': 3});
      expect(renamed.revision, 4);
      expect((await repo.delete('n1')).isRight(), isTrue);
    });

    test('a stale revision is a 409 failure', () async {
      final http = FakeHttpAdapter({
        'PATCH /api/v1/notes/n1': (409, {'status': 'CONFLICT'}),
      });
      final result = await NotesRepository(fakeDio(http))
          .rename(id: 'n1', title: 'X', revision: 1);
      expect(
        result.swap().getOrElse(() => throw StateError('right')),
        isA<ServerFailure>().having((f) => f.statusCode, 'status', 409),
      );
    });
  });

  group('LibraryRepository file actions', () {
    test('source narrows the list', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/library': (
          200,
          ok({
            'items': [
              {
                'media_id': 'm1',
                'source': 'RECORDING',
                'meeting_title': 'Haftalik yigʻilish',
              },
              {'media_id': 'm2', 'source': 'RECORDING', 'meeting_title': ''},
            ],
          }),
        ),
      });
      final items = (await LibraryRepository(fakeDio(http)).getItems(
        workspaceId: 'w1',
        source: 'RECORDING',
      )).getOrElse(() => throw StateError('left'));
      expect(http.sent.single.options.queryParameters, {
        'workspace_id': 'w1',
        'source': 'RECORDING',
      });
      expect(items.first.toEntity().meetingTitle, 'Haftalik yigʻilish');
      expect(items.last.toEntity().meetingTitle, isNull);
    });

    test('rename patches display_name; delete hits the media path', () async {
      final http = FakeHttpAdapter({
        'PATCH /api/v1/media/m1': (
          200,
          ok({
            'item': {'media_id': 'm1', 'name': 'Yangi nom'},
          }),
        ),
        'DELETE /api/v1/media/m1': (200, ok({'deleted': true})),
      });
      final repo = LibraryRepository(fakeDio(http));
      final item = (await repo.updateMedia(
        mediaId: 'm1',
        patch: {'display_name': 'Yangi nom'},
      )).getOrElse(() => throw StateError('left'));
      expect(item.name, 'Yangi nom');
      expect(http.sent.first.body, {'display_name': 'Yangi nom'});
      expect((await repo.deleteMedia('m1')).isRight(), isTrue);
      expect(http.sent.last.options.method, 'DELETE');
    });
  });

  group('JobRepository retranscribe', () {
    test('reads num_speakers and sends it back with a fresh key', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/job/j1': (
          200,
          ok({
            'id': 'j1',
            'media_id': 'm1',
            'status': 'FAILED',
            'num_speakers': 3,
          }),
        ),
        'POST /api/v1/job': (
          202,
          ok({'id': 'j2', 'media_id': 'm1', 'status': 'QUEUED'}),
        ),
      });
      final repo = JobRepository(fakeDio(http));
      final previous = (await repo.getJob('j1'))
          .getOrElse(() => throw StateError('left'))
          .toEntity();
      expect(previous.numSpeakers, 3);
      await repo.createJob(mediaId: 'm1', numSpeakers: previous.numSpeakers);
      await repo.createJob(mediaId: 'm1');
      final first = http.sent[1].body! as Map<String, Object?>;
      final second = http.sent[2].body! as Map<String, Object?>;
      expect(first['num_speakers'], 3);
      expect(first['idempotency_key'], isNot(second['idempotency_key']));
    });
  });

  group('NoteDocument', () {
    test('headings, lists, quotes and code keep their shape', () {
      final blocks = NoteDocument.parse({
        'type': 'doc',
        'content': [
          {
            'type': 'heading',
            'attrs': {'level': 2},
            'content': [
              {'type': 'text', 'text': 'Qarorlar'},
            ],
          },
          {
            'type': 'orderedList',
            'attrs': {'start': 3},
            'content': [
              {
                'type': 'listItem',
                'content': [
                  {
                    'type': 'paragraph',
                    'content': [
                      {
                        'type': 'text',
                        'text': 'Birinchi',
                        'marks': [
                          {'type': 'bold'},
                        ],
                      },
                    ],
                  },
                  {
                    'type': 'bulletList',
                    'content': [
                      {
                        'type': 'listItem',
                        'content': [
                          {
                            'type': 'paragraph',
                            'content': [
                              {'type': 'text', 'text': 'ichki'},
                            ],
                          },
                        ],
                      },
                    ],
                  },
                ],
              },
              {
                'type': 'listItem',
                'content': [
                  {
                    'type': 'paragraph',
                    'content': [
                      {'type': 'text', 'text': 'Ikkinchi'},
                      {'type': 'hardBreak'},
                      {'type': 'text', 'text': 'davomi'},
                    ],
                  },
                ],
              },
            ],
          },
          {
            'type': 'blockquote',
            'content': [
              {
                'type': 'paragraph',
                'content': [
                  {'type': 'text', 'text': 'Iqtibos'},
                ],
              },
            ],
          },
          {
            'type': 'codeBlock',
            'content': [
              {'type': 'text', 'text': 'x = 1'},
            ],
          },
          {'type': 'mysteryNode'},
        ],
      });
      expect(
        blocks[0],
        const NoteBlock(
          kind: NoteBlockKind.heading,
          text: 'Qarorlar',
          level: 2,
        ),
      );
      expect(blocks[1].marker, '3.');
      expect(blocks[1].text, 'Birinchi');
      expect(blocks[2].marker, '•');
      expect(blocks[2].depth, 1);
      expect(blocks[3].marker, '4.');
      expect(blocks[3].text, 'Ikkinchi\ndavomi');
      expect(blocks[4].quoted, isTrue);
      expect(blocks[5].kind, NoteBlockKind.code);
      expect(blocks, hasLength(6));
      expect(
        NoteDocument.plainText(blocks),
        'Qarorlar\n3. Birinchi\n  • ichki\n4. Ikkinchi\ndavomi\nIqtibos\nx = 1',
      );
    });

    test('a missing or broken body is no blocks, not a crash', () {
      expect(NoteDocument.parse(null), isEmpty);
      expect(NoteDocument.parse({'type': 'doc', 'content': 'oops'}), isEmpty);
    });

    test('titles: one line, at most 200 characters, empty allowed', () {
      expect(
        NoteRules.normalizeTitle('  Yangi\n  sarlavha '),
        'Yangi sarlavha',
      );
      expect(NoteRules.normalizeTitle(''), '');
      expect(NoteRules.normalizeTitle('a' * 201), isNull);
    });
  });
}
