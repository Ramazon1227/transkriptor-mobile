import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/sources/screen_audio_source.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const methods = MethodChannel(captureMethodChannel);
  const events = EventChannel(captureEventChannel);
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final calls = <MethodCall>[];
  late Object? Function(MethodCall) answer;

  setUp(() {
    calls.clear();
    answer = (_) => null;
    messenger.setMockMethodCallHandler(methods, (call) async {
      calls.add(call);
      return answer(call);
    });
  });

  tearDown(() {
    messenger
      ..setMockMethodCallHandler(methods, null)
      ..setMockStreamHandler(events, null);
  });

  test('no channel (iOS) is unsupported, not a crash', () async {
    messenger.setMockMethodCallHandler(methods, null);
    expect(await ScreenAudioSource().isSupported(), isFalse);
  });

  test('isSupported asks Android', () async {
    answer = (_) => true;
    expect(await ScreenAudioSource().isSupported(), isTrue);
  });

  test('start sends the path and the microphone flag', () async {
    await ScreenAudioSource().start(path: '/s.aac', withMic: true);
    expect(calls.single.method, 'screen.start');
    expect(calls.single.arguments, {'path': '/s.aac', 'withMic': true});
  });

  test('a refused consent arrives as its code', () async {
    answer = (_) =>
        throw PlatformException(code: CaptureErrorCodes.consentDenied);
    await expectLater(
      ScreenAudioSource().start(path: '/s.aac', withMic: false),
      throwsA(
        isA<PlatformException>().having(
          (e) => e.code,
          'code',
          CaptureErrorCodes.consentDenied,
        ),
      ),
    );
  });

  test('stop returns the file and its length', () async {
    answer = (_) => {'path': '/s.m4a', 'durationMs': 3000};
    final r = await ScreenAudioSource().stop();
    expect(r.path, '/s.m4a');
    expect(r.durationMs, 3000);
  });

  test('stop without a file is a storage error', () async {
    answer = (_) => null;
    await expectLater(
      ScreenAudioSource().stop(),
      throwsA(isA<PlatformException>()),
    );
  });

  test('events arrive as maps', () async {
    messenger.setMockStreamHandler(
      events,
      MockStreamHandler.inline(
        onListen: (_, sink) {
          sink
            ..success({'event': 'level', 'level': 0.5, 'elapsedMs': 100})
            ..success('noise')
            ..success({'event': 'silent'})
            ..endOfStream();
        },
      ),
    );
    final got = await ScreenAudioSource().events().toList();
    expect(got, [
      {'event': 'level', 'level': 0.5, 'elapsedMs': 100},
      {'event': 'silent'},
    ]);
  });
}
