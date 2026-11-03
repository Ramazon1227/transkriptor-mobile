import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/upload_cancel.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

class _MockUploadFacade extends Mock implements IUploadFacade;

class _FakePendingFile extends Fake implements PendingFile;

void main() {
  late _MockUploadFacade facade;

  const file = PendingFile(
    path: '/f.m4a',
    fileName: 'f.m4a',
    sizeBytes: 100,
    source: UploadSource.upload,
  );
  const job = Job(id: 'j1', mediaId: 'm1', status: JobStatus.queued);

  setUpAll(() => registerFallbackValue(_FakePendingFile()));
  setUp(() => facade = _MockUploadFacade());

  group('UploadBloc file', () {
    blocTest<UploadBloc, UploadState>(
      'reports progress per percent and ends with the job',
      setUp: () =>
          when(
            () => facade.upload(
              file: any(named: 'file'),
              workspaceId: any(named: 'workspaceId'),
              title: any(named: 'title'),
              startTranscription: any(named: 'startTranscription'),
              jobKey: any(named: 'jobKey'),
              numSpeakers: any(named: 'numSpeakers'),
              onProgress: any(named: 'onProgress'),
              cancel: any(named: 'cancel'),
            ),
          ).thenAnswer((invocation) async {
            final onProgress =
                invocation.namedArguments[#onProgress] as void Function(double);
            // 0.501 is under a percent from 0.5: dropped.
            [0.5, 0.501, 1.0].forEach(onProgress);
            return const Right(UploadResult(mediaId: 'm1', job: job));
          }),
      build: () => UploadBloc(facade),
      act: (bloc) => bloc.add(
        const UploadFileSubmitted(
          file: file,
          workspaceId: 'w1',
          title: 'f',
          startTranscription: true,
        ),
      ),
      expect: () => const [
        UploadState(status: UploadStatus.uploading),
        UploadState(status: UploadStatus.uploading, progress: 0.5),
        UploadState(status: UploadStatus.uploading, progress: 1),
        UploadState(
          status: UploadStatus.success,
          progress: 1,
          mediaId: 'm1',
          job: job,
        ),
      ],
    );

    blocTest<UploadBloc, UploadState>(
      'emits the failure',
      setUp: () => when(
        () => facade.upload(
          file: any(named: 'file'),
          workspaceId: any(named: 'workspaceId'),
          title: any(named: 'title'),
          startTranscription: any(named: 'startTranscription'),
          jobKey: any(named: 'jobKey'),
          numSpeakers: any(named: 'numSpeakers'),
          onProgress: any(named: 'onProgress'),
          cancel: any(named: 'cancel'),
        ),
      ).thenAnswer((_) async => const Left(Failure.server(statusCode: 402))),
      build: () => UploadBloc(facade),
      act: (bloc) => bloc.add(
        const UploadFileSubmitted(
          file: file,
          workspaceId: 'w1',
          title: 'f',
          startTranscription: true,
        ),
      ),
      expect: () => const [
        UploadState(status: UploadStatus.uploading),
        UploadState(
          status: UploadStatus.failure,
          failure: Failure.server(statusCode: 402),
        ),
      ],
    );
  });

  group('UploadBloc stored', () {
    blocTest<UploadBloc, UploadState>(
      'a failed start is "stored", and retry starts the job only',
      setUp: () {
        when(
          () => facade.upload(
            file: any(named: 'file'),
            workspaceId: any(named: 'workspaceId'),
            title: any(named: 'title'),
            startTranscription: any(named: 'startTranscription'),
            jobKey: any(named: 'jobKey'),
            numSpeakers: any(named: 'numSpeakers'),
            onProgress: any(named: 'onProgress'),
            cancel: any(named: 'cancel'),
          ),
        ).thenAnswer(
          (_) async => const Right(
            UploadResult(
              mediaId: 'm1',
              startFailure: Failure.server(statusCode: 402),
            ),
          ),
        );
        when(
          () => facade.startTranscription(
            mediaId: 'm1',
            idempotencyKey: any(named: 'idempotencyKey'),
            numSpeakers: 2,
          ),
        ).thenAnswer((_) async => const Right(job));
      },
      build: () => UploadBloc(facade),
      act: (bloc) async {
        bloc.add(
          const UploadFileSubmitted(
            file: file,
            workspaceId: 'w1',
            title: 'f',
            startTranscription: true,
          ),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(const UploadStartRetried(mediaId: 'm1', numSpeakers: 2));
      },
      expect: () => const [
        UploadState(status: UploadStatus.uploading),
        UploadState(
          status: UploadStatus.stored,
          progress: 1,
          mediaId: 'm1',
          failure: Failure.server(statusCode: 402),
        ),
        UploadState(status: UploadStatus.starting, progress: 1, mediaId: 'm1'),
        UploadState(
          status: UploadStatus.success,
          progress: 1,
          mediaId: 'm1',
          job: job,
        ),
      ],
      verify: (_) => verify(
        () => facade.upload(
          file: any(named: 'file'),
          workspaceId: any(named: 'workspaceId'),
          title: any(named: 'title'),
          startTranscription: any(named: 'startTranscription'),
          jobKey: any(named: 'jobKey'),
          numSpeakers: any(named: 'numSpeakers'),
          onProgress: any(named: 'onProgress'),
          cancel: any(named: 'cancel'),
        ),
      ).called(1),
    );

    test('a start whose answer was lost is retried with the same key; a '
        'refused one with a new key', () async {
      String? uploadKey;
      when(
        () => facade.upload(
          file: any(named: 'file'),
          workspaceId: any(named: 'workspaceId'),
          title: any(named: 'title'),
          startTranscription: any(named: 'startTranscription'),
          jobKey: any(named: 'jobKey'),
          numSpeakers: any(named: 'numSpeakers'),
          onProgress: any(named: 'onProgress'),
          cancel: any(named: 'cancel'),
        ),
      ).thenAnswer((inv) async {
        uploadKey = inv.namedArguments[#jobKey] as String;
        return const Right(
          UploadResult(mediaId: 'm1', startFailure: Failure.timeout()),
        );
      });
      final keys = <String>[];
      final answers = [
        const Left<Failure, Job>(Failure.jobActive()),
        const Right<Failure, Job>(job),
      ];
      when(
        () => facade.startTranscription(
          mediaId: 'm1',
          idempotencyKey: any(named: 'idempotencyKey'),
          numSpeakers: any(named: 'numSpeakers'),
        ),
      ).thenAnswer((inv) async {
        keys.add(inv.namedArguments[#idempotencyKey] as String);
        return answers.removeAt(0);
      });
      final bloc = UploadBloc(facade)
        ..add(
          const UploadFileSubmitted(
            file: file,
            workspaceId: 'w1',
            title: 'f',
            startTranscription: true,
          ),
        );
      await Future<void>.delayed(Duration.zero);
      bloc.add(const UploadStartRetried(mediaId: 'm1'));
      await Future<void>.delayed(Duration.zero);
      expect(bloc.state.failure, const Failure.jobActive());
      bloc.add(const UploadStartRetried(mediaId: 'm1'));
      await Future<void>.delayed(Duration.zero);

      expect(keys, hasLength(2));
      expect(keys[0], uploadKey);
      expect(keys[1], isNot(keys[0]));
      expect(bloc.state.status, UploadStatus.success);
      await bloc.close();
    });
  });

  group('UploadBloc link', () {
    blocTest<UploadBloc, UploadState>(
      'rejects a link the backend cannot fetch, without a request',
      build: () => UploadBloc(facade),
      act: (bloc) => bloc.add(
        const UploadLinkSubmitted(
          url: 'https://vimeo.com/1',
          workspaceId: 'w1',
        ),
      ),
      expect: () => const [UploadState(linkInvalid: true)],
      verify: (_) => verifyNever(
        () => facade.startLink(
          url: any(named: 'url'),
          workspaceId: any(named: 'workspaceId'),
          idempotencyKey: any(named: 'idempotencyKey'),
          numSpeakers: any(named: 'numSpeakers'),
        ),
      ),
    );

    blocTest<UploadBloc, UploadState>(
      'starts a YouTube link',
      setUp: () => when(
        () => facade.startLink(
          url: 'https://youtu.be/abc',
          workspaceId: 'w1',
          idempotencyKey: any(named: 'idempotencyKey'),
          numSpeakers: 3,
        ),
      ).thenAnswer((_) async => const Right(job)),
      build: () => UploadBloc(facade),
      act: (bloc) => bloc.add(
        const UploadLinkSubmitted(
          url: ' https://youtu.be/abc ',
          workspaceId: 'w1',
          numSpeakers: 3,
        ),
      ),
      expect: () => const [
        UploadState(status: UploadStatus.uploading),
        UploadState(status: UploadStatus.success, mediaId: 'm1', job: job),
      ],
    );
  });

  test('isSupportedLink knows the three hosts', () {
    expect(isSupportedLink('https://www.youtube.com/watch?v=x'), isTrue);
    expect(isSupportedLink('https://m.youtube.com/shorts/x'), isTrue);
    expect(isSupportedLink('https://youtu.be/x'), isTrue);
    expect(isSupportedLink('https://drive.google.com/file/d/x/view'), isTrue);
    expect(isSupportedLink('https://www.dropbox.com/s/k/a.mp3'), isTrue);
    expect(isSupportedLink('https://notyoutube.co/x'), isFalse);
    expect(isSupportedLink('ftp://youtu.be/x'), isFalse);
    expect(isSupportedLink('youtube'), isFalse);
  });

  test('PendingFile splits name and extension', () {
    expect(file.extension, '.m4a');
    expect(file.baseName, 'f');
    const noExt = PendingFile(
      path: '/x',
      fileName: 'yozuv',
      sizeBytes: 1,
      source: UploadSource.upload,
    );
    expect(noExt.extension, '');
    expect(noExt.baseName, 'yozuv');
  });

  group('UploadBloc cancel', () {
    void holdUpload() =>
        when(
          () => facade.upload(
            file: any(named: 'file'),
            workspaceId: any(named: 'workspaceId'),
            title: any(named: 'title'),
            startTranscription: any(named: 'startTranscription'),
            jobKey: any(named: 'jobKey'),
            numSpeakers: any(named: 'numSpeakers'),
            onProgress: any(named: 'onProgress'),
            cancel: any(named: 'cancel'),
          ),
        ).thenAnswer((call) {
          final cancel = call.namedArguments[#cancel] as UploadCancel?;
          final done = Completer<Either<Failure, UploadResult>>();
          cancel!.onCancel(
            () => done.complete(const Left(Failure.cancelled())),
          );
          return done.future;
        });

    blocTest<UploadBloc, UploadState>(
      'a cancel is not dropped while the upload runs; the form comes back',
      setUp: holdUpload,
      build: () => UploadBloc(facade),
      act: (bloc) async {
        bloc.add(
          const UploadFileSubmitted(
            file: file,
            workspaceId: 'w1',
            title: 'f',
            startTranscription: true,
          ),
        );
        await pumpEventQueue();
        bloc.add(const UploadCancelRequested());
      },
      expect: () => const [
        UploadState(status: UploadStatus.uploading),
        UploadState(),
      ],
    );

    test('closing the bloc cancels the upload', () async {
      UploadCancel? seen;
      when(
        () => facade.upload(
          file: any(named: 'file'),
          workspaceId: any(named: 'workspaceId'),
          title: any(named: 'title'),
          startTranscription: any(named: 'startTranscription'),
          jobKey: any(named: 'jobKey'),
          numSpeakers: any(named: 'numSpeakers'),
          onProgress: any(named: 'onProgress'),
          cancel: any(named: 'cancel'),
        ),
      ).thenAnswer((call) {
        seen = call.namedArguments[#cancel] as UploadCancel?;
        return Completer<Either<Failure, UploadResult>>().future;
      });
      final bloc = UploadBloc(facade)
        ..add(
          const UploadFileSubmitted(
            file: file,
            workspaceId: 'w1',
            title: 'f',
            startTranscription: true,
          ),
        );
      await pumpEventQueue();
      expect(seen!.isCancelled, isFalse);
      unawaited(bloc.close());
      expect(seen!.isCancelled, isTrue);
    });
  });

  blocTest<UploadBloc, UploadState>(
    'once the job request is on its way it shows starting and a cancel '
    'changes nothing',
    setUp: () =>
        when(
          () => facade.upload(
            file: any(named: 'file'),
            workspaceId: any(named: 'workspaceId'),
            title: any(named: 'title'),
            startTranscription: any(named: 'startTranscription'),
            jobKey: any(named: 'jobKey'),
            numSpeakers: any(named: 'numSpeakers'),
            onProgress: any(named: 'onProgress'),
            cancel: any(named: 'cancel'),
          ),
        ).thenAnswer((call) async {
          (call.namedArguments[#cancel] as UploadCancel?)!.seal();
          await pumpEventQueue();
          return const Right(UploadResult(mediaId: 'm1', job: job));
        }),
    build: () => UploadBloc(facade),
    act: (bloc) async {
      bloc.add(
        const UploadFileSubmitted(
          file: file,
          workspaceId: 'w1',
          title: 'f',
          startTranscription: true,
        ),
      );
      await Future<void>.delayed(Duration.zero);
      bloc.add(const UploadCancelRequested());
      await pumpEventQueue();
    },
    expect: () => const [
      UploadState(status: UploadStatus.uploading),
      UploadState(status: UploadStatus.starting, progress: 1),
      UploadState(
        status: UploadStatus.success,
        progress: 1,
        mediaId: 'm1',
        job: job,
      ),
    ],
  );
}
