import 'dart:io';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:record/record.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/screen_capture_event.dart';
import 'package:transkriptor_uz/features/capture/domain/i_screen_capture_facade.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/sources/screen_audio_source.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/store/recordings_store.dart';

@LazySingleton(as: IScreenCaptureFacade)
class ScreenCaptureFacade implements IScreenCaptureFacade {
  ScreenCaptureFacade(
    this._source,
    this._permissions,
    this._native,
    this._store,
  );

  final ScreenAudioSource _source;

  /// Only for the microphone permission dialog, which playback capture
  /// needs too.
  final AudioRecorder _permissions;
  final NativeCaptureChannel _native;
  final RecordingsStore _store;

  /// The .aac this engine's session writes.
  String? _path;

  @override
  Future<bool> isSupported() async {
    try {
      return await _source.isSupported();
    } on Object {
      return false;
    }
  }

  @override
  Future<Either<Failure, Unit>> start({required bool withMic}) async {
    if (!await isSupported()) {
      return const Left(Failure.capture(CaptureError.unsupported));
    }
    if (_path != null) return const Left(Failure.capture(CaptureError.busy));
    try {
      if (!await _permissions.hasPermission()) {
        return const Left(Failure.permissionDenied());
      }
    } on Object {
      return const Left(Failure.permissionDenied());
    }
    try {
      await _native.requestNotifications();
    } on Object {
      // A hidden notification does not stop the capture.
    }
    final String path;
    try {
      path = await _store.newPath(RecordingKind.screen);
    } on Object {
      return const Left(Failure.storage());
    }
    try {
      await _source.start(path: path, withMic: withMic);
      _path = path;
      return const Right(unit);
    } on PlatformException catch (e) {
      await _store.delete(path);
      return Left(failureOf(e.code));
    } on Object {
      await _store.delete(path);
      return const Left(Failure.capture(CaptureError.captureFailed));
    }
  }

  @override
  Future<Either<Failure, Recording>> stop() async {
    try {
      final result = await _source.stop();
      return Right(await _recording(result));
    } on PlatformException catch (e) {
      return Left(failureOf(e.code));
    } on Object {
      return const Left(Failure.storage());
    } finally {
      _releasePath();
    }
  }

  @override
  Future<void> cancel() async {
    try {
      await _source.cancel();
    } on Object {
      // Not running: nothing to stop.
    }
    final path = _path;
    _path = null;
    if (path != null) await _store.delete(path);
  }

  @override
  Future<ScreenCaptureSession?> current() async {
    try {
      final status = await _source.status();
      if (status == null) return null;
      final ms = status['elapsedMs'];
      final path = status['path'];
      // Started by an earlier engine: hold it so recovery leaves it alone.
      if (path is String && path.isNotEmpty) _path ??= path;
      return ScreenCaptureSession(
        elapsed: Duration(milliseconds: ms is int ? ms : 0),
        withMic: status['withMic'] == true,
      );
    } on Object {
      return null;
    }
  }

  @override
  Stream<ScreenCaptureEvent> events() => _source.events().asyncExpand((
    e,
  ) async* {
    switch (e['event']) {
      case 'level':
        final level = e['level'];
        final ms = e['elapsedMs'];
        yield ScreenCaptureEvent.level(
          level: level is num ? level.toDouble().clamp(0.0, 1.0) : 0,
          elapsed: Duration(milliseconds: ms is int ? ms : 0),
        );
      case 'silent':
        yield const ScreenCaptureEvent.silent();
      case 'ended':
        _releasePath();
        final result = ScreenAudioSource.resultOf(e);
        final error = e['error'];
        Recording? recording;
        var failure = error is String ? failureOf(error) : null;
        if (result != null) {
          try {
            recording = await _recording(result);
          } on Object {
            // Left on disk; recovery offers it.
            failure ??= const Failure.storage();
          }
        }
        yield ScreenCaptureEvent.ended(recording: recording, failure: failure);
    }
  });

  Future<Recording> _recording(ScreenAudioResult result) async {
    var path = result.path;
    var duration = Duration(milliseconds: result.durationMs);
    if (path.endsWith('.aac')) {
      final finished = await _store.finalize(path);
      path = finished.path;
      duration = finished.duration;
    }
    final size = await File(path).length();
    if (size <= 0) throw const FileSystemException('empty recording');
    return Recording(path: path, sizeBytes: size, duration: duration);
  }

  void _releasePath() {
    final path = _path;
    _path = null;
    if (path != null) _store.release(path);
  }

  /// Native error code → failure.
  static Failure failureOf(String code) => switch (code) {
    CaptureErrorCodes.unsupported => const Failure.capture(
      CaptureError.unsupported,
    ),
    CaptureErrorCodes.consentDenied => const Failure.capture(
      CaptureError.consentDenied,
    ),
    CaptureErrorCodes.micPermission => const Failure.permissionDenied(),
    CaptureErrorCodes.busy => const Failure.capture(CaptureError.busy),
    CaptureErrorCodes.storage ||
    CaptureErrorCodes.notRunning => const Failure.storage(),
    _ => const Failure.capture(CaptureError.captureFailed),
  };
}
