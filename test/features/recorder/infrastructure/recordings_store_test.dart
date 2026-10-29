import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/store/recordings_store.dart';

import '../../../helpers/adts.dart';

class _MockNative extends Mock implements NativeCaptureChannel;

void main() {
  late Directory dir;
  late _MockNative native;
  late RecordingsStore store;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('recordings_test');
    native = _MockNative();
    store = RecordingsStore.at(dir, native);
    when(() => native.durationOf(any()))
        .thenAnswer((_) async => const Duration(seconds: 42));
  });

  tearDown(() => dir.delete(recursive: true));

  File put(String name, List<int> bytes) =>
      File('${dir.path}/$name')..writeAsBytesSync(bytes);

  test('new paths are .aac, named by kind and time, and unique', () async {
    final at = DateTime.fromMillisecondsSinceEpoch(1000);
    final a = await store.newPath(RecordingKind.microphone, now: at);
    final b = await store.newPath(RecordingKind.microphone, now: at);
    final s = await store.newPath(RecordingKind.screen, now: at);
    expect(a, '${dir.path}/mic_1000.aac');
    expect(b, '${dir.path}/mic_1001.aac');
    expect(s, '${dir.path}/screen_1000.aac');
  });

  test('lists interrupted and finished recordings, newest first', () async {
    put('mic_1000.aac', adtsFrames(250));
    put('screen_3000.m4a', List.filled(100, 1));
    put('rec_2000.m4a', List.filled(50, 1)); // from older versions
    put('notes.txt', [1, 2, 3]);

    final items = await store.list();

    expect(items.map((i) => i.path), [
      '${dir.path}/screen_3000.m4a',
      '${dir.path}/rec_2000.m4a',
      '${dir.path}/mic_1000.aac',
    ]);
    expect(items[0].kind, RecordingKind.screen);
    expect(items[0].state, RecordingCompletion.finished);
    expect(items[0].duration, const Duration(seconds: 42));
    expect(items[1].kind, RecordingKind.microphone);
    expect(items[2].state, RecordingCompletion.interrupted);
    expect(items[2].duration, const Duration(seconds: 16));
    expect(items[2].sizeBytes, 250 * 27);
    expect(items[2].createdAt, DateTime.fromMillisecondsSinceEpoch(1000));
  });

  test('a file a live session writes is not offered', () async {
    final path = await store.newPath(RecordingKind.microphone);
    File(path).writeAsBytesSync(adtsFrames(3));
    put('screen_5.aac', adtsFrames(3));

    final items = await store.list(exclude: ['${dir.path}/screen_5.aac']);
    expect(items, isEmpty);

    store.release(path);
    expect((await store.list()).map((i) => i.path), contains(path));
  });

  test('empty files and .aac without a whole frame are deleted', () async {
    put('mic_1.aac', const []);
    put('mic_2.aac', adtsFrame().sublist(0, 10));
    put('mic_3.m4a', const []);

    expect(await store.list(), isEmpty);
    expect(dir.listSync(), isEmpty);
  });

  test('an .aac whose .m4a exists is a leftover and goes', () async {
    put('mic_7.aac', adtsFrames(3));
    put('mic_7.m4a', List.filled(10, 1));

    final items = await store.list();
    expect(items.single.path, '${dir.path}/mic_7.m4a');
    expect(File('${dir.path}/mic_7.aac').existsSync(), isFalse);
  });

  test('an unreadable duration is null, not an error', () async {
    when(() => native.durationOf(any())).thenThrow(Exception('no codec'));
    put('mic_1.m4a', List.filled(10, 1));
    expect((await store.list()).single.duration, isNull);
  });

  test('finalize remuxes to .m4a and deletes the .aac', () async {
    final aac = put('mic_9.aac', adtsFrames(3)).path;
    when(() => native.finalize(src: aac, dst: '${dir.path}/mic_9.m4a'))
        .thenAnswer((_) async {
          File('${dir.path}/mic_9.m4a').writeAsBytesSync([1, 2, 3]);
          return const Duration(milliseconds: 192);
        });

    final result = await store.finalize(aac);

    expect(result.path, '${dir.path}/mic_9.m4a');
    expect(result.duration, const Duration(milliseconds: 192));
    expect(File(aac).existsSync(), isFalse);
  });

  test('a failed finalize keeps the .aac for later', () async {
    final aac = put('mic_9.aac', adtsFrames(3)).path;
    when(
      () => native.finalize(
        src: any(named: 'src'),
        dst: any(named: 'dst'),
      ),
    ).thenThrow(Exception('muxer'));

    await expectLater(store.finalize(aac), throwsException);
    expect(File(aac).existsSync(), isTrue);
  });
}
