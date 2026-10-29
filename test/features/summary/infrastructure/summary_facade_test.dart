import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/demo/demo_summary_repository.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/facades/summary_facade.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/note_doc.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/repositories/note_repository.dart';
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
}
