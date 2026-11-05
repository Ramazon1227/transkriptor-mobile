import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/ai_notes.dart';

void main() {
  // The web runs the same cases (tr-frontend/src/lib/ai-notes.fixtures.json);
  // copy that file here when the rule changes, do not edit it by hand.
  group('shared with the web', () {
    final cases = jsonDecode(
      File('test/fixtures/ai_notes_cases.json').readAsStringSync(),
    ) as List<dynamic>;
    for (final c in cases.cast<Map<String, dynamic>>()) {
      test(c['name'] as String, () {
        final split = splitAiNotes(c['input'] as String);
        expect(split.body, c['body']);
        expect(split.notes, (c['notes'] as List<dynamic>).cast<String>());
      });
    }
  });
}
