import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
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
              numSpeakers: any(named: 'numSpeakers'),
              onProgress: any(named: 'onProgress'),
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
          numSpeakers: any(named: 'numSpeakers'),
          onProgress: any(named: 'onProgress'),
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
            numSpeakers: any(named: 'numSpeakers'),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer(
          (_) async => const Right(
            UploadResult(
              mediaId: 'm1',
              startFailure: Failure.server(statusCode: 402),
            ),
          ),
        );
        when(() => facade.startTranscription(mediaId: 'm1', numSpeakers: 2))
            .thenAnswer((_) async => const Right(job));
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
          numSpeakers: any(named: 'numSpeakers'),
          onProgress: any(named: 'onProgress'),
        ),
      ).called(1),
    );
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
}
