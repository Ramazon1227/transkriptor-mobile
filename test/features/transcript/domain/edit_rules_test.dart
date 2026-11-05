import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/transcript/domain/edit_rules.dart';

void main() {
  test('a title is limited in characters, like the server', () {
    expect(EditRules.titleTooLong('я' * 200), isFalse);
    expect(EditRules.titleTooLong('я' * 201), isTrue);
    expect(EditRules.titleTooLong('a' * 201), isTrue);
  });

  test('a speaker label is limited in characters, like the server', () {
    expect(EditRules.speakerLabelTooLong('я' * 80), isFalse);
    expect(EditRules.speakerLabelTooLong('я' * 81), isTrue);
    expect(EditRules.speakerLabelTooLong('oʻ' * 40), isFalse);
  });
}
