import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/timecode.dart';

void main() {
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
