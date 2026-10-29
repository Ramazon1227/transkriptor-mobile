import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';
import 'package:transkriptor_uz/features/transcript/application/retranscribe_cubit.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/repositories/transcript_repository.dart';

import '../../../helpers/fake_http_adapter.dart';

class _MockTranscriptFacade extends Mock implements ITranscriptFacade;

class _MockJobFacade extends Mock implements IJobFacade;

const _a = Segment(
  id: 'g1',
  start: Duration.zero,
  end: Duration(seconds: 2),
  text: 'Salom',
);
const _b = Segment(
  id: 'g2',
  start: Duration(seconds: 2),
  end: Duration(seconds: 4),
  text: 'Xayr',
);
const _t = Transcript(
  id: 't1',
  title: 'Kengash',
  mediaId: 'm1',
  segments: [_a, _b],
  revision: 4,
);

void main() {
  late _MockTranscriptFacade facade;
  setUp(() {
    facade = _MockTranscriptFacade();
    when(() => facade.getTranscript('t1'))
        .thenAnswer((_) async => const Right(_t));
  });

  group('TranscriptRepository', () {
    test(
      'reads media_id; rename and delete send what the server takes',
      () async {
        final http = FakeHttpAdapter({
          'GET /api/v1/transcript/t1': (
            200,
            ok({'id': 't1', 'title': 'K', 'media_id': 'm1', 'revision': 1}),
          ),
          'PATCH /api/v1/transcript/t1': (
            200,
            ok({
              'id': 't1',
              'title': 'Yangi',
              'status': 'EDITED',
              'revision': 2,
            }),
          ),
          'DELETE /api/v1/transcript/t1/segments/g1': (
            200,
            ok({'deleted': true, 'revision': 3}),
          ),
        });
        final repo = TranscriptRepository(fakeDio(http));
        final t = (await repo.getTranscript('t1'))
            .getOrElse(() => throw StateError(''))
            .toEntity();
        expect(t.mediaId, 'm1');

        final meta = (await repo.renameTranscript(
          transcriptId: 't1',
          title: 'Yangi',
          revision: 1,
        )).getOrElse(() => throw StateError(''));
        expect(
          meta.toEntity(),
          const TranscriptMeta(title: 'Yangi', revision: 2),
        );
        expect(http.sent.last.body, {'title': 'Yangi', 'revision': 1});

        final deleted = (await repo.deleteSegment(
          transcriptId: 't1',
          segmentId: 'g1',
          revision: 2,
        )).getOrElse(() => throw StateError(''));
        expect(deleted.revision, 3);
        // In the query: many clients drop a DELETE body.
        expect(http.sent.last.options.queryParameters, {'revision': 2});
      },
    );
  });

  group('TranscriptCubit editor additions', () {
    blocTest<TranscriptCubit, TranscriptState>(
      'renames the title against the revision on screen',
      setUp: () =>
          when(
            () => facade.renameTranscript(
              transcriptId: 't1',
              title: 'Yangi nom',
              revision: 4,
            ),
          ).thenAnswer(
            (_) async =>
                const Right(TranscriptMeta(title: 'Yangi nom', revision: 5)),
          ),
      build: () => TranscriptCubit(facade),
      act: (c) async {
        await c.load('t1');
        await c.renameTitle('  Yangi   nom ');
      },
      verify: (c) {
        expect(c.state.transcript!.title, 'Yangi nom');
        expect(c.state.transcript!.revision, 5);
        expect(c.state.editStatus, EditStatus.saved);
      },
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'an unchanged or blank title sends nothing',
      build: () => TranscriptCubit(facade),
      act: (c) async {
        await c.load('t1');
        await c.renameTitle('Kengash');
        await c.renameTitle('   ');
      },
      verify: (_) => verifyNever(
        () => facade.renameTranscript(
          transcriptId: any(named: 'transcriptId'),
          title: any(named: 'title'),
          revision: any(named: 'revision'),
        ),
      ),
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a stale rename refetches and keeps the failure',
      setUp: () => when(
        () => facade.renameTranscript(
          transcriptId: any(named: 'transcriptId'),
          title: any(named: 'title'),
          revision: any(named: 'revision'),
        ),
      ).thenAnswer((_) async => const Left(Failure.server(statusCode: 409))),
      build: () => TranscriptCubit(facade),
      act: (c) async {
        await c.load('t1');
        await c.renameTitle('Boshqa');
      },
      verify: (c) {
        expect(c.state.editStatus, EditStatus.failure);
        verify(() => facade.getTranscript('t1')).called(2);
      },
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'deletes a segment once the server says so',
      setUp: () => when(
        () => facade.deleteSegment(
          transcriptId: 't1',
          segmentId: 'g1',
          revision: 4,
        ),
      ).thenAnswer((_) async => const Right(5)),
      build: () => TranscriptCubit(facade),
      act: (c) async {
        await c.load('t1');
        await c.deleteSegment('g1');
      },
      verify: (c) {
        expect(c.state.transcript!.segments, [_b]);
        expect(c.state.transcript!.revision, 5);
      },
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'view switches: speakers and edit mode',
      build: () => TranscriptCubit(facade),
      act: (c) {
        c
          ..setShowSpeakers(value: false)
          ..setEditMode(value: true);
      },
      expect: () => [
        const TranscriptState(showSpeakers: false),
        const TranscriptState(showSpeakers: false, editMode: true),
      ],
    );
  });

  group('RetranscribeCubit', () {
    late _MockJobFacade jobs;
    setUp(() => jobs = _MockJobFacade());

    blocTest<RetranscribeCubit, RetranscribeState>(
      'starts a job for the media and hands back its id',
      setUp: () => when(() => jobs.createJob(mediaId: 'm1')).thenAnswer(
        (_) async =>
            const Right(Job(id: 'j9', status: JobStatus.queued, mediaId: 'm1')),
      ),
      build: () => RetranscribeCubit(jobs),
      act: (c) async {
        await c.start('m1');
        // A second confirm after the start sends nothing.
        await c.start('m1');
      },
      expect: () => [
        const RetranscribeState(status: RetranscribeStatus.busy),
        const RetranscribeState(
          status: RetranscribeStatus.started,
          jobId: 'j9',
        ),
      ],
      verify: (_) => verify(() => jobs.createJob(mediaId: 'm1')).called(1),
    );

    blocTest<RetranscribeCubit, RetranscribeState>(
      'no balance is a failure the sheet shows',
      setUp: () => when(() => jobs.createJob(mediaId: 'm1'))
          .thenAnswer((_) async => const Left(Failure.server(statusCode: 402))),
      build: () => RetranscribeCubit(jobs),
      act: (c) => c.start('m1'),
      expect: () => [
        const RetranscribeState(status: RetranscribeStatus.busy),
        const RetranscribeState(
          status: RetranscribeStatus.failure,
          failure: Failure.server(statusCode: 402),
        ),
      ],
    );
  });
}
