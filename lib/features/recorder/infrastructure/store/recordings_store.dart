import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/store/adts_scanner.dart';

/// The one folder recordings live in until they are uploaded:
/// `<app documents>/recordings/` (documents, not cache: the OS may clear a
/// cache folder, and an unsent recording is the person's only copy).
///
/// Names: `<kind>_<epoch ms>.<ext>` with kind `mic` or `screen` (`rec_`
/// from older versions counts as `mic`).
/// - `.aac` = raw AAC in ADTS frames, written while recording. A file
///   still `.aac` when no session holds it was interrupted.
/// - `.m4a` = finished; it waits for upload. The upload deletes it.
///
/// So "unsent" needs no sidecar: anything in the folder that no live
/// session is writing is recoverable.
@lazySingleton
class RecordingsStore {
  RecordingsStore(this._native) : _fixedRoot = null;

  @visibleForTesting
  RecordingsStore.at(Directory root, this._native) : _fixedRoot = root;

  final Directory? _fixedRoot;
  final NativeCaptureChannel _native;

  /// Files a live session in this engine is writing.
  final Set<String> _active = {};

  static final RegExp _name = RegExp(r'^(mic|screen|rec)_(\d+)\.(aac|m4a)$');

  Future<Directory> directory() async {
    final dir =
        _fixedRoot ??
        Directory(
          '${(await getApplicationDocumentsDirectory()).path}/recordings',
        );
    await dir.create(recursive: true);
    return dir;
  }

  /// A fresh `.aac` path for a new session, held until [release].
  Future<String> newPath(RecordingKind kind, {DateTime? now}) async {
    final dir = await directory();
    final prefix = kind == RecordingKind.screen ? 'screen' : 'mic';
    var ms = (now ?? DateTime.now()).millisecondsSinceEpoch;
    var path = '${dir.path}/${prefix}_$ms.aac';
    // Two sessions in one millisecond would share a name.
    while (_active.contains(path) || File(path).existsSync()) {
      ms++;
      path = '${dir.path}/${prefix}_$ms.aac';
    }
    _active.add(path);
    return path;
  }

  void release(String path) => _active.remove(path);

  bool isActive(String path) => _active.contains(path);

  /// `x.aac` → `x.m4a`.
  static String finishedPath(String aacPath) => aacPath.endsWith('.aac')
      ? '${aacPath.substring(0, aacPath.length - 4)}.m4a'
      : '$aacPath.m4a';

  /// Turns an `.aac` into its `.m4a` and deletes the `.aac`. Returns the
  /// new path and its length. Throws when nothing in it is playable; the
  /// `.aac` is then kept.
  Future<({String path, Duration duration})> finalize(String aacPath) async {
    final dst = finishedPath(aacPath);
    final duration = await _native.finalize(src: aacPath, dst: dst);
    await _deleteQuietly(aacPath);
    return (path: dst, duration: duration);
  }

  /// Every recording no live session holds, newest first. Empty files and
  /// `.aac` files without a single whole frame hold nothing and are
  /// deleted on the way; an `.aac` whose `.m4a` already exists is the
  /// leftover of a finalize that did not get to delete it.
  Future<List<RecoverableRecording>> list({
    Iterable<String> exclude = const [],
  }) async {
    final dir = await directory();
    final skip = {..._active, ...exclude};
    final files = <File>[];
    await for (final entity in dir.list(followLinks: false)) {
      if (entity is File) files.add(entity);
    }
    final names = files.map((f) => _basename(f.path)).toSet();

    final found = <RecoverableRecording>[];
    for (final file in files) {
      final name = _basename(file.path);
      final match = _name.firstMatch(name);
      if (match == null || skip.contains(file.path)) continue;
      final interrupted = match.group(3) == 'aac';
      if (interrupted && names.contains(_basename(finishedPath(name)))) {
        await _deleteQuietly(file.path);
        continue;
      }
      final int size;
      try {
        size = await file.length();
      } on FileSystemException {
        continue;
      }
      if (size == 0) {
        await _deleteQuietly(file.path);
        continue;
      }
      Duration? duration;
      if (interrupted) {
        final info = await scan(file);
        if (info.frames == 0) {
          await _deleteQuietly(file.path);
          continue;
        }
        duration = info.duration;
      } else {
        try {
          duration = await _native.durationOf(file.path);
        } on Object {
          duration = null;
        }
      }
      found.add(
        RecoverableRecording(
          path: file.path,
          kind: match.group(1) == 'screen'
              ? RecordingKind.screen
              : RecordingKind.microphone,
          state: interrupted
              ? RecordingCompletion.interrupted
              : RecordingCompletion.finished,
          createdAt: DateTime.fromMillisecondsSinceEpoch(
            int.parse(match.group(2)!),
          ),
          sizeBytes: size,
          duration: duration,
        ),
      );
    }
    found.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return found;
  }

  static Future<AdtsInfo> scan(File file) async {
    final scanner = AdtsScanner();
    await file.openRead().forEach(scanner.add);
    return scanner.result;
  }

  Future<void> delete(String path) async {
    _active.remove(path);
    await _deleteQuietly(path);
  }

  static String _basename(String path) =>
      path.substring(path.lastIndexOf('/') + 1);

  static Future<void> _deleteQuietly(String path) async {
    try {
      await File(path).delete();
    } on FileSystemException {
      // Already gone, or not ours to delete: nothing to recover either way.
    }
  }
}
