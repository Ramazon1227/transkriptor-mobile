import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/chat_hints.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/chat_hint_text.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/models/transcript_model.dart';

HintFacts _facts(Map<String, dynamic> m) => HintFacts(
  meeting: m['meeting'] as bool,
  attendees: m['attendees'] as int,
  speakers: m['speakers'] as int,
  duration: Duration(milliseconds: m['durationMs'] as int),
);

void main() {
  // The web runs the same file (tr-frontend/src/lib/chat-hints.fixtures.json);
  // copy it here when the rule changes, do not edit it by hand.
  final shared = jsonDecode(
    File('test/fixtures/chat_hints_cases.json').readAsStringSync(),
  ) as Map<String, dynamic>;

  group('shared with the web', () {
    for (final c in (shared['cases'] as List).cast<Map<String, dynamic>>()) {
      test(c['name'] as String, () {
        final h = chatHints(_facts(c['in'] as Map<String, dynamic>));
        expect([for (final q in h.questions) q.name], c['questions']);
        expect(h.tabs, c['tabs']);
      });
    }

    for (final c in (shared['facts'] as List).cast<Map<String, dynamic>>()) {
      test('facts: ${c['name']}', () {
        final t = TranscriptModel.fromJson(
          c['transcript'] as Map<String, dynamic>,
        ).toEntity();
        final got = HintFacts.of(t);
        final want = _facts(c['in'] as Map<String, dynamic>);
        expect(
          [got.meeting, got.attendees, got.speakers, got.duration],
          [want.meeting, want.attendees, want.speakers, want.duration],
        );
      });
    }

    test('texts are the web texts', () {
      final l10n = lookupAppLocalizations(const Locale('uz'));
      final texts = (shared['texts'] as Map<String, dynamic>)
          .cast<String, String>();
      expect(texts.keys.toSet(), {for (final h in ChatHint.values) h.name});
      for (final h in ChatHint.values) {
        expect(h.text(l10n), texts[h.name], reason: h.name);
      }
    });
  });
}
