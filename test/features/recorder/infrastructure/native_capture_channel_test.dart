import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel(captureMethodChannel);
  final calls = <MethodCall>[];
  late Object? Function(MethodCall) answer;

  setUp(() {
    calls.clear();
    answer = (_) => null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return answer(call);
        });
  });

  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null),
  );

  test('starts and stops the microphone service', () async {
    final native = NativeCaptureChannel();
    await native.startMicService();
    await native.stopMicService();
    expect(calls.map((c) => c.method), ['mic.startService', 'mic.stopService']);
  });

  test('notification permission answer', () async {
    answer = (_) => true;
    expect(await NativeCaptureChannel().requestNotifications(), isTrue);
    answer = (_) => null;
    expect(await NativeCaptureChannel().requestNotifications(), isFalse);
  });

  test('finalize sends both paths and reads the length', () async {
    answer = (_) => 1500;
    final d = await NativeCaptureChannel().finalize(
      src: '/a.aac',
      dst: '/a.m4a',
    );
    expect(d, const Duration(milliseconds: 1500));
    expect(calls.single.method, 'file.finalize');
    expect(calls.single.arguments, {'src': '/a.aac', 'dst': '/a.m4a'});
  });

  test('a native finalize error reaches the caller', () async {
    answer = (_) => throw PlatformException(code: CaptureErrorCodes.storage);
    await expectLater(
      NativeCaptureChannel().finalize(src: '/a.aac', dst: '/a.m4a'),
      throwsA(isA<PlatformException>()),
    );
  });

  test('duration and active screen path', () async {
    answer = (call) => switch (call.method) {
      'file.durationMs' => 2000,
      'screen.status' => {'path': '/s.aac', 'elapsedMs': 5, 'withMic': false},
      _ => null,
    };
    final native = NativeCaptureChannel();
    expect(await native.durationOf('/x.m4a'), const Duration(seconds: 2));
    expect(await native.activeScreenPath(), '/s.aac');
    answer = (_) => null;
    expect(await native.durationOf('/x.m4a'), isNull);
    expect(await native.activeScreenPath(), isNull);
  });
}
