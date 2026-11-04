import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/rich_text.dart';

void main() {
  // The web runs the same cases (tr-frontend/src/lib/rich-text.fixtures.json);
  // copy that file here when the rule changes, do not edit it by hand.
  group('shared with the web', () {
    final cases = jsonDecode(
      File('test/fixtures/rich_text_cases.json').readAsStringSync(),
    ) as List<dynamic>;
    for (final c in cases.cast<Map<String, dynamic>>()) {
      test(c['name'] as String, () {
        expect(richPlain(c['input'] as String), c['plain']);
      });
    }
  });

  test('nests lists and keeps a non-1 start', () {
    final blocks = parseRich('3. a\n   - b\n4. c');
    final list = blocks.single as RichList;
    expect(list.ordered, isTrue);
    expect(list.start, 3);
    expect(list.items.map((i) => i.runs.single.text), ['a', 'c']);
    final sub = list.items.first.sub!;
    expect(sub.ordered, isFalse);
    expect(sub.items.single.runs.single.text, 'b');
    expect(list.items.last.sub, isNull);
  });

  test('bold runs', () {
    final runs = richRuns('Bu **muhim** gap');
    expect(runs.map((r) => (r.text, r.bold)), [
      ('Bu ', false),
      ('muhim', true),
      (' gap', false),
    ]);
  });
}
