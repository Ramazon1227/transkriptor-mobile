import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/utils/idempotency_key.dart';

void main() {
  test('timecode keeps hours and pads', () {
    expect(Formatters.timecode(Duration.zero), '00:00:00');
    expect(
      Formatters.timecode(const Duration(hours: 2, minutes: 14, seconds: 51)),
      '02:14:51',
    );
    expect(Formatters.timecode(const Duration(seconds: -3)), '00:00:00');
  });

  test('minutes: what is left rounds down, what is needed rounds up', () {
    expect(Formatters.minutesLeft(12899), 214);
    expect(Formatters.minutesLeft(-5), 0);
    expect(
      Formatters.minutesNeeded(const Duration(minutes: 12, seconds: 47)),
      13,
    );
    expect(Formatters.minutesNeeded(const Duration(minutes: 2)), 2);
    expect(Formatters.minutesNeeded(Duration.zero), 0);
  });

  test('megabytes use a comma', () {
    expect(Formatters.megabytes(3250586), '3,1');
  });

  test('date is dd.MM.yyyy', () {
    expect(Formatters.date(DateTime(2026, 10, 9)), '09.10.2026');
  });

  test('envelopeData returns data or throws FormatException', () {
    expect(
      envelopeData({
        'data': {'a': 1},
      }),
      {'a': 1},
    );
    expect(() => envelopeData({'data': null}), throwsFormatException);
    expect(() => envelopeData(const ['x']), throwsFormatException);
  });

  test('idempotency keys are 32 hex chars and differ', () {
    final a = newIdempotencyKey();
    expect(a, matches(RegExp(r'^[0-9a-f]{32}$')));
    expect(newIdempotencyKey(), isNot(a));
  });
}
