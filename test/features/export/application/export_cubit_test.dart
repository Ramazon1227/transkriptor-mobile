import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/export/application/export_cubit.dart';
import 'package:transkriptor_uz/features/export/domain/export_options.dart';
import 'package:transkriptor_uz/features/export/domain/i_export_facade.dart';
import 'package:transkriptor_uz/features/export/domain/transcript_export.dart';
import 'package:transkriptor_uz/features/export/infrastructure/facades/export_facade.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

class _MockExportFacade extends Mock implements IExportFacade;

class _MockSharePlus extends Mock implements SharePlus;

class _FakeShareParams extends Fake implements ShareParams;

class _MockAssetBundle extends Mock implements AssetBundle;

/// The fonts the app bundles, read from disk as the bundle would.
class _DiskBundle extends Fake implements AssetBundle {
  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(await File(key).readAsBytes());
}

const _transcript = Transcript(
  id: 't1',
  title: 'Kengash',
  speakers: [Speaker(id: 'a', label: 'Ali', ordinal: 1)],
  segments: [
    Segment(
      id: 'g1',
      start: Duration.zero,
      end: Duration(seconds: 2),
      text: 'Salom.',
      speakerId: 'a',
    ),
  ],
);

void main() {
  late _MockExportFacade facade;

  setUpAll(() {
    registerFallbackValue(_FakeShareParams());
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(<ExportBlock>[]);
  });
  setUp(() {
    facade = _MockExportFacade();
    when(
      () => facade.shareFile(
        fileName: any(named: 'fileName'),
        mimeType: any(named: 'mimeType'),
        bytes: any(named: 'bytes'),
      ),
    ).thenAnswer((_) async => const Right(unit));
  });

  /// What the cubit handed to the share sheet: name, type and bytes.
  ({String name, String type, Uint8List bytes}) shared() {
    final call = verify(
      () => facade.shareFile(
        fileName: captureAny(named: 'fileName'),
        mimeType: captureAny(named: 'mimeType'),
        bytes: captureAny(named: 'bytes'),
      ),
    )..called(1);
    return (
      name: call.captured[0] as String,
      type: call.captured[1] as String,
      bytes: call.captured[2] as Uint8List,
    );
  }

  blocTest<ExportCubit, ExportState>(
    'shares the chosen format with its name, type and bytes',
    build: () => ExportCubit(facade),
    act: (cubit) async {
      cubit.setFormat(ExportFormat.srt);
      await cubit.share(_transcript);
    },
    expect: () => const [
      ExportState(format: ExportFormat.srt),
      ExportState(format: ExportFormat.srt, status: ExportStatus.sharing),
      ExportState(format: ExportFormat.srt),
    ],
    verify: (_) {
      final file = shared();
      expect(file.name, 'Kengash.srt');
      expect(file.type, 'application/x-subrip');
      expect(
        utf8.decode(file.bytes),
        '1\n00:00:00,000 --> 00:00:02,000\nAli: Salom.\n',
      );
    },
  );

  blocTest<ExportCubit, ExportState>(
    'options change the file',
    build: () => ExportCubit(facade),
    act: (cubit) async {
      cubit.setOptions(const ExportOptions(timecodes: false, speakers: false));
      await cubit.share(_transcript);
    },
    verify: (_) {
      final file = shared();
      expect(file.name, 'Kengash.txt');
      expect(file.type, 'text/plain');
      expect(utf8.decode(file.bytes), 'Salom.\n');
    },
  );

  blocTest<ExportCubit, ExportState>(
    'CSV goes out as text/csv with the BOM',
    build: () => ExportCubit(facade),
    seed: () => const ExportState(format: ExportFormat.csv),
    act: (cubit) => cubit.share(_transcript),
    verify: (_) {
      final file = shared();
      expect(file.name, 'Kengash.csv');
      expect(file.type, 'text/csv');
      // utf8.decode drops a leading BOM, so the bytes are checked.
      expect(file.bytes.take(3), [0xEF, 0xBB, 0xBF]);
      expect(
        utf8.decode(file.bytes.sublist(3)),
        'start,end,speaker,text\n00:00:00,00:00:02,Ali,Salom.\n',
      );
    },
  );

  blocTest<ExportCubit, ExportState>(
    'a failure is shown and the options stay',
    setUp: () => when(
      () => facade.shareFile(
        fileName: any(named: 'fileName'),
        mimeType: any(named: 'mimeType'),
        bytes: any(named: 'bytes'),
      ),
    ).thenAnswer((_) async => const Left(Failure.storage())),
    build: () => ExportCubit(facade),
    seed: () => const ExportState(format: ExportFormat.vtt),
    act: (cubit) => cubit.share(_transcript),
    skip: 1,
    expect: () => const [
      ExportState(
        format: ExportFormat.vtt,
        status: ExportStatus.failure,
        failure: Failure.storage(),
      ),
    ],
  );

  blocTest<ExportCubit, ExportState>(
    'DOCX is a zip whose document carries the blocks and the plain title',
    build: () => ExportCubit(facade),
    seed: () => const ExportState(
      format: ExportFormat.docx,
      options: ExportOptions(plainApostrophe: true),
    ),
    act: (cubit) => cubit.share(_transcript.copyWith(title: 'Majlis: oʻquv')),
    verify: (_) {
      final file = shared();
      expect(file.name, 'Majlis_ oʻquv.docx');
      expect(file.type, ExportFormat.docx.mimeType);
      final zip = ZipDecoder().decodeBytes(file.bytes);
      expect(zip.files.map((f) => f.name), [
        '[Content_Types].xml',
        '_rels/.rels',
        'word/document.xml',
      ]);
      final xml = utf8.decode(zip.findFile('word/document.xml')!.content);
      expect(xml, contains("Majlis: o'quv"));
      expect(xml, contains('[00:00:00] '));
      expect(xml, contains('Ali: '));
    },
  );

  blocTest<ExportCubit, ExportState>(
    'PDF is drawn by the facade and shared as application/pdf',
    setUp: () =>
        when(() => facade.pdf(any(), any()))
            .thenAnswer((_) async => Right(Uint8List.fromList([1, 2, 3]))),
    build: () => ExportCubit(facade),
    seed: () => const ExportState(format: ExportFormat.pdf),
    act: (cubit) => cubit.share(_transcript),
    verify: (_) {
      final file = shared();
      expect(file.name, 'Kengash.pdf');
      expect(file.type, 'application/pdf');
      expect(file.bytes, [1, 2, 3]);
      final call = verify(() => facade.pdf(captureAny(), captureAny()));
      expect(call.captured[0], 'Kengash');
      final blocks = call.captured[1] as List<ExportBlock>;
      expect(blocks.single.text, 'Salom.');
    },
  );

  blocTest<ExportCubit, ExportState>(
    'a PDF that cannot be drawn is a failure and nothing is shared',
    setUp: () =>
        when(() => facade.pdf(any(), any()))
            .thenAnswer((_) async => const Left(Failure.unknown())),
    build: () => ExportCubit(facade),
    seed: () => const ExportState(format: ExportFormat.pdf),
    act: (cubit) => cubit.share(_transcript),
    skip: 1,
    expect: () => const [
      ExportState(
        format: ExportFormat.pdf,
        status: ExportStatus.failure,
        failure: Failure.unknown(),
      ),
    ],
    verify: (_) => verifyNever(
      () => facade.shareFile(
        fileName: any(named: 'fileName'),
        mimeType: any(named: 'mimeType'),
        bytes: any(named: 'bytes'),
      ),
    ),
  );

  group('ExportFacade', () {
    test('draws a PDF with the bundled fonts', () async {
      final result = await ExportFacade(_MockSharePlus(), _DiskBundle()).pdf(
        'Majlis: oʻquv',
        const [
          ExportBlock(time: '00:00:05', speaker: 'Ali', text: 'Салом, taʼlim.'),
        ],
      );
      final bytes = result.getOrElse(() => Uint8List(0));
      expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    });

    test('one paragraph longer than a page still draws', () async {
      // About 20 000 words: one block over many pages, past the 20-page
      // default.
      final long = List.filled(20000, 'soʻz').join(' ');
      final result = await ExportFacade(
        _MockSharePlus(),
        _DiskBundle(),
      ).pdf('Bitta', [ExportBlock(time: null, speaker: '', text: long)]);
      expect(result.isRight(), isTrue);
    });

    test('a missing font is a failure, not a crash', () async {
      final assets = _MockAssetBundle();
      when(() => assets.load(any())).thenThrow(Exception('no asset'));
      final result = await ExportFacade(_MockSharePlus(), assets).pdf('a', []);
      expect(result.fold((f) => f, (_) => null), const Failure.unknown());
    });

    test('hands share_plus one UTF-8 file under the given name', () async {
      final share = _MockSharePlus();
      when(() => share.share(any())).thenAnswer(
        (_) async => const ShareResult('', ShareResultStatus.dismissed),
      );
      final result = await ExportFacade(share, _MockAssetBundle()).shareFile(
        fileName: 'Kengash.txt',
        mimeType: 'text/plain',
        bytes: utf8.encode('oʻzbek'),
      );
      // Closing the share sheet is not a failure.
      expect(result.isRight(), isTrue);
      final params =
          verify(() => share.share(captureAny())).captured.single
              as ShareParams;
      expect(params.fileNameOverrides, ['Kengash.txt']);
      final file = params.files!.single;
      expect(file.mimeType, 'text/plain');
      expect(utf8.decode(await file.readAsBytes()), 'oʻzbek');
    });

    test('a platform error is a storage failure', () async {
      final share = _MockSharePlus();
      when(() => share.share(any())).thenThrow(Exception('no activity'));
      final result = await ExportFacade(share, _MockAssetBundle()).shareFile(
        fileName: 'a.txt',
        mimeType: 'text/plain',
        bytes: utf8.encode('x'),
      );
      expect(result.fold((f) => f, (_) => null), const Failure.storage());
    });
  });
}
