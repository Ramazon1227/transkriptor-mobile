import 'dart:io';

import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/infrastructure/models/job_model.dart';
import 'package:transkriptor_uz/features/job/infrastructure/repositories/job_repository.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/facades/upload_facade.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/media_picker.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/models/media_created_model.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/repositories/upload_repository.dart';

class _MockRepository extends Mock implements UploadRepository;

class _MockJobs extends Mock implements JobRepository;

class _MockPicker extends Mock implements MediaPicker;

void main() {
  late _MockRepository repository;
  late _MockJobs jobs;
  late LibraryChanges changes;
  late UploadFacade facade;
  late List<void> notified;

  const file = PendingFile(
    path: '/docs/recordings/rec_1.m4a',
    fileName: 'Yozuv 26.10.2026.m4a',
    sizeBytes: 3200000,
    source: UploadSource.recording,
    duration: Duration(minutes: 12, seconds: 47),
  );

  void stubPut() => when(
    () => repository.putFile(
      uploadUrl: any(named: 'uploadUrl'),
      path: any(named: 'path'),
      sizeBytes: any(named: 'sizeBytes'),
      contentType: any(named: 'contentType'),
      onProgress: any(named: 'onProgress'),
    ),
  ).thenAnswer((_) async => const Right(unit));

  setUp(() {
    repository = _MockRepository();
    jobs = _MockJobs();
    changes = LibraryChanges();
    notified = [];
    changes.stream.listen(notified.add);
    facade = UploadFacade(repository, jobs, _MockPicker(), changes);

    when(
      () => repository.createMedia(
        workspaceId: any(named: 'workspaceId'),
        fileName: any(named: 'fileName'),
        sizeBytes: any(named: 'sizeBytes'),
        source: any(named: 'source'),
      ),
    ).thenAnswer(
      (_) async => const Right(
        MediaCreatedModel(id: 'm1', uploadUrl: 'https://api.uz/u/tok'),
      ),
    );
    when(() => repository.confirm('m1'))
        .thenAnswer((_) async => const Right(unit));
  });

  tearDown(() => changes.dispose());

  test('create → PUT → confirm → job, with the new title and type', () async {
    stubPut();
    when(() => jobs.createJob(mediaId: 'm1', numSpeakers: 2)).thenAnswer(
      (_) async => const Right(
        JobModel(id: 'j1', mediaId: 'm1', status: JobStatus.queued),
      ),
    );

    final result = await facade.upload(
      file: file,
      workspaceId: 'w1',
      title: '  Kengash yigʻilishi ',
      startTranscription: true,
      numSpeakers: 2,
    );

    expect(result.getOrElse(() => throw StateError('left')).job?.id, 'j1');
    verifyInOrder([
      () => repository.createMedia(
        workspaceId: 'w1',
        fileName: 'Kengash yigʻilishi.m4a',
        sizeBytes: 3200000,
        source: 'RECORDING',
      ),
      () => repository.putFile(
        uploadUrl: 'https://api.uz/u/tok',
        path: file.path,
        sizeBytes: 3200000,
        contentType: 'audio/mp4',
        onProgress: any(named: 'onProgress'),
      ),
      () => repository.confirm('m1'),
      () => jobs.createJob(mediaId: 'm1', numSpeakers: 2),
    ]);
  });

  test('a failed PUT stops before confirm and starts nothing', () async {
    when(
      () => repository.putFile(
        uploadUrl: any(named: 'uploadUrl'),
        path: any(named: 'path'),
        sizeBytes: any(named: 'sizeBytes'),
        contentType: any(named: 'contentType'),
        onProgress: any(named: 'onProgress'),
      ),
    ).thenAnswer((_) async => const Left(Failure.network()));

    final result = await facade.upload(
      file: file,
      workspaceId: 'w1',
      title: '',
      startTranscription: true,
    );

    expect(result, const Left<Failure, Object>(Failure.network()));
    verifyNever(() => repository.confirm(any()));
    verifyNever(
      () => jobs.createJob(
        mediaId: any(named: 'mediaId'),
        numSpeakers: any(named: 'numSpeakers'),
      ),
    );
  });

  test('save only stores the file, starts no job, announces it', () async {
    stubPut();

    final result = await facade.upload(
      file: file,
      workspaceId: 'w1',
      title: '',
      startTranscription: false,
    );
    await Future<void>.delayed(Duration.zero);

    final done = result.getOrElse(() => throw StateError('left'));
    expect(done.mediaId, 'm1');
    expect(done.job, isNull);
    expect(notified, hasLength(1));
    verifyNever(
      () => jobs.createJob(
        mediaId: any(named: 'mediaId'),
        numSpeakers: any(named: 'numSpeakers'),
      ),
    );
  });

  test('an empty title keeps the file name', () async {
    stubPut();
    await facade.upload(
      file: file,
      workspaceId: 'w1',
      title: ' ',
      startTranscription: false,
    );
    verify(
      () => repository.createMedia(
        workspaceId: 'w1',
        fileName: 'Yozuv 26.10.2026.m4a',
        sizeBytes: any(named: 'sizeBytes'),
        source: any(named: 'source'),
      ),
    ).called(1);
  });

  test(
    'a YouTube link goes to /media/youtube, Drive to /media/cloud',
    () async {
      when(
        () => repository.startLink(
          url: any(named: 'url'),
          workspaceId: any(named: 'workspaceId'),
          youtube: any(named: 'youtube'),
          numSpeakers: any(named: 'numSpeakers'),
        ),
      ).thenAnswer(
        (_) async => const Right(JobModel(id: 'j', status: JobStatus.queued)),
      );

      await facade.startLink(url: 'https://youtu.be/abc', workspaceId: 'w1');
      await facade.startLink(
        url: 'https://drive.google.com/file/d/x/view',
        workspaceId: 'w1',
      );

      verify(
        () => repository.startLink(
          url: 'https://youtu.be/abc',
          workspaceId: 'w1',
          youtube: true,
        ),
      ).called(1);
      verify(
        () => repository.startLink(
          url: 'https://drive.google.com/file/d/x/view',
          workspaceId: 'w1',
          youtube: false,
        ),
      ).called(1);
    },
  );

  test('a failed start keeps the stored file for a start-only retry', () async {
    stubPut();
    when(
      () => jobs.createJob(
        mediaId: any(named: 'mediaId'),
        numSpeakers: any(named: 'numSpeakers'),
      ),
    ).thenAnswer((_) async => const Left(Failure.server(statusCode: 402)));

    final result = await facade.upload(
      file: file,
      workspaceId: 'w1',
      title: '',
      startTranscription: true,
    );

    final done = result.getOrElse(() => throw StateError('left'));
    expect(done.mediaId, 'm1');
    expect(done.job, isNull);
    expect(done.startFailure, const Failure.server(statusCode: 402));
  });

  test(
    'a sent recording is deleted from the phone, a picked file is not',
    () async {
      stubPut();
      final dir = await Directory.systemTemp.createTemp('tr_rec');
      addTearDown(() => dir.delete(recursive: true));
      final recorded = File('${dir.path}/rec.m4a')..writeAsBytesSync([1, 2]);
      final picked = File('${dir.path}/own.m4a')..writeAsBytesSync([1, 2]);

      for (final (f, source) in [
        (recorded, UploadSource.recording),
        (picked, UploadSource.upload),
      ]) {
        await facade.upload(
          file: PendingFile(
            path: f.path,
            fileName: 'a.m4a',
            sizeBytes: 2,
            source: source,
          ),
          workspaceId: 'w1',
          title: '',
          startTranscription: false,
        );
      }

      expect(recorded.existsSync(), isFalse);
      expect(picked.existsSync(), isTrue);
    },
  );
}
