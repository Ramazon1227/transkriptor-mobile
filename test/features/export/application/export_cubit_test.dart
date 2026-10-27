import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/export/application/export_cubit.dart';
import 'package:transkriptor_uz/features/export/domain/export_options.dart';
import 'package:transkriptor_uz/features/export/domain/i_export_facade.dart';
import 'package:transkriptor_uz/features/export/infrastructure/facades/export_facade.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

class _MockExportFacade extends Mock implements IExportFacade;

class _MockSharePlus extends Mock implements SharePlus;

class _FakeShareParams extends Fake implements ShareParams;

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

  setUpAll(() => registerFallbackValue(_FakeShareParams()));
  setUp(() => facade = _MockExportFacade());

  blocTest<ExportCubit, ExportState>(
    'shares the chosen format with its name, type and body',
    setUp: () => when(
      () => facade.shareFile(
        fileName: any(named: 'fileName'),
        mimeType: any(named: 'mimeType'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => const Right(unit)),
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
    verify: (_) => verify(
      () => facade.shareFile(
        fileName: 'Kengash.srt',
        mimeType: 'application/x-subrip',
        body: '1\n00:00:00,000 --> 00:00:02,000\nAli: Salom.\n',
      ),
    ).called(1),
  );

  blocTest<ExportCubit, ExportState>(
    'options change the file',
    setUp: () => when(
      () => facade.shareFile(
        fileName: any(named: 'fileName'),
        mimeType: any(named: 'mimeType'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => const Right(unit)),
    build: () => ExportCubit(facade),
    act: (cubit) async {
      cubit.setOptions(const ExportOptions(timecodes: false, speakers: false));
      await cubit.share(_transcript);
    },
    verify: (_) => verify(
      () => facade.shareFile(
        fileName: 'Kengash.txt',
        mimeType: 'text/plain',
        body: 'Salom.\n',
      ),
    ).called(1),
  );

  blocTest<ExportCubit, ExportState>(
    'a failure is shown and the options stay',
    setUp: () => when(
      () => facade.shareFile(
        fileName: any(named: 'fileName'),
        mimeType: any(named: 'mimeType'),
        body: any(named: 'body'),
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

  group('ExportFacade', () {
    test('hands share_plus one UTF-8 file under the given name', () async {
      final share = _MockSharePlus();
      when(() => share.share(any())).thenAnswer(
        (_) async => const ShareResult('', ShareResultStatus.dismissed),
      );
      final result = await ExportFacade(share).shareFile(
        fileName: 'Kengash.txt',
        mimeType: 'text/plain',
        body: 'oʻzbek',
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
      final result = await ExportFacade(share)
          .shareFile(fileName: 'a.txt', mimeType: 'text/plain', body: 'x');
      expect(result.fold((f) => f, (_) => null), const Failure.storage());
    });
  });
}
