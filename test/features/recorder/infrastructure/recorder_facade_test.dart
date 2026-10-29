import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart' show Left;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record/record.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/facades/recorder_facade.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/store/recordings_store.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

import '../../../helpers/adts.dart';

class _MockRecorder extends Mock implements AudioRecorder;

class _MockNative extends Mock implements NativeCaptureChannel;

void main() {
  late Directory dir;
  late _MockRecorder recorder;
  late _MockNative native;
  late RecordingsStore store;
  late RecorderFacade facade;
  late StreamController<Uint8List> chunks;

  setUpAll(() => registerFallbackValue(const RecordConfig()));

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('recorder_facade_test');
    recorder = _MockRecorder();
    native = _MockNative();
    store = RecordingsStore.at(dir, native);
    facade = RecorderFacade(recorder, store, native);
    chunks = StreamController<Uint8List>();

    when(() => recorder.hasPermission()).thenAnswer((_) async => true);
    when(() => recorder.startStream(any()))
        .thenAnswer((_) async => chunks.stream);
    when(() => recorder.stop()).thenAnswer((_) async {
      await chunks.close();
      return null;
    });
    when(() => recorder.cancel()).thenAnswer((_) => chunks.close());
    when(() => native.requestNotifications()).thenAnswer((_) async => true);
    when(() => native.startMicService()).thenAnswer((_) async {});
    when(() => native.stopMicService()).thenAnswer((_) async {});
    when(() => native.activeScreenPath()).thenAnswer((_) async => null);
    when(() => native.durationOf(any())).thenAnswer((_) async => null);
    when(
      () => native.finalize(
        src: any(named: 'src'),
        dst: any(named: 'dst'),
      ),
    ).thenAnswer((invocation) async {
      final src = invocation.namedArguments[#src] as String;
      final dst = invocation.namedArguments[#dst] as String;
      File(dst).writeAsBytesSync(File(src).readAsBytesSync());
      return const Duration(seconds: 1);
    });
  });

  tearDown(() => dir.delete(recursive: true));

  List<File> files() => dir.listSync().whereType<File>().toList();

  test('a refused microphone starts nothing', () async {
    when(() => recorder.hasPermission()).thenAnswer((_) async => false);
    expect(
      await facade.start(),
      const Left<Failure, Object>(Failure.permissionDenied()),
    );
    verifyNever(() => native.startMicService());
    verifyNever(() => recorder.startStream(any()));
  });

  test('records AAC with the voice effects, behind the keep-alive', () async {
    expect((await facade.start()).isRight(), isTrue);
    final config =
        verify(() => recorder.startStream(captureAny())).captured.single
            as RecordConfig;
    expect(config.encoder, AudioEncoder.aacLc);
    expect(config.echoCancel, isTrue);
    expect(config.noiseSuppress, isTrue);
    expect(config.autoGain, isTrue);
    verify(() => native.startMicService()).called(1);
  });

  test('chunks reach the file as they arrive', () async {
    await facade.start();
    chunks.add(Uint8List.fromList(adtsFrames(2)));
    await Future<void>.delayed(Duration.zero);
    final file = files().single;
    expect(file.path, endsWith('.aac'));
    // Already on disk, before stop: this is what survives a kill.
    expect(file.lengthSync(), 54);
  });

  test('stop turns the .aac into an .m4a and ends the keep-alive', () async {
    await facade.start();
    chunks.add(Uint8List.fromList(adtsFrames(3)));
    await Future<void>.delayed(Duration.zero);

    final result = await facade.stop(duration: const Duration(seconds: 7));

    final recording = result.getOrElse(() => throw StateError('no recording'));
    expect(recording.path, endsWith('.m4a'));
    expect(recording.sizeBytes, 81);
    expect(recording.duration, const Duration(seconds: 7));
    expect(files().map((f) => f.path), [recording.path]);
    verify(() => native.stopMicService()).called(1);
  });

  test('a failed remux keeps the .aac for recovery', () async {
    when(
      () => native.finalize(
        src: any(named: 'src'),
        dst: any(named: 'dst'),
      ),
    ).thenThrow(Exception('muxer'));
    await facade.start();
    chunks.add(Uint8List.fromList(adtsFrames(3)));
    await Future<void>.delayed(Duration.zero);

    expect(
      await facade.stop(duration: Duration.zero),
      const Left<Failure, Object>(Failure.storage()),
    );
    final left = (await facade.recoverable()).getOrElse(() => []);
    expect(left.single.state, RecordingCompletion.interrupted);
  });

  test('discard deletes the file and ends the keep-alive', () async {
    await facade.start();
    chunks.add(Uint8List.fromList(adtsFrames(1)));
    await Future<void>.delayed(Duration.zero);
    await facade.discard();
    expect(files(), isEmpty);
    verify(() => native.stopMicService()).called(1);
  });

  test('the recording in progress is not offered for recovery', () async {
    await facade.start();
    chunks.add(Uint8List.fromList(adtsFrames(1)));
    await Future<void>.delayed(Duration.zero);
    expect((await facade.recoverable()).getOrElse(() => [_dummy]), isEmpty);
  });

  test('a running native screen capture is not offered either', () async {
    File('${dir.path}/screen_1.aac').writeAsBytesSync(adtsFrames(2));
    when(() => native.activeScreenPath())
        .thenAnswer((_) async => '${dir.path}/screen_1.aac');
    expect((await facade.recoverable()).getOrElse(() => [_dummy]), isEmpty);
  });

  test('recovering an interrupted one remuxes it into a PendingFile', () async {
    File('${dir.path}/mic_5.aac').writeAsBytesSync(adtsFrames(4));
    final item = (await facade.recoverable()).getOrElse(() => []).single;

    final result = await facade.recover(item, title: 'Yozuv');

    final file = result.getOrElse(() => throw StateError('none'));
    expect(file.path, '${dir.path}/mic_5.m4a');
    expect(file.fileName, 'Yozuv.m4a');
    expect(file.source, UploadSource.recording);
    expect(file.duration, const Duration(seconds: 1));
    expect(File('${dir.path}/mic_5.aac').existsSync(), isFalse);
  });

  test('recovering a finished one hands it over as is', () async {
    File('${dir.path}/screen_5.m4a').writeAsBytesSync([1, 2, 3]);
    final item = (await facade.recoverable()).getOrElse(() => []).single;
    final file = (await facade.recover(
      item,
      title: 'Ekran',
    )).getOrElse(() => throw StateError('none'));
    expect(file.path, '${dir.path}/screen_5.m4a');
    expect(file.sizeBytes, 3);
    verifyNever(
      () => native.finalize(
        src: any(named: 'src'),
        dst: any(named: 'dst'),
      ),
    );
  });

  test('discarding a leftover deletes it', () async {
    File('${dir.path}/mic_5.m4a').writeAsBytesSync([1]);
    final item = (await facade.recoverable()).getOrElse(() => []).single;
    expect((await facade.discardRecoverable(item)).isRight(), isTrue);
    expect(files(), isEmpty);
  });
}

final _dummy = RecoverableRecording(
  path: '/x',
  kind: RecordingKind.microphone,
  state: RecordingCompletion.finished,
  createdAt: DateTime(2026),
  sizeBytes: 1,
);
