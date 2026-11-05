import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/upload/domain/advanced_rules.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/advanced_options.dart';

SpeakerHint h(String label, int start, int end) =>
    SpeakerHint(label: label, startMs: start, endMs: end);

void main() {
  group('terms', () {
    test('one per line, trimmed, collapsed, no empties or repeats', () {
      expect(
        AdvancedRules.parseTerms(
          '  IT   Park \n\nMirziyoyev\nit park\n  \nToshkent  shahar',
        ),
        ['IT Park', 'Mirziyoyev', 'Toshkent shahar'],
      );
    });

    test('length counts characters, not bytes', () {
      // 120 Cyrillic letters are 240 bytes in UTF-8, still allowed.
      expect(AdvancedRules.termsProblem('ж' * 120), isNull);
      final long = AdvancedRules.termsProblem('ж' * 121);
      expect(long, isA<TermTooLong>());
      expect((long! as TermTooLong).start, 'ж' * 24);
    });

    test('at most 200 terms after dropping repeats', () {
      final ok = List.generate(200, (i) => 'a$i').join('\n');
      expect(AdvancedRules.termsProblem('$ok\nA0'), isNull);
      final over = AdvancedRules.termsProblem('$ok\nextra');
      expect(over, isA<TooManyTerms>());
      expect((over! as TooManyTerms).count, 201);
    });
  });

  group('speaker hints', () {
    test('names compared case-insensitively, first spelling kept', () {
      expect(
        AdvancedRules.people([
          h('Sarvar', 0, 2000),
          h(' sarvar ', 5000, 7000),
          h('Dilnoza', 9000, 11000),
        ]),
        ['Sarvar', 'Dilnoza'],
      );
    });

    test('refuses what the server refuses', () {
      expect(
        AdvancedRules.hintProblem(h('  ', 0, 2000), [], null),
        isA<HintNoName>(),
      );
      expect(
        AdvancedRules.hintProblem(h('a' * 61, 0, 2000), [], null),
        isA<HintNameTooLong>(),
      );
      expect(AdvancedRules.hintProblem(h('a' * 60, 0, 2000), [], null), isNull);
      expect(
        AdvancedRules.hintProblem(h('A', 5000, 5000), [], null),
        isA<HintEndBeforeStart>(),
      );
      expect(
        AdvancedRules.hintProblem(h('A', -1, 2000), [], null),
        isA<HintEndBeforeStart>(),
      );
      expect(
        AdvancedRules.hintProblem(h('A', 0, 999), [], null),
        isA<HintTooShort>(),
      );
      expect(AdvancedRules.hintProblem(h('A', 0, 1000), [], null), isNull);
      expect(
        AdvancedRules.hintProblem(h('A', 0, 600001), [], null),
        isA<HintTooLong>(),
      );
      expect(AdvancedRules.hintProblem(h('A', 0, 600000), [], null), isNull);
    });

    test('at most 100 hints per file', () {
      final many = [
        for (var i = 0; i < 100; i++) h('A', i * 2000, i * 2000 + 1500),
      ];
      expect(
        AdvancedRules.hintProblem(h('A', 300000, 302000), many, null),
        isA<TooManyHints>(),
      );
    });

    test('another person may not overlap; the same person may', () {
      final existing = [h('Sarvar', 10000, 20000)];
      final clash = AdvancedRules.hintProblem(
        h('Dilnoza', 15000, 25000),
        existing,
        null,
      );
      expect(clash, isA<HintOverlap>());
      expect((clash! as HintOverlap).name, 'Sarvar');
      expect(
        AdvancedRules.hintProblem(h('sarvar', 15000, 25000), existing, null),
        isNull,
      );
      // Touching ends do not overlap.
      expect(
        AdvancedRules.hintProblem(h('Dilnoza', 20000, 25000), existing, null),
        isNull,
      );
    });

    test('at most 10 people, and not more than the chosen count', () {
      final ten = [
        for (var i = 0; i < 10; i++) h('P$i', i * 2000, i * 2000 + 1500),
      ];
      expect(
        AdvancedRules.hintProblem(h('P11', 30000, 32000), ten, null),
        isA<TooManyPeople>(),
      );
      expect(
        AdvancedRules.hintProblem(h('p3', 30000, 32000), ten, null),
        isNull,
      );
      final two = [h('A', 0, 2000), h('B', 3000, 5000)];
      final more = AdvancedRules.hintProblem(h('C', 6000, 8000), two, 2);
      expect(more, isA<MorePeopleThanSpeakers>());
      expect((more! as MorePeopleThanSpeakers).people, 3);
      expect(AdvancedRules.hintProblem(h('C', 6000, 8000), two, 3), isNull);
    });

    test('adding merges one person’s overlaps and keeps the order', () {
      final existing = [h('Sarvar', 10000, 20000), h('Dilnoza', 30000, 35000)];
      final next = AdvancedRules.addHint(h('SARVAR', 15000, 25000), existing);
      expect(next, [h('Sarvar', 10000, 25000), h('Dilnoza', 30000, 35000)]);
      final earlier = AdvancedRules.addHint(h('Dilnoza', 1000, 3000), next);
      expect(earlier.first, h('Dilnoza', 1000, 3000));
    });

    test('saving re-checks people against a lowered speaker count', () {
      final hints = [
        [h('A', 0, 2000), h('B', 3000, 5000), h('C', 6000, 8000)],
      ];
      final problem = AdvancedRules.saveProblem(
        termsText: '',
        speakers: 2,
        hints: hints,
      );
      expect(problem, isA<PeopleExceedSpeakers>());
      expect(
        AdvancedRules.saveProblem(termsText: '', speakers: null, hints: hints),
        isNull,
      );
      expect(
        AdvancedRules.saveProblem(termsText: '', speakers: 3, hints: hints),
        isNull,
      );
    });
  });

  group('times', () {
    test('format', () {
      expect(AdvancedRules.formatTime(15000), '0:15');
      expect(AdvancedRules.formatTime(15400), '0:15.4');
      expect(AdvancedRules.formatTime(65000), '1:05');
      expect(AdvancedRules.formatTime(3723000), '1:02:03');
      expect(AdvancedRules.formatTime(-5), '0:00');
    });

    test('parse', () {
      expect(AdvancedRules.parseTime('0:15'), 15000);
      expect(AdvancedRules.parseTime(' 1:05 '), 65000);
      expect(AdvancedRules.parseTime('0:15.5'), 15500);
      expect(AdvancedRules.parseTime('1:02:03'), 3723000);
      expect(AdvancedRules.parseTime('75'), 75000);
      expect(AdvancedRules.parseTime('1:60'), isNull);
      expect(AdvancedRules.parseTime('1.5:10'), isNull);
      expect(AdvancedRules.parseTime('a:10'), isNull);
      expect(AdvancedRules.parseTime(''), isNull);
      expect(AdvancedRules.parseTime('1:2:3:4'), isNull);
    });

    test('a formatted time parses back', () {
      for (final ms in [0, 1500, 59900, 61000, 3599900, 3723400]) {
        expect(AdvancedRules.parseTime(AdvancedRules.formatTime(ms)), ms);
      }
    });
  });

  group('AdvancedOptions', () {
    test('a job gets the shared options and only its own file’s hints', () {
      const options = AdvancedOptions(
        workspaceId: 'w1',
        glossaryId: 'g1',
        termsText: 'IT Park\nit park\nMirziyoyev',
        hints: {
          '/a.mp3': [
            SpeakerHint(label: 'B', startMs: 5000, endMs: 7000),
            SpeakerHint(label: 'A', startMs: 0, endMs: 2000),
          ],
          '/b.mp3': [SpeakerHint(label: 'C', startMs: 0, endMs: 2000)],
        },
      );
      expect(options.hintCount, 3);
      final a = options.jobOptionsFor('/a.mp3');
      expect(a.glossaryId, 'g1');
      expect(a.terms, ['IT Park', 'Mirziyoyev']);
      expect(a.speakerHints.map((x) => x.label), ['A', 'B']);
      expect(options.jobOptionsFor().speakerHints, isEmpty);
      expect(options.jobOptionsFor('/c.mp3').speakerHints, isEmpty);
    });

    test('job options compare by value, lists included', () {
      expect(
        const JobOptions(
          terms: ['a'],
          speakerHints: [SpeakerHint(label: 'A', startMs: 0, endMs: 1000)],
        ),
        JobOptions(terms: ['a'], speakerHints: [h('A', 0, 1000)]),
      );
      expect(const JobOptions().isEmpty, isTrue);
      expect(const JobOptions(glossaryId: '').isEmpty, isTrue);
      expect(const JobOptions(terms: ['a']).isEmpty, isFalse);
    });
  });
}
