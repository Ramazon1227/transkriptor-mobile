import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/models/summary_model.dart';

void main() {
  Map<String, dynamic> json([Map<String, dynamic> extra = const {}]) => {
    'id': 's1',
    'status': 'DONE',
    'title': 'Asosiy xulosa',
    'body': {'type': 'doc'},
    ...extra,
  };

  // XU-15: ma'ruzachi nomlari o'zgargan. Mobilda matn belgisi yo'q, shuning
  // uchun matn ham o'zgargan bo'lsa ham nomlar belgisi qoladi (review).
  test('reads speakers_outdated, with or without a text change', () {
    expect(
      SummaryModel.fromJson(json({'speakers_outdated': true}))
          .toEntity()
          .speakersOutdated,
      isTrue,
    );
    expect(
      SummaryModel.fromJson(json({'speakers_outdated': true, 'outdated': true}))
          .toEntity()
          .speakersOutdated,
      isTrue,
    );
    expect(SummaryModel.fromJson(json()).toEntity().speakersOutdated, isFalse);
  });
}
