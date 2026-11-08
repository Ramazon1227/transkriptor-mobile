import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/storage/token_storage.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/store/recordings_store.dart';

import '../../../helpers/adts.dart';
import '../../../helpers/tokens.dart';

class _MockNative extends Mock implements NativeCaptureChannel;

void main() {
  late Directory dir;
  late _MockNative native;
  late RecordingsStore store;
  late FakeTokenStorage tokens;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('recordings_test');
    native = _MockNative();
    tokens = FakeTokenStorage('u1');
    store = RecordingsStore.at(dir, native, tokens);
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

  test('iOS partial paths are .part.m4a and complete to .m4a', () async {
    final at = DateTime.fromMillisecondsSinceEpoch(2000);
    put('mic_2000.m4a', [1]); // taken: the next free millisecond is used
    final p = await store.newPartialPath(RecordingKind.microphone, now: at);
    expect(p, '${dir.path}/mic_2001.part.m4a');
    File(p).writeAsBytesSync([1, 2]);
    expect(await store.list(), hasLength(1)); // held: only mic_2000

    final done = await store.complete(p);
    expect(done, '${dir.path}/mic_2001.m4a');
    expect(File(p).existsSync(), isFalse);
    expect(store.isActive(p), isFalse);
  });

  test('a .part.m4a nobody holds had no index: deleted, not offered', () async {
    put('mic_9.part.m4a', [1, 2, 3]);
    expect(await store.list(), isEmpty);
    expect(File('${dir.path}/mic_9.part.m4a').existsSync(), isFalse);
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

  group('one phone, several accounts (MB-11)', () {
    Future<String> record(String user) async {
      tokens.signIn(user);
      final path = await store.newPath(RecordingKind.microphone);
      File(path).writeAsBytesSync(adtsFrames(3));
      store.release(path);
      return path;
    }

    test('another account never sees it; the owner does again', () async {
      final mine = await record('alice');

      tokens.signIn('bob');
      expect(await store.list(), isEmpty);
      expect(File(mine).existsSync(), isTrue);

      tokens.signIn('alice');
      expect((await store.list()).single.path, mine);
    });

    test("a recording kept when the session ended stays the owner's", () async {
      // R-4: the recorder stops and keeps the file; the owner label
      // written at start goes with it to the .m4a.
      tokens.signIn('alice');
      final aac = await store.newPath(RecordingKind.screen);
      File(aac).writeAsBytesSync(adtsFrames(3));
      tokens.signIn(null);
      final m4a = RecordingsStore.finishedPath(aac);
      when(() => native.finalize(src: aac, dst: m4a)).thenAnswer((_) async {
        File(m4a).writeAsBytesSync([1, 2, 3]);
        return const Duration(seconds: 1);
      });
      await store.finalize(aac);
      store.release(aac);

      expect(await store.list(), isEmpty); // nobody signed in
      tokens.signIn('bob');
      expect(await store.list(), isEmpty);
      tokens.signIn('alice');
      expect((await store.list()).single.path, m4a);
    });

    test('a recording from before owners goes to the first account', () async {
      put('mic_1.m4a', [1, 2, 3]);

      tokens.signIn('alice');
      expect(await store.list(), hasLength(1));
      tokens.signIn('bob');
      expect(await store.list(), isEmpty);
    });

    test("another account's leftovers are not cleaned up", () async {
      put('mic_1.aac', const []);
      put('mic_1.owner', 'bob'.codeUnits);

      tokens.signIn('alice');
      expect(await store.list(), isEmpty);
      expect(File('${dir.path}/mic_1.aac').existsSync(), isTrue);
    });

    test('the label goes with the recording', () async {
      final discarded = await record('alice');
      final sent = await record('alice');

      await store.delete(discarded);
      expect(File(discarded.replaceAll('.aac', '.owner')).existsSync(), false);

      File(sent).deleteSync(); // as the upload does
      expect(await store.list(), isEmpty);
      expect(dir.listSync(), isEmpty);
    });

    test('a blank or broken label counts as no label', () async {
      // An app killed mid-write leaves an empty label behind.
      put('mic_1.m4a', [1, 2, 3]);
      put('mic_1.owner', const []);
      put('mic_2.m4a', [1, 2, 3]);
      put('mic_2.owner', '  \n'.codeUnits);
      put('mic_3.m4a', [1, 2, 3]);
      put('mic_3.owner', const [0xff, 0xfe, 0xc3]); // not UTF-8

      tokens.signIn('alice');
      expect(await store.list(), hasLength(3));
      tokens.signIn('bob');
      expect(await store.list(), isEmpty); // claimed by alice
    });

    test('a label with a trailing newline still names its owner', () async {
      put('mic_1.m4a', [1, 2, 3]);
      put('mic_1.owner', 'alice\n'.codeUnits);

      tokens.signIn('alice');
      expect(await store.list(), hasLength(1));
    });

    test('labels are written whole: no temp file is left over', () async {
      put('mic_1.m4a', [1, 2, 3]);
      put('mic_9.owner.tmp', 'ali'.codeUnits); // a write cut short
      tokens.signIn('alice');
      final path = await store.newPath(RecordingKind.microphone);
      expect(await store.list(), hasLength(1));

      final names = dir.listSync().map((f) => f.path.split('/').last);
      expect(names.where((n) => n.endsWith('.tmp')), isEmpty);
      expect(
        File(path.replaceAll('.aac', '.owner')).readAsStringSync(),
        'alice',
      );
      expect(File('${dir.path}/mic_1.owner').readAsStringSync(), 'alice');
    });

    test(
      'unreadable token storage: records unlabelled, offers nothing',
      () async {
        tokens.broken = true;

        final path = await store.newPath(RecordingKind.microphone);
        expect(store.isActive(path), isTrue);
        expect(File(path.replaceAll('.aac', '.owner')).existsSync(), isFalse);
        File(path).writeAsBytesSync(adtsFrames(3));
        store.release(path);
        expect(await store.list(), isEmpty);
        expect(File(path).existsSync(), isTrue);

        tokens
          ..broken = false
          ..signIn('alice');
        expect((await store.list()).single.path, path);
      },
    );

    test('a label of a session still starting is kept', () async {
      tokens.signIn('alice');
      final path = await store.newPath(RecordingKind.microphone);
      // No bytes yet: the file is opened just after.
      expect(await store.list(), isEmpty);
      expect(File(path.replaceAll('.aac', '.owner')).existsSync(), isTrue);
    });
  });

  test('tokenSubject reads sub and refuses anything else', () {
    expect(tokenSubject(tokenFor('u-1')), 'u-1');
    expect(tokenSubject(null), isNull);
    expect(tokenSubject('opaque'), isNull);
    expect(tokenSubject('a.%%%.c'), isNull);
    expect(tokenSubject('a.${'bm90IGpzb24'}.c'), isNull); // "not json"
  });

  test(
    'deleting an account takes only its finished recordings (MB-12)',
    () async {
      put('mic_1.aac', adtsFrames(3));
      put('mic_1.m4a', [1, 2, 3]);
      put('mic_1.owner', 'alice'.codeUnits);
      put('mic_2.part.m4a', [1, 2, 3]);
      put('mic_2.owner', 'alice\n'.codeUnits);
      put('mic_3.m4a', [1, 2, 3]);
      put('mic_3.owner', 'bob'.codeUnits);
      put('mic_4.m4a', [1, 2, 3]); // from before labels
      put('screen_5.aac', adtsFrames(3)); // a native session still running
      put('screen_5.owner', 'alice'.codeUnits);
      when(() => native.activeScreenPath())
          .thenAnswer((_) async => '${dir.path}/screen_5.aac');
      tokens.signIn('alice');
      final live = await store.newPath(RecordingKind.microphone);
      File(live).writeAsBytesSync(adtsFrames(3));

      await store.deleteOwnedBy('alice');

      final left = dir.listSync().map((f) => f.path.split('/').last).toSet();
      expect(left, {
        'mic_3.m4a',
        'mic_3.owner',
        'mic_4.m4a',
        'screen_5.aac',
        'screen_5.owner',
        live.split('/').last,
        live.split('/').last.replaceAll('.aac', '.owner'),
        'deleted_accounts',
      });
    },
  );

  group('account deletion, review (MB-12)', () {
    test('the warning counts what deleting would take', () async {
      put('mic_1.m4a', [1, 2, 3]);
      put('mic_1.owner', 'alice'.codeUnits);
      put('mic_2.aac', adtsFrames(3));
      put('mic_2.owner', 'alice'.codeUnits);
      put('mic_3.m4a', [1, 2, 3]);
      put('mic_3.owner', 'bob'.codeUnits);
      put('mic_4.m4a', [1, 2, 3]); // unlabelled
      put('mic_5.owner', 'alice'.codeUnits); // label of a sent recording
      put('screen_6.aac', adtsFrames(3)); // still running natively
      put('screen_6.owner', 'alice'.codeUnits);
      when(() => native.activeScreenPath())
          .thenAnswer((_) async => '${dir.path}/screen_6.aac');

      expect(await store.countOwnedBy('alice'), 2);
      expect(await store.countOwnedBy('bob'), 1);
      expect(File('${dir.path}/mic_1.m4a').existsSync(), isTrue);
    });

    test('a native channel that fails keeps every screen recording', () async {
      put('screen_1.aac', adtsFrames(3));
      put('screen_1.owner', 'alice'.codeUnits);
      put('mic_2.m4a', [1, 2, 3]);
      put('mic_2.owner', 'alice'.codeUnits);
      when(() => native.activeScreenPath())
          .thenThrow(PlatformException(code: 'ERROR'));

      expect(await store.countOwnedBy('alice'), 1);
      await store.deleteOwnedBy('alice');

      expect(File('${dir.path}/screen_1.aac').existsSync(), isTrue);
      expect(File('${dir.path}/mic_2.m4a').existsSync(), isFalse);
    });

    test(
      'a recording finished after its account was deleted goes later',
      () async {
        when(() => native.activeScreenPath()).thenAnswer((_) async => null);
        tokens.signIn('alice');
        final live = await store.newPath(RecordingKind.microphone);
        File(live).writeAsBytesSync(adtsFrames(3));

        await store.deleteOwnedBy('alice'); // still being written: skipped
        expect(File(live).existsSync(), isTrue);
        store.release(live); // the session ends under alice's label

        tokens.signIn('bob');
        expect(await store.list(), isEmpty);
        expect(File(live).existsSync(), isFalse);
        expect(File(live.replaceAll('.aac', '.owner')).existsSync(), isFalse);
      },
    );

    test('deleted accounts are remembered, the last ten only', () async {
      when(() => native.activeScreenPath()).thenAnswer((_) async => null);
      for (var i = 0; i < 12; i++) {
        await store.deleteOwnedBy('a$i');
      }
      put('mic_1.m4a', [1, 2, 3]);
      put('mic_1.owner', 'a1'.codeUnits); // forgotten: kept
      put('mic_2.m4a', [1, 2, 3]);
      put('mic_2.owner', 'a2'.codeUnits); // remembered: purged

      tokens.signIn('bob');
      await store.list();

      expect(File('${dir.path}/mic_1.m4a').existsSync(), isTrue);
      expect(File('${dir.path}/mic_2.m4a').existsSync(), isFalse);
    });
  });
}
