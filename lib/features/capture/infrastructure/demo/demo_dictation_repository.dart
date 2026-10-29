// DEMO SOURCE — replaced by the STT service's streaming endpoint once
// `stt-llm-pipeline` has one (live Uzbek dictation needs it; nothing like
// it exists today). It opens no microphone and makes no request: it plays
// back clearly-sample sentences word by word, so the screen's real
// behaviour (muted partial text that settles into final text) can be
// seen. The page shows the demo banner the whole time.

import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/dictation_event.dart';

@lazySingleton
class DemoDictationRepository {
  DemoDictationRepository() : _wordGap = const Duration(milliseconds: 260);

  /// For tests: no waiting between words.
  DemoDictationRepository.withGap(this._wordGap);

  final Duration _wordGap;

  Stream<DictationEvent> listen(List<String> samples) async* {
    // Round and round until the person stops.
    for (var round = 0; ; round++) {
      for (final sentence in samples) {
        final words = sentence.split(' ');
        for (var i = 1; i <= words.length; i++) {
          await Future<void>.delayed(_wordGap);
          if (i < words.length) {
            yield DictationEvent.partial(words.take(i).join(' '));
          }
        }
        yield DictationEvent.finalText(sentence);
        await Future<void>.delayed(_wordGap * 3);
      }
      if (samples.isEmpty) return;
    }
  }
}
