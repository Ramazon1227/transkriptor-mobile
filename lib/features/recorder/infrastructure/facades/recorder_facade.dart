import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:injectable/injectable.dart';
import 'package:record/record.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/utils/device_platform.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/domain/i_recorder_facade.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/store/recordings_store.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

/// AAC-LC, 16 kHz mono: what the STT service resamples to anyway, so
/// higher rates only make the upload bigger. Echo cancelling, noise
/// suppression and gain control are used where the phone has them.
///
/// Recorded as a stream of ADTS frames into an `.aac` file, not straight
/// into .m4a: an .m4a gets its index only when the muxer is stopped, so a
/// killed app would leave an unplayable file. The `.aac` becomes an .m4a
/// (which the backend accepts) on stop or on recovery.
///
/// iOS takes the other path: `record.start()` writes the .m4a itself
/// ([_iosConfig]). `record_ios` can stream AAC-LC as ADTS too, but the
/// remux to .m4a is the app's Android code (`file.finalize`), which iOS
/// does not have. The price: a recording cut off by a killed app is lost
/// on iOS (its .m4a has no index); finished, unsent ones are still kept.
const _config = RecordConfig(
  sampleRate: 16000,
  numChannels: 1,
  bitRate: 48000,
  autoGain: true,
  echoCancel: true,
  noiseSuppress: true,
);

/// iOS writes through `AVAudioRecorder`, which takes the AAC settings
/// as given; 32 kbit/s is well inside what its AAC-LC encoder accepts for
/// 16 kHz mono (48 kbit/s sits at the edge of that range). The session
/// (`playAndRecord`, speaker, Bluetooth) is the plugin's default.
final RecordConfig _iosConfig = _config.copyWith(bitRate: 32000);

/// The meter treats this as silence; speech sits roughly at -30..-10 dBFS.
const double _floorDb = -50;

@LazySingleton(as: IRecorderFacade)
class RecorderFacade implements IRecorderFacade {
  RecorderFacade(this._recorder, this._store, this._native, this._platform);

  final AudioRecorder _recorder;
  final RecordingsStore _store;

  /// Android only: the keep-alive service, the remux and the screen
  /// capture. iOS has no such channel, so this facade does not call it
  /// there (the store's duration lookup fails quietly: no length shown).
  final NativeCaptureChannel _native;
  final DevicePlatform _platform;

  bool get _ios => _platform.isIOS;

  String? _path;
  RandomAccessFile? _file;
  StreamSubscription<Uint8List>? _chunks;
  Completer<void>? _streamDone;

  @override
  Future<Either<Failure, Unit>> start() async {
    try {
      if (!await _recorder.hasPermission()) {
        return const Left(Failure.permissionDenied());
      }
    } on Object {
      return const Left(Failure.permissionDenied());
    }
    if (_path != null) return const Right(unit);
    if (_ios) return await _startIos();
    try {
      await _native.requestNotifications();
    } on Object {
      // Without it the notification is hidden; recording still works.
    }
    try {
      final path = await _store.newPath(RecordingKind.microphone);
      _path = path;
      _file = await File(path).open(mode: FileMode.writeOnly);
      try {
        await _native.startMicService();
      } on Object {
        // No keep-alive (not Android, or the system refused): it still
        // records while the app is in front.
      }
      final stream = await _recorder.startStream(_config);
      final done = Completer<void>();
      _streamDone = done;
      _chunks = stream.listen(
        // Written synchronously, frame by frame: whatever reached the file
        // survives the process being killed.
        (bytes) => _file?.writeFromSync(bytes),
        onError: (Object _) {},
        onDone: () {
          if (!done.isCompleted) done.complete();
        },
        cancelOnError: false,
      );
      return const Right(unit);
    } on Object {
      await _abandon(deleteFile: true);
      return const Left(Failure.storage());
    }
  }

  /// iOS: `record` writes the .m4a; the screen-locked recording is kept
  /// alive by the `audio` background mode (Info.plist), not a service.
  Future<Either<Failure, Unit>> _startIos() async {
    try {
      final path = await _store.newPartialPath(RecordingKind.microphone);
      _path = path;
      await _recorder.start(_iosConfig, path: path);
      return const Right(unit);
    } on Object {
      await _abandon(deleteFile: true);
      return const Left(Failure.storage());
    }
  }

  @override
  Future<Either<Failure, Unit>> pause() => _guard(_recorder.pause);

  @override
  Future<Either<Failure, Unit>> resume() => _guard(_recorder.resume);

  @override
  Future<Either<Failure, Recording>> stop({required Duration duration}) async {
    final path = _path;
    if (path == null) return const Left(Failure.storage());
    if (_ios) return await _stopIos(path, duration);
    try {
      await _recorder.stop();
    } on Object {
      // The file holds what arrived; try to keep it.
    }
    // The last chunks arrive just before the stream closes.
    await _streamDone?.future.timeout(
      const Duration(seconds: 2),
      onTimeout: () {},
    );
    await _abandon(deleteFile: false);
    try {
      final finished = await _store.finalize(path);
      final size = await File(finished.path).length();
      if (size <= 0) return const Left(Failure.storage());
      return Right(
        Recording(path: finished.path, sizeBytes: size, duration: duration),
      );
    } on Object {
      // The .aac stays and shows up in recoverable().
      return const Left(Failure.storage());
    }
  }

  Future<Either<Failure, Recording>> _stopIos(
    String path,
    Duration duration,
  ) async {
    try {
      // The index is written here; without it the .m4a is unplayable.
      await _recorder.stop();
    } on Object {
      await _abandon(deleteFile: true);
      return const Left(Failure.storage());
    }
    final String finished;
    try {
      // Renamed while still held, so recovery never sees a half state.
      finished = await _store.complete(path);
    } on Object {
      await _abandon(deleteFile: true);
      return const Left(Failure.storage());
    }
    await _abandon(deleteFile: false);
    try {
      final size = await File(finished).length();
      if (size <= 0) return const Left(Failure.storage());
      return Right(
        Recording(path: finished, sizeBytes: size, duration: duration),
      );
    } on Object {
      return const Left(Failure.storage());
    }
  }

  @override
  Future<void> discard() async {
    try {
      await _recorder.cancel();
    } on Object {
      // Nothing to keep and nothing to report.
    }
    await _abandon(deleteFile: true);
  }

  /// Ends the session's bookkeeping: subscription, file, keep-alive.
  Future<void> _abandon({required bool deleteFile}) async {
    final path = _path;
    _path = null;
    await _chunks?.cancel();
    _chunks = null;
    _streamDone = null;
    try {
      await _file?.close();
    } on Object {
      // Closing a broken file has nothing left to save.
    }
    _file = null;
    if (!_ios) {
      try {
        await _native.stopMicService();
      } on Object {
        // Not running.
      }
    }
    if (path == null) return;
    if (deleteFile) {
      await _store.delete(path);
    } else {
      _store.release(path);
    }
  }

  @override
  Stream<double> levels() => _recorder
      .onAmplitudeChanged(const Duration(milliseconds: 120))
      .map((a) => ((a.current - _floorDb) / -_floorDb).clamp(0.0, 1.0));

  @override
  Future<Either<Failure, List<RecoverableRecording>>> recoverable() async {
    String? screen;
    if (!_ios) {
      try {
        screen = await _native.activeScreenPath();
      } on Object {
        screen = null;
      }
    }
    try {
      return Right(await _store.list(exclude: [?_path, ?screen]));
    } on Object {
      return const Left(Failure.storage());
    }
  }

  @override
  Future<Either<Failure, Unit>> discardRecoverable(
    RecoverableRecording item,
  ) async {
    if (_store.isActive(item.path)) return const Left(Failure.storage());
    try {
      await _store.delete(item.path);
      return const Right(unit);
    } on Object {
      return const Left(Failure.storage());
    }
  }

  @override
  Future<Either<Failure, PendingFile>> recover(
    RecoverableRecording item, {
    required String title,
  }) async {
    if (_store.isActive(item.path)) return const Left(Failure.storage());
    try {
      var path = item.path;
      var duration = item.duration;
      if (item.state == RecordingCompletion.interrupted) {
        final finished = await _store.finalize(path);
        path = finished.path;
        duration = finished.duration;
      }
      final size = await File(path).length();
      if (size <= 0) return const Left(Failure.storage());
      return Right(
        PendingFile(
          path: path,
          fileName: '$title.m4a',
          sizeBytes: size,
          source: UploadSource.recording,
          duration: duration,
        ),
      );
    } on Object {
      return const Left(Failure.storage());
    }
  }

  Future<Either<Failure, Unit>> _guard(Future<void> Function() call) async {
    try {
      await call();
      return const Right(unit);
    } on Object {
      return const Left(Failure.unknown());
    }
  }
}
