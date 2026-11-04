import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/timecode.dart';

void main() {
  // The web runs the same cases (tr-frontend/src/lib/timecode.fixtures.json);
  // copy that file here when the rule changes, do not edit it by hand.
  group('shared with the web', () {
    final cases = jsonDecode(
      File('test/fixtures/timecode_cases.json').readAsStringSync(),
    ) as List<dynamic>;
    for (final c in cases.cast<Map<String, dynamic>>()) {
      test(c['in'] as String, () {
        final links = [
          for (final p in splitTimecodes(c['in'] as String))
            if (p is AnswerTimecode) [p.label, p.at.inMilliseconds],
        ];
        expect(links, c['links']);
      });
    }
  });

  test('splits [mm:ss] and [h:mm:ss] into chips, keeps the rest', () {
    final parts = splitTimecodes('Boshida [01:23] va keyin [1:02:03].');
    expect(parts, hasLength(5));
    expect((parts[0] as AnswerPlain).text, 'Boshida ');
    final a = parts[1] as AnswerTimecode;
    expect(a.label, '01:23');
    expect(a.at, const Duration(minutes: 1, seconds: 23));
    final b = parts[3] as AnswerTimecode;
    expect(b.at, const Duration(hours: 1, minutes: 2, seconds: 3));
    expect((parts[4] as AnswerPlain).text, '.');
  });

  test('impossible seconds and plain text stay text', () {
    final parts = splitTimecodes('[12:99] emas, [ab:cd] ham emas');
    expect(parts, hasLength(1));
    expect(parts.single, isA<AnswerPlain>());
  });

  test('a partial answer cut inside a timecode keeps the tail as text', () {
    for (final tail in [
      '[',
      '[1',
      '[12',
      '[12:',
      '[12:3',
      '[12:34',
      '[1:02:',
    ]) {
      final parts = splitTimecodes('Avval [00:05] keyin $tail');
      expect(parts, hasLength(3), reason: tail);
      expect((parts[1] as AnswerTimecode).label, '00:05');
      expect((parts[2] as AnswerPlain).text, ' keyin $tail');
    }
    expect(splitTimecodes('[12:'), [isA<AnswerPlain>()]);
  });
}
