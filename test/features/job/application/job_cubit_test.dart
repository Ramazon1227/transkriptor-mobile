import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/application/job_cubit.dart';
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/i_job_facade.dart';
import 'package:transkriptor_uz/features/job/infrastructure/models/job_model.dart';

class _MockJobFacade extends Mock implements IJobFacade;

void main() {
  late _MockJobFacade facade;
  late LibraryChanges changes;
  final fast = JobPollPolicy.custom(
    first: const Duration(milliseconds: 1),
    max: const Duration(milliseconds: 4),
  );

  Job job(JobStatus status, {int progress = 0, String id = 'j1'}) => Job(
    id: id,
    mediaId: 'm1',
    status: status,
    progress: progress,
    transcriptId: status == JobStatus.succeeded ? 't1' : null,
  );

  /// Answers getJob with [answers] in order, then repeats the last one.
  void answer(List<Either<Failure, Job>> answers) {
    var i = 0;
    when(() => facade.getJob(any())).thenAnswer((_) async {
      final a = answers[i < answers.length ? i : answers.length - 1];
      i++;
      return a;
    });
  }

  setUp(() {
    facade = _MockJobFacade();
    changes = LibraryChanges();
  });

  tearDown(() => changes.dispose());

  group('JobCubit', () {
    blocTest<JobCubit, JobState>(
      'polls until the job succeeds, then stops and announces it',
      setUp: () => answer([
        Right(job(JobStatus.queued)),
        Right(job(JobStatus.running, progress: 40)),
        Right(job(JobStatus.succeeded, progress: 100)),
      ]),
      build: () => JobCubit(facade, fast, changes),
      act: (cubit) => cubit.watch('j1'),
      wait: const Duration(milliseconds: 60),
      expect: () => [
        const JobState(status: JobViewStatus.loading, jobId: 'j1'),
        JobState(
          status: JobViewStatus.success,
          jobId: 'j1',
          job: job(JobStatus.queued),
        ),
        JobState(
          status: JobViewStatus.success,
          jobId: 'j1',
          job: job(JobStatus.running, progress: 40),
        ),
        JobState(
          status: JobViewStatus.success,
          jobId: 'j1',
          job: job(JobStatus.succeeded, progress: 100),
        ),
      ],
      verify: (_) => verify(() => facade.getJob('j1')).called(3),
    );

    test('announces a finish it watched, not one it found finished', () async {
      final notified = <void>[];
      final sub = changes.stream.listen(notified.add);
      addTearDown(sub.cancel);

      answer([Right(job(JobStatus.succeeded, progress: 100))]);
      final cubit = JobCubit(facade, fast, changes)..watch('j1');
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(notified, isEmpty);
      await cubit.close();

      answer([
        Right(job(JobStatus.running, progress: 10)),
        Right(job(JobStatus.failed)),
      ]);
      final watching = JobCubit(facade, fast, changes)..watch('j1');
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(notified, hasLength(1));
      await watching.close();
    });

    blocTest<JobCubit, JobState>(
      'stops on a failed poll; refresh starts again',
      setUp: () => answer([
        const Left(Failure.network()),
        Right(job(JobStatus.succeeded, progress: 100)),
      ]),
      build: () => JobCubit(facade, fast, changes),
      act: (cubit) async {
        cubit.watch('j1');
        await Future<void>.delayed(const Duration(milliseconds: 20));
        cubit.refresh();
      },
      wait: const Duration(milliseconds: 30),
      expect: () => [
        const JobState(status: JobViewStatus.loading, jobId: 'j1'),
        const JobState(
          status: JobViewStatus.failure,
          jobId: 'j1',
          failure: Failure.network(),
        ),
        const JobState(status: JobViewStatus.loading, jobId: 'j1'),
        JobState(
          status: JobViewStatus.success,
          jobId: 'j1',
          job: job(JobStatus.succeeded, progress: 100),
        ),
      ],
    );

    test('a dropped connection mid-job keeps polling', () async {
      answer([
        Right(job(JobStatus.running, progress: 10)),
        const Left(Failure.network()),
        Right(job(JobStatus.succeeded, progress: 100)),
      ]);
      final cubit = JobCubit(facade, fast, changes)..watch('j1');
      await Future<void>.delayed(const Duration(milliseconds: 40));

      expect(cubit.state.status, JobViewStatus.success);
      expect(cubit.state.job?.status, JobStatus.succeeded);
      expect(cubit.state.failure, isNull);
      await cubit.close();
    });

    test('an answer for an older job never overwrites the newer one', () async {
      final slow = Completer<Either<Failure, Job>>();
      when(() => facade.getJob('old')).thenAnswer((_) => slow.future);
      when(() => facade.getJob('new')).thenAnswer(
        (_) async => Right(job(JobStatus.succeeded, id: 'new', progress: 100)),
      );

      final cubit = JobCubit(facade, fast, changes)
        ..watch('old')
        ..watch('new');
      await Future<void>.delayed(const Duration(milliseconds: 10));
      slow.complete(Right(job(JobStatus.running, id: 'old', progress: 5)));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.job?.id, 'new');
      await cubit.close();
    });

    blocTest<JobCubit, JobState>(
      'retry starts the same file again and follows the new job',
      setUp: () {
        when(() => facade.createJob(mediaId: 'm1'))
            .thenAnswer((_) async => Right(job(JobStatus.queued, id: 'j2')));
        when(() => facade.getJob('j2'))
            .thenAnswer((_) async => Right(job(JobStatus.queued, id: 'j2')));
      },
      build: () => JobCubit(facade, fast, changes),
      seed: () => JobState(
        status: JobViewStatus.success,
        jobId: 'j1',
        job: job(JobStatus.failed),
      ),
      act: (cubit) => cubit.retry(),
      wait: const Duration(milliseconds: 10),
      verify: (cubit) {
        verify(() => facade.createJob(mediaId: 'm1')).called(1);
        expect(cubit.state.jobId, 'j2');
      },
    );
  });

  group('JobPollPolicy', () {
    test('slows while nothing changes and resets on a change', () {
      final p = JobPollPolicy.custom(
        first: const Duration(seconds: 2),
        max: const Duration(seconds: 5),
      );
      var d = p.first;
      d = p.next(d, changed: false);
      expect(d, const Duration(seconds: 3));
      d = p.next(d, changed: false);
      expect(d, const Duration(milliseconds: 4500));
      d = p.next(d, changed: false);
      expect(d, const Duration(seconds: 5));
      expect(p.next(d, changed: true), const Duration(seconds: 2));
    });
  });

  test('JobModel clamps progress and reads an unknown status', () {
    final job = JobModel.fromJson(const {
      'id': 'j',
      'status': 'PAUSED',
      'progress': 140,
      'error_message': '',
      'transcript_id': '',
    }).toEntity();
    expect(job.status, JobStatus.unknown);
    expect(job.progress, 100);
    expect(job.errorMessage, isNull);
    expect(job.transcriptId, isNull);
    expect(JobStatus.cancelled.isTerminal, isTrue);
    expect(JobStatus.running.isTerminal, isFalse);
  });
}
