import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('uz'));

  test('a too-big note says how to fix it (N-11)', () {
    expect(
      const Failure.noteTooLarge().message(l10n),
      'Qayd juda katta (chegara — 2 MB). Matnni bir nechta qaydga boʻlib '
      'saqlang.',
    );
  });

  test('any other 413 is still about a file', () {
    expect(
      const Failure.server(statusCode: 413).message(l10n),
      'Fayl juda katta.',
    );
  });
}
