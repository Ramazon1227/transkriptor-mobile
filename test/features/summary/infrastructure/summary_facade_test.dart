import 'package:dartz/dartz.dart' show Either;
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/demo/demo_summary_repository.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/facades/summary_facade.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/note_doc.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/repositories/note_repository.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/repositories/summary_repository.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/repositories/summary_template_repository.dart';

import '../../../helpers/fake_http_adapter.dart';
import '../../../helpers/transcripts.dart';

void main() {
  late FakeHttpAdapter adapter;

  SummaryFacade facade(Map<String, (int, Object?)> routes) {
    adapter = FakeHttpAdapter(routes);
    final dio = fakeDio(adapter);
    return SummaryFacade(
      SummaryTemplateRepository(dio),
      NoteRepository(dio),
      SummaryRepository(dio),
      DemoSummaryRepository.custom(delay: Duration.zero),
    );
  }

  test('templates: categories sorted, owners mapped, unknowns safe', () async {
    final f = facade({
      'GET /api/v1/summary-templates': (
        200,
        ok({
          'categories': [
            {'id': 'c2', 'name': 'Taʼlim', 'position': 20, 'templates': 1},
            {'id': 'c1', 'name': 'Yigʻilish', 'position': 10},
          ],
          'templates': [
            {
              'id': 't1',
              'owner': 'SYSTEM',
              'category_id': 'c1',
              'name': 'Asosiy xulosa',
              'prompt': 'Qisqa yoz',
              'favorite': false,
            },
            {
              'id': 't2',
              'owner': 'USER',
              'category_id': null,
              'name': 'Mening',
              'favorite': true,
            },
            {'id': 't3', 'owner': 'ROBOT', 'name': 'G‘alati'},
          ],
        }),
      ),
    });
    final lib = (await f.templates()).getOrElse(() => throw StateError(''));
    expect(lib.categories.map((c) => c.id), ['c1', 'c2']);
    expect(lib.templates[0].owner, SummaryTemplateOwner.system);
    expect(lib.mine.single.id, 't2');
    expect(lib.templates[2].owner, SummaryTemplateOwner.unknown);
    expect(lib.inCategory('c1').single.name, 'Asosiy xulosa');
    expect(lib.preferred?.id, 't2'); // starred wins
  });

  test('star is PUT, unstar is DELETE', () async {
    final f = facade({
      'PUT /api/v1/summary-templates/t1/favorite': (
        200,
        ok({'favorite': true}),
      ),
      'DELETE /api/v1/summary-templates/t1/favorite': (
        200,
        ok({'favorite': false}),
      ),
    });
    expect(
      (await f.setFavorite('t1', favorite: true)).getOrElse(() => false),
      isTrue,
    );
    expect(
      (await f.setFavorite('t1', favorite: false)).getOrElse(() => true),
      isFalse,
    );
    expect(adapter.sent.map((r) => r.options.method), ['PUT', 'DELETE']);
  });

  test('save as note posts a Tiptap doc sourced from the transcript', () async {
    final f = facade({
      'POST /api/v1/notes': (
        201,
        ok({
          'note': {'id': 'n1'},
        }),
      ),
    });
    final result = await f.saveAsNote(
      transcriptId: 'tr1',
      title: 'x' * 250,
      sections: const [
        SummarySection(
          kind: SummarySectionKind.overview,
          title: 'Qisqacha',
          paragraph: 'Matn',
        ),
        SummarySection(
          kind: SummarySectionKind.keyPoints,
          title: 'Asosiy fikrlar',
          bullets: ['Bir', 'Ikki'],
        ),
      ],
    );
    expect(result.getOrElse(() => ''), 'n1');
    final body = adapter.sent.single.body! as Map<String, dynamic>;
    expect(body['source_transcript_id'], 'tr1');
    expect((body['title'] as String).runes.length, noteTitleMaxLength);
    final doc = body['body'] as Map<String, dynamic>;
    expect(doc['type'], 'doc');
    final types = (doc['content'] as List)
        .map((n) => (n as Map)['type'])
        .toList();
    expect(types, ['heading', 'paragraph', 'heading', 'bulletList']);
    final list = (doc['content'] as List).last as Map;
    expect((list['content'] as List).length, 2);
  });

  group('demo summary', () {
    final demo = DemoSummaryRepository.custom(delay: Duration.zero);

    test('is built from the transcript and is deterministic', () {
      final t = meetingTranscript();
      final a = demo.build(t);
      final b = demo.build(t);
      expect(a.sections, b.sections);
      final kinds = a.sections.map((s) => s.kind).toList();
      expect(kinds, [
        SummarySectionKind.overview,
        SummarySectionKind.keyPoints,
        SummarySectionKind.speakers,
        SummarySectionKind.nextSteps,
      ]);
      final text = a.sections
          .expand((s) => [s.paragraph ?? '', ...s.bullets])
          .join(' ');
      // Every sentence it shows was said in the transcript.
      expect(text, contains('byudjet loyihasini'));
      expect(a.sections[2].bullets.first, startsWith('Maʼruzachi 1: '));
      expect(
        a.sections[3].bullets,
        contains(contains('smetasini tayyorlashi kerak')),
      );
    });

    test('keeps the chosen template on the summary', () async {
      final s = await demo.generate(
        meetingTranscript(),
        template: const SummaryTemplate(id: 'tp', name: 'Taʼlim'),
      );
      expect(s.templateId, 'tp');
      expect(s.templateName, 'Taʼlim');
    });
  });

  group('summary API', () {
    const path = '/api/v1/transcript/t1/summary';
    // Exactly what the backend's NoRoute writes (`api/router.go`).
    final noRoute = (
      404,
      {
        'status': 'NOT_FOUND',
        'description': 'topilmadi',
        'data': {'error': "bunday endpoint yo'q"},
      },
    );
    // A handler's own 404 (`h.fail(storage.ErrNotFound)`).
    final notFound = (
      404,
      {
        'status': 'NOT_FOUND',
        'description': 'topilmadi',
        'data': {'error': 'topilmadi'},
      },
    );
    // `models.TranscriptSummary` as the backend writes it.
    Map<String, Object?> row(String status, {Object? body, String err = ''}) =>
        {
          'id': 's1',
          'transcript_id': 't1',
          'template_id': '7d0c2b1e-0000-4000-8000-000000000001',
          'title': 'Asosiy xulosa',
          'status': status,
          'body': body,
          'error': err,
          'revision': 3,
          'updated_at': '2026-10-29T10:00:00Z',
        };
    const doc = {
      'type': 'doc',
      'content': [
        {
          'type': 'heading',
          'attrs': {'level': 2},
          'content': [
            {'type': 'text', 'text': 'Mazmuni'},
          ],
        },
        {
          'type': 'paragraph',
          'content': [
            {'type': 'text', 'text': 'Byudjet muhokama qilindi.'},
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
                    {'type': 'text', 'text': 'Smeta tayyorlansin'},
                  ],
                },
              ],
            },
          ],
        },
      ],
    };

    T right<T>(Either<Failure, T> e) =>
        e.getOrElse(() => throw StateError('$e'));

    test('no summary yet is 200 with null, and the API is live', () async {
      final f = facade({
        'GET $path': (200, ok({'summary': null})),
      });
      final load = right(await f.load('t1'));
      expect(load.summary, isNull);
      expect(load.sample, isFalse);
    });

    test('a DONE summary is parsed into blocks', () async {
      final f = facade({
        'GET $path': (200, ok({'summary': row('DONE', body: doc)})),
      });
      final s = right(await f.load('t1')).summary!;
      expect(s.id, 's1');
      expect(s.progress, SummaryProgress.done);
      expect(s.templateName, 'Asosiy xulosa');
      expect(s.revision, 3);
      expect(s.sample, isFalse);
      expect(s.blocks.map((b) => b.kind), [
        NoteBlockKind.heading,
        NoteBlockKind.paragraph,
        NoteBlockKind.listItem,
      ]);
      expect(s.blocks.last.text, 'Smeta tayyorlansin');
      expect(
        summaryBlocksPlainText('Asosiy xulosa', s.blocks),
        'Asosiy xulosa\n\nMazmuni\nByudjet muhokama qilindi.\n'
        '• Smeta tayyorlansin',
      );
    });

    test('PENDING with a null body and FAILED with its sentence', () async {
      var f = facade({
        'GET $path': (200, ok({'summary': row('PENDING')})),
      });
      var s = right(await f.load('t1')).summary!;
      expect(s.progress, SummaryProgress.pending);
      expect(s.body, isNull);
      expect(s.blocks, isEmpty);
      f = facade({
        'GET $path': (
          200,
          ok({'summary': row('FAILED', err: 'Model hozir javob bermadi.')}),
        ),
      });
      s = right(await f.load('t1')).summary!;
      expect(s.progress, SummaryProgress.failed);
      expect(s.error, 'Model hozir javob bermadi.');
      f = facade({
        'GET $path': (200, ok({'summary': row('LATER')})),
      });
      expect(
        right(await f.load('t1')).summary!.progress,
        SummaryProgress.unknown,
      );
    });

    test('the NoRoute 404 means no API here: demo from then on', () async {
      final f = facade({'GET $path': noRoute, 'POST $path': noRoute});
      final load = right(await f.load('t1'));
      expect(load.sample, isTrue);
      expect(load.summary, isNull);
      final s = right(await f.generate(meetingTranscript()));
      expect(s.sample, isTrue);
      expect(s.progress, SummaryProgress.done);
      expect(s.sections, isNotEmpty);
      // Generation did not even ask the server: the load already knew.
      expect(adapter.sent.map((r) => r.options.method), ['GET']);
      expect(await f.delete('t1'), isA<Either<Failure, Object>>());
      expect(adapter.sent.length, 1);
    });

    test('a non-envelope 404 (proxy page) is also a missing route', () async {
      final f = facade({'GET $path': (404, 'not found')});
      expect(right(await f.load('t1')).sample, isTrue);
    });

    test("a handler's own 404 is a failure, not the demo", () async {
      final f = facade({'GET $path': notFound});
      final result = await f.load('t1');
      expect(
        result.fold((l) => l, (_) => null),
        const Failure.server(statusCode: 404, message: 'topilmadi'),
      );
    });

    test('generate posts the template id, default is "basic"', () async {
      final f = facade({
        'GET $path': (200, ok({'summary': null})),
        'POST $path': (202, ok({'summary': row('PENDING')})),
      });
      await f.load('t1');
      final s = right(await f.generate(meetingTranscript()));
      expect(s.progress, SummaryProgress.pending);
      await f.generate(
        meetingTranscript(),
        template: const SummaryTemplate(id: 'uuid-1', name: 'Taʼlim'),
      );
      final posts = adapter.sent.where((r) => r.options.method == 'POST');
      expect(posts.map((r) => r.body), [
        {'template_id': 'basic'},
        {'template_id': 'uuid-1'},
      ]);
      expect(posts.first.options.uri.path, path);
    });

    test('a POST NoRoute on a server that seemed to have it: demo', () async {
      final f = facade({
        'GET $path': (200, ok({'summary': null})),
        'POST $path': noRoute,
      });
      await f.load('t1');
      expect(right(await f.generate(meetingTranscript())).sample, isTrue);
    });

    test('a 409 from generate stays a failure', () async {
      final f = facade({
        'POST $path': (
          409,
          {
            'status': 'CONFLICT',
            'description': 'ziddiyat',
            'data': {'error': 'xulosa hozir yozilmoqda'},
          },
        ),
      });
      final result = await f.generate(meetingTranscript());
      expect(
        result.fold((l) => l, (_) => null),
        isA<ServerFailure>().having((e) => e.statusCode, 'status', 409),
      );
    });

    test('refresh and delete hit the same path', () async {
      final f = facade({
        'GET $path': (200, ok({'summary': row('DONE', body: doc)})),
        'DELETE $path': (200, ok({'summary': null})),
      });
      expect(right(await f.refresh('t1'))!.progress, SummaryProgress.done);
      expect((await f.delete('t1')).isRight(), isTrue);
      expect(
        adapter.sent.map((r) => '${r.options.method} ${r.options.uri.path}'),
        ['GET $path', 'DELETE $path'],
      );
    });

    test('save as note sends the server body as it is', () async {
      final f = facade({
        'POST /api/v1/notes': (
          201,
          ok({
            'note': {'id': 'n2'},
          }),
        ),
      });
      await f.saveAsNote(
        transcriptId: 't1',
        title: 'X — xulosa',
        sections: const [],
        body: doc,
      );
      expect((adapter.sent.single.body! as Map)['body'], doc);
    });
  });
}
