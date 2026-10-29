import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/store/adts_scanner.dart';

import '../../../helpers/adts.dart';

void main() {
  group('AdtsScanner', () {
    test('counts whole frames and their length in time', () {
      final scanner = AdtsScanner()..add(adtsFrames(250));
      final info = scanner.result;
      expect(info.frames, 250);
      expect(info.sampleRate, 16000);
      expect(info.validBytes, 250 * 27);
      // 250 × 1024 samples at 16 kHz.
      expect(info.duration, const Duration(milliseconds: 16000));
    });

    test('frames split across chunks are still counted', () {
      final bytes = adtsFrames(10);
      final scanner = AdtsScanner();
      for (var i = 0; i < bytes.length; i += 5) {
        scanner.add(
          bytes.sublist(i, i + 5 > bytes.length ? bytes.length : i + 5),
        );
      }
      expect(scanner.result.frames, 10);
    });

    test('a file cut off mid-frame counts only whole frames', () {
      final bytes = adtsFrames(5);
      final scanner = AdtsScanner()..add(bytes.sublist(0, bytes.length - 3));
      expect(scanner.result.frames, 4);
      expect(scanner.result.validBytes, 4 * 27);
    });

    test('garbage ends the scan', () {
      final scanner = AdtsScanner()
        ..add([...adtsFrames(3), 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06])
        ..add(adtsFrames(3));
      expect(scanner.result.frames, 3);
    });

    test('nothing is no frames and no length', () {
      final info = (AdtsScanner()..add(const [])).result;
      expect(info.frames, 0);
      expect(info.duration, Duration.zero);
    });
  });
}
