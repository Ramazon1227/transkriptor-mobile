import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/auth/domain/name_rules.dart';

void main() {
  test('whitespace collapses like models.CleanName', () {
    expect(NameRules.clean('  Ali \t  Valiyev \n'), 'Ali Valiyev');
    expect(NameRules.clean('   '), '');
  });

  test('empty and over 120 bytes are refused', () {
    expect(NameRules.validate(''), NameError.empty);
    expect(NameRules.validate('a' * 120), isNull);
    expect(NameRules.validate('a' * 121), NameError.tooLong);
    // Bytes, not characters: Cyrillic is two bytes, oʻ's U+02BB too.
    expect(NameRules.validate('Ш' * 60), isNull);
    expect(NameRules.validate('Ш' * 61), NameError.tooLong);
    expect(NameRules.validate('Gʻulom'), isNull);
  });
}
