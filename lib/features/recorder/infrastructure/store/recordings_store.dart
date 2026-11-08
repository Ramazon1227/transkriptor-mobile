import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transkriptor_uz/core/storage/token_storage.dart';
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
/// - `.part.m4a` = iOS only, written while recording (`record` writes the
///   .m4a itself there; the ADTS remux is Android code). An .m4a whose
///   muxer never finished has no index and cannot be played, so one left
///   behind by a killed app holds nothing to recover and is deleted.
///
/// So "unsent" needs no state of its own: anything in the folder that no
/// live session is writing is recoverable.
///
/// One phone can be used by several accounts (MB-11): `mic_1.owner` next
/// to `mic_1.aac` / `.m4a` holds the id of the account that made it, and
/// [list] offers only the signed-in account's recordings. The others stay
/// on disk, untouched, until their owner signs in again. A recording from
/// before owners were written goes to the first account that sees it.
@lazySingleton
class RecordingsStore {
  RecordingsStore(this._native, this._tokens) : _fixedRoot = null;

  @visibleForTesting
  RecordingsStore.at(Directory root, this._native, this._tokens)
    : _fixedRoot = root;

  final Directory? _fixedRoot;
  final NativeCaptureChannel _native;
  final TokenStorage _tokens;

  /// Files a live session in this engine is writing.
  final Set<String> _active = {};

  static final RegExp _name = RegExp(r'^(mic|screen|rec)_(\d+)\.(aac|m4a)$');
  static final RegExp _partial = RegExp(r'^(mic|screen|rec)_(\d+)\.part\.m4a$');

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
  Future<String> newPath(RecordingKind kind, {DateTime? now}) =>
      _newPath(kind, '.aac', now: now);

  /// iOS: a fresh `.part.m4a` path for a session `record` writes as .m4a
  /// itself; [complete] gives it its final name.
  Future<String> newPartialPath(RecordingKind kind, {DateTime? now}) =>
      _newPath(kind, '.part.m4a', now: now);

  Future<String> _newPath(
    RecordingKind kind,
    String ext, {
    DateTime? now,
  }) async {
    final dir = await directory();
    final prefix = kind == RecordingKind.screen ? 'screen' : 'mic';
    var ms = (now ?? DateTime.now()).millisecondsSinceEpoch;
    bool taken(int ms) => ['.aac', '.m4a', '.part.m4a'].any((e) {
      final p = '${dir.path}/${prefix}_$ms$e';
      return _active.contains(p) || File(p).existsSync();
    });
    // Two sessions in one millisecond would share a name.
    while (taken(ms)) {
      ms++;
    }
    final path = '${dir.path}/${prefix}_$ms$ext';
    _active.add(path);
    try {
      final owner = await _owner();
      if (owner != null) await _writeLabel(path, owner);
    } on Object {
      _active.remove(path);
      rethrow;
    }
    return path;
  }

  /// The signed-in account, from the token it signed in with. Null when
  /// nobody is, or when the token store cannot be read (Keystore after a
  /// backup restore, a locked iOS keychain): recording must still work.
  Future<String?> _owner() async {
    try {
      return tokenSubject(await _tokens.readAccessToken());
    } on Object {
      return null;
    }
  }

  /// Written to a temp file and renamed, so a killed app never leaves a
  /// half label that would hide the recording from its owner.
  static Future<void> _writeLabel(String path, String owner) async {
    final label = _ownerPath(path);
    final tmp = File('$label.tmp');
    await tmp.writeAsString(owner, flush: true);
    await tmp.rename(label);
  }

  /// The account a label names; null when there is none, or it is blank or
  /// unreadable (then it is treated as from before labels).
  static Future<String?> _readLabel(String path) async {
    try {
      final owner = (await File(_ownerPath(path)).readAsString()).trim();
      return owner.isEmpty ? null : owner;
    } on FileSystemException {
      return null;
    } on FormatException {
      return null;
    }
  }

  /// `<dir>/mic_1.aac`, `.m4a` or `.part.m4a` → `<dir>/mic_1.owner`: one
  /// label for every stage of a recording.
  static String _ownerPath(String path) {
    final slash = path.lastIndexOf('/');
    final dot = path.indexOf('.', slash + 1);
    return '${dot < 0 ? path : path.substring(0, dot)}.owner';
  }

  void release(String path) => _active.remove(path);

  bool isActive(String path) => _active.contains(path);

  /// `x.aac` → `x.m4a`.
  static String finishedPath(String aacPath) => aacPath.endsWith('.aac')
      ? '${aacPath.substring(0, aacPath.length - 4)}.m4a'
      : '$aacPath.m4a';

  /// `x.part.m4a` → `x.m4a`.
  static String completedPath(String partialPath) =>
      partialPath.endsWith('.part.m4a')
      ? '${partialPath.substring(0, partialPath.length - 9)}.m4a'
      : partialPath;

  /// iOS: a `.part.m4a` that `record` closed becomes a finished `.m4a`.
  Future<String> complete(String partialPath) async {
    final dst = completedPath(partialPath);
    await File(partialPath).rename(dst);
    _active.remove(partialPath);
    return dst;
  }

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
    await _purgeDeleted(exclude);
    final owner = await _owner();
    // Nobody signed in (or unknown): nothing here is theirs.
    if (owner == null) return const [];
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
      if (_partial.hasMatch(name)) {
        // iOS, killed mid-recording: an .m4a without its index.
        if (!skip.contains(file.path)) await _deleteQuietly(file.path);
        continue;
      }
      final match = _name.firstMatch(name);
      if (match == null || skip.contains(file.path)) continue;
      final madeBy = await _readLabel(file.path);
      // Another account's recording: not shown and not touched.
      if (madeBy != null && madeBy != owner) continue;
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
      if (madeBy == null) await _claim(file.path, owner);
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
    await _dropStrayOwners(files, exclude);
    found.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return found;
  }

  /// A recording from before owners were written. Best effort: if the
  /// label cannot be written it is offered unlabelled, as it was before.
  static Future<void> _claim(String path, String owner) async {
    try {
      await _writeLabel(path, owner);
    } on FileSystemException {
      // Asked again on the next list.
    }
  }

  /// Labels whose recording is gone (sent, discarded, held nothing), and
  /// temp labels a killed app left behind.
  Future<void> _dropStrayOwners(
    List<File> files,
    Iterable<String> exclude,
  ) async {
    for (final file in files) {
      final name = _basename(file.path);
      final temp = name.endsWith('.owner.tmp');
      if (!temp && !name.endsWith('.owner')) continue;
      final label = temp
          ? file.path.substring(0, file.path.length - '.tmp'.length)
          : file.path;
      // [_held] reads the live set: a session may have started meanwhile.
      if (_held(label, exclude)) continue;
      if (temp || !_stageLeft(label)) await _deleteQuietly(file.path);
    }
  }

  /// MB-12: the account [owner] was deleted, so its unsent recordings go
  /// too. A recording still being written (this engine's, or a native
  /// screen session), another account's and an unlabelled one are left.
  /// The account is remembered, so a recording that was still being written
  /// goes on a later [list]. A file that cannot be deleted is skipped.
  Future<void> deleteOwnedBy(String owner) async {
    try {
      await _rememberDeleted(owner);
    } on Object {
      // Only the later clean-up is lost; what can go now still goes.
    }
    await _deleteLabels(await _ownedBy({owner}));
  }

  /// How many recordings [deleteOwnedBy] would take now, for the warning.
  Future<int> countOwnedBy(String owner) async =>
      (await _ownedBy({owner})).where(_stageLeft).length;

  /// Labels naming one of [owners] whose recording nothing is writing.
  Future<List<String>> _ownedBy(
    Set<String> owners, {
    Iterable<String> exclude = const [],
  }) async {
    String? screen;
    var screenUnknown = false;
    try {
      screen = await _native.activeScreenPath();
    } on Object {
      // No answer: a screen session may be running, so every screen
      // recording counts as live. iOS has no channel and no screen
      // recordings, so this costs it nothing.
      screenUnknown = true;
    }
    final dir = await directory();
    final labels = <String>[];
    await for (final entity in dir.list(followLinks: false)) {
      if (entity is File && entity.path.endsWith('.owner')) {
        labels.add(entity.path);
      }
    }
    final owned = <String>[];
    for (final label in labels) {
      if (screenUnknown && _basename(label).startsWith('screen_')) continue;
      if (_held(label, [...exclude, ?screen])) continue;
      final madeBy = await _readLabel(label);
      if (madeBy != null && owners.contains(madeBy)) owned.add(label);
    }
    return owned;
  }

  static Future<void> _deleteLabels(List<String> labels) async {
    for (final label in labels) {
      final stem = label.substring(0, label.length - '.owner'.length);
      for (final ext in ['.aac', '.m4a', '.part.m4a']) {
        await _deleteQuietly('$stem$ext');
      }
      await _deleteQuietly(label);
    }
  }

  /// Ids of deleted accounts, newest last, one per line; only ids.
  static const String _deletedName = 'deleted_accounts';
  static const int _deletedKept = 10;

  Future<List<String>> _readDeleted() async {
    final file = File('${(await directory()).path}/$_deletedName');
    try {
      return [
        for (final line in await file.readAsLines())
          if (line.trim().isNotEmpty) line.trim(),
      ];
    } on FileSystemException {
      return const [];
    } on FormatException {
      return const [];
    }
  }

  Future<void> _rememberDeleted(String owner) async {
    final ids = [...(await _readDeleted()).where((id) => id != owner), owner];
    final kept = ids.length > _deletedKept
        ? ids.sublist(ids.length - _deletedKept)
        : ids;
    final path = '${(await directory()).path}/$_deletedName';
    final tmp = File('$path.tmp');
    await tmp.writeAsString('${kept.join('\n')}\n', flush: true);
    await tmp.rename(path);
  }

  /// Recordings of deleted accounts that were still being written then.
  Future<void> _purgeDeleted(Iterable<String> exclude) async {
    try {
      final gone = await _readDeleted();
      if (gone.isEmpty) return;
      await _deleteLabels(await _ownedBy(gone.toSet(), exclude: exclude));
    } on Object {
      // Tried again on the next list.
    }
  }

  static Future<AdtsInfo> scan(File file) async {
    final scanner = AdtsScanner();
    await file.openRead().forEach(scanner.add);
    return scanner.result;
  }

  Future<void> delete(String path) async {
    _active.remove(path);
    await _deleteQuietly(path);
    final label = _ownerPath(path);
    if (!_held(label, const []) && !_stageLeft(label)) {
      await _deleteQuietly(label);
    }
  }

  bool _held(String label, Iterable<String> exclude) =>
      {..._active, ...exclude}.any((p) => _ownerPath(p) == label);

  /// Whether any stage of the recording [label] belongs to is on disk.
  static bool _stageLeft(String label) {
    final stem = label.substring(0, label.length - '.owner'.length);
    return [
      '.aac',
      '.m4a',
      '.part.m4a',
    ].any((e) => File('$stem$e').existsSync());
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
