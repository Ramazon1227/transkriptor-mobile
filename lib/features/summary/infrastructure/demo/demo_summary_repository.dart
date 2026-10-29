// DEMO SOURCE — used only on a server without the summary API.
//
// The real API is `/transcript/:id/summary` (backend `feat/meeting-ai`,
// `SummaryRepository`). `SummaryFacade` falls back to this sample when
// that route answers the backend's NoRoute 404, and the tab shows
// «Namuna». Like the web's old `demoSummarySource` it builds a sample in
// memory, after a fake delay. It is put together deterministically from
// the transcript's own sentences, so it reads as being about this
// recording — but no model wrote it. Delete it once every server the app
// talks to has the API.

import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/utils/sentences.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

@lazySingleton
class DemoSummaryRepository {
  DemoSummaryRepository() : delay = const Duration(milliseconds: 1400);

  DemoSummaryRepository.custom({required this.delay});

  /// How long the fake "model" takes.
  final Duration delay;

  static const int _keyPoints = 5;
  static const int _nextSteps = 3;
  static const int _speakerQuoteMax = 140;

  /// Words that usually mark a task or a plan, in the three languages a
  /// transcript mixes.
  static final RegExp _actionWords = RegExp(
    '(kerak|lozim|zarur|reja|rejala|topshir|muddat|qilamiz|qilinadi|'
    'boʻladi|need|will|should|plan|deadline|нужно|надо|будем|должн|срок)',
    caseSensitive: false,
    unicode: true,
  );

  Future<Summary> generate(
    Transcript transcript, {
    SummaryTemplate? template,
  }) async {
    await Future<void>.delayed(delay);
    return build(transcript, template: template);
  }

  /// The sample itself, without the delay. Same transcript, same summary.
  Summary build(Transcript transcript, {SummaryTemplate? template}) {
    final perSegment = [
      for (final s in transcript.segments)
        (s, splitSentences(s.text).where(_meaningful).toList()),
    ].where((e) => e.$2.isNotEmpty).toList();
    final all = [for (final e in perSegment) ...e.$2];

    final sections = <SummarySection>[];

    final opening = all.take(2).toList();
    final overview = opening.join(' ');

    // Sentences that sound like a task or a plan become next steps; they
    // are kept out of the key points so nothing is said twice.
    var steps = all
        .skip(opening.length)
        .where(_actionWords.hasMatch)
        .take(_nextSteps)
        .toList();
    if (steps.isEmpty && all.length > opening.length) steps = [all.last];

    if (overview.isNotEmpty) {
      sections.add(
        SummarySection(kind: SummarySectionKind.overview, paragraph: overview),
      );
    }

    // Evenly spread over the recording: one per stretch, its first
    // sentence that is not a next step — the opening of each part
    // usually names its subject.
    final points = <String>[];
    if (perSegment.isNotEmpty) {
      final step = perSegment.length / _keyPoints;
      for (var i = 0; i < _keyPoints; i++) {
        final index = (i * step).floor().clamp(0, perSegment.length - 1);
        final sentence = perSegment[index].$2.firstWhere(
          (x) => !steps.contains(x),
          orElse: () => '',
        );
        if (sentence.isNotEmpty &&
            !points.contains(sentence) &&
            !opening.contains(sentence)) {
          points.add(sentence);
        }
      }
    }
    if (points.isNotEmpty) {
      sections.add(
        SummarySection(kind: SummarySectionKind.keyPoints, bullets: points),
      );
    }

    final speakers = <String>[];
    final ordered = [...transcript.speakers]
      ..sort((a, b) => a.ordinal.compareTo(b.ordinal));
    for (final speaker in ordered) {
      final first = perSegment
          .where((e) => e.$1.speakerId == speaker.id)
          .map((e) => e.$2.first)
          .firstOrNull;
      if (first != null) speakers.add('${speaker.label}: ${_clip(first)}');
    }
    if (speakers.isNotEmpty) {
      sections.add(
        SummarySection(kind: SummarySectionKind.speakers, bullets: speakers),
      );
    }

    if (steps.isNotEmpty) {
      sections.add(
        SummarySection(kind: SummarySectionKind.nextSteps, bullets: steps),
      );
    }

    return Summary(
      templateId: template?.id,
      templateName: template?.name,
      sections: sections,
      createdAt: DateTime.now(),
    );
  }

  static bool _meaningful(String sentence) =>
      sentenceWords(sentence).length >= 3;

  static String _clip(String s) => s.length <= _speakerQuoteMax
      ? s
      : '${s.substring(0, _speakerQuoteMax).trimRight()}…';
}
