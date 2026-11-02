import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/transcript/domain/edit_rules.dart';

void main() {
  test('a title is limited in characters, like the server', () {
    expect(EditRules.titleTooLong('я' * 200), isFalse);
    expect(EditRules.titleTooLong('я' * 201), isTrue);
    expect(EditRules.titleTooLong('a' * 201), isTrue);
  });

  test('a speaker label stays limited in bytes', () {
    expect(EditRules.speakerLabelTooLong('я' * 40), isFalse);
    expect(EditRules.speakerLabelTooLong('я' * 41), isTrue);
  });
}
