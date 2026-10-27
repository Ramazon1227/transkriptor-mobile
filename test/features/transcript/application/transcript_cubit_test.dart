import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/edit_rules.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/models/transcript_model.dart';

class _MockTranscriptFacade extends Mock implements ITranscriptFacade;

void main() {
  late _MockTranscriptFacade facade;

  const transcript = Transcript(
    id: 't1',
    title: 'Kengash yigʻilishi',
    speakers: [
      Speaker(id: 's1', label: 'Dilnoza R.', ordinal: 1),
      Speaker(id: 's2', label: 'Sardor T.', ordinal: 2),
    ],
    segments: [
      Segment(
        id: 'g1',
        start: Duration(seconds: 7),
        end: Duration(seconds: 12),
        text: 'Kelishuv shartlarini ertaga kengashda muhokama qilamiz.',
        speakerId: 's1',
      ),
      Segment(
        id: 'g2',
        start: Duration(seconds: 12),
        end: Duration(seconds: 19),
        text: 'Soat oʻnda boshlaymizmi?',
        speakerId: 's2',
      ),
    ],
  );

  setUp(() => facade = _MockTranscriptFacade());

  group('TranscriptCubit', () {
    blocTest<TranscriptCubit, TranscriptState>(
      'loads the transcript',
      setUp: () =>
          when(() => facade.getTranscript('t1'))
              .thenAnswer((_) async => const Right(transcript)),
      build: () => TranscriptCubit(facade),
      act: (cubit) => cubit.load('t1'),
      expect: () => const [
        TranscriptState(status: TranscriptStatus.loading),
        TranscriptState(
          status: TranscriptStatus.success,
          transcript: transcript,
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'no segments is empty, not failure',
      setUp: () => when(() => facade.getTranscript('t1')).thenAnswer(
        (_) async => const Right(Transcript(id: 't1', title: 'Boʻsh')),
      ),
      build: () => TranscriptCubit(facade),
      act: (cubit) => cubit.load('t1'),
      skip: 1,
      expect: () => const [
        TranscriptState(
          status: TranscriptStatus.empty,
          transcript: Transcript(id: 't1', title: 'Boʻsh'),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'emits the failure',
      setUp: () =>
          when(() => facade.getTranscript('t1'))
              .thenAnswer((_) async => const Left(Failure.network())),
      build: () => TranscriptCubit(facade),
      act: (cubit) => cubit.load('t1'),
      skip: 1,
      expect: () => const [
        TranscriptState(
          status: TranscriptStatus.failure,
          failure: Failure.network(),
        ),
      ],
    );
  });

  group('editing', () {
    const loaded = TranscriptState(
      status: TranscriptStatus.success,
      transcript: Transcript(
        id: 't1',
        title: 'Kengash yigʻilishi',
        speakers: [Speaker(id: 's1', label: 'Maʼruzachi 1', ordinal: 1)],
        segments: [
          Segment(
            id: 'g1',
            start: Duration(seconds: 7),
            end: Duration(seconds: 12),
            text: 'eski matn',
            speakerId: 's1',
          ),
        ],
        revision: 3,
      ),
    );
    const stored = Segment(
      id: 'g1',
      start: Duration(seconds: 7),
      end: Duration(seconds: 12),
      text: 'Yangi matn.',
      speakerId: 's1',
      edited: true,
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a text save replaces the row with the stored one and the revision',
      setUp: () =>
          when(
            () => facade.updateSegmentText(
              transcriptId: 't1',
              segmentId: 'g1',
              text: 'Yangi matn.',
              revision: 3,
            ),
          ).thenAnswer(
            (_) async => const Right(SegmentEdit(segment: stored, revision: 4)),
          ),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      // Whitespace is collapsed before sending, as the server does.
      act: (cubit) => cubit.saveSegmentText('g1', '  Yangi \n matn. '),
      expect: () => [
        loaded.copyWith(editStatus: EditStatus.saving),
        loaded.copyWith(
          editStatus: EditStatus.saved,
          transcript: loaded.transcript!.copyWith(
            revision: 4,
            segments: const [stored],
          ),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'an unchanged text sends nothing',
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.saveSegmentText('g1', 'eski  matn'),
      expect: () => [loaded.copyWith(editStatus: EditStatus.saved)],
      verify: (_) => verifyNever(
        () => facade.updateSegmentText(
          transcriptId: any(named: 'transcriptId'),
          segmentId: any(named: 'segmentId'),
          text: any(named: 'text'),
          revision: any(named: 'revision'),
        ),
      ),
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a 409 fetches the fresh copy and shows the failure',
      setUp: () {
        when(
          () => facade.updateSegmentText(
            transcriptId: 't1',
            segmentId: 'g1',
            text: 'mening matnim',
            revision: 3,
          ),
        ).thenAnswer((_) async => const Left(Failure.server(statusCode: 409)));
        when(() => facade.getTranscript('t1')).thenAnswer(
          (_) async => Right(
            loaded.transcript!.copyWith(revision: 5, segments: const [stored]),
          ),
        );
      },
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.saveSegmentText('g1', 'mening matnim'),
      skip: 1,
      expect: () {
        final fresh = loaded.transcript!.copyWith(
          revision: 5,
          segments: const [stored],
        );
        return [
          loaded.copyWith(editStatus: EditStatus.saving, transcript: fresh),
          loaded.copyWith(
            editStatus: EditStatus.failure,
            editFailure: const Failure.server(statusCode: 409),
            transcript: fresh,
          ),
        ];
      },
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'any other failure keeps the transcript and does not refetch',
      setUp: () => when(
        () => facade.updateSegmentText(
          transcriptId: any(named: 'transcriptId'),
          segmentId: any(named: 'segmentId'),
          text: any(named: 'text'),
          revision: any(named: 'revision'),
        ),
      ).thenAnswer((_) async => const Left(Failure.network())),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.saveSegmentText('g1', 'boshqa'),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.failure,
          editFailure: const Failure.network(),
        ),
      ],
      verify: (_) => verifyNever(() => facade.getTranscript(any())),
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a rename replaces the speaker and leaves the revision alone',
      setUp: () =>
          when(
            () => facade.renameSpeaker(
              transcriptId: 't1',
              speakerId: 's1',
              label: 'Dilnoza R.',
            ),
          ).thenAnswer(
            (_) async =>
                const Right(Speaker(id: 's1', label: 'Dilnoza R.', ordinal: 1)),
          ),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.renameSpeaker('s1', ' Dilnoza  R. '),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.saved,
          transcript: loaded.transcript!.copyWith(
            speakers: const [
              Speaker(id: 's1', label: 'Dilnoza R.', ordinal: 1),
            ],
          ),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'an empty name sends nothing',
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.renameSpeaker('s1', '   '),
      expect: () => const <TranscriptState>[],
    );

    test('closing the editor mid-save keeps saving, so no second save '
        'goes out against the same revision', () async {
      final answer = Completer<Either<Failure, SegmentEdit>>();
      when(
        () => facade.updateSegmentText(
          transcriptId: any(named: 'transcriptId'),
          segmentId: any(named: 'segmentId'),
          text: any(named: 'text'),
          revision: any(named: 'revision'),
        ),
      ).thenAnswer((_) => answer.future);
      final cubit = TranscriptCubit(facade)..emit(loaded);
      addTearDown(cubit.close);

      final first = cubit.saveSegmentText('g1', 'birinchi');
      cubit
        ..editClosed()
        ..editOpened();
      expect(cubit.state.editStatus, EditStatus.saving);
      await cubit.saveSegmentText('g1', 'ikkinchi');

      answer.complete(const Right(SegmentEdit(segment: stored, revision: 4)));
      await first;
      verify(
        () => facade.updateSegmentText(
          transcriptId: any(named: 'transcriptId'),
          segmentId: any(named: 'segmentId'),
          text: any(named: 'text'),
          revision: any(named: 'revision'),
        ),
      ).called(1);
    });

    blocTest<TranscriptCubit, TranscriptState>(
      'a segment that is gone answers 404 instead of doing nothing',
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.saveSegmentText('yoq', 'matn'),
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.failure,
          editFailure: const Failure.server(statusCode: 404),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'opening an editor clears what the last one left',
      build: () => TranscriptCubit(facade),
      seed: () => loaded.copyWith(editStatus: EditStatus.saved),
      act: (cubit) => cubit.editOpened(),
      expect: () => [loaded],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'closing the editor resets the save state',
      build: () => TranscriptCubit(facade),
      seed: () => loaded.copyWith(
        editStatus: EditStatus.failure,
        editFailure: const Failure.network(),
      ),
      act: (cubit) => cubit.editClosed(),
      expect: () => [loaded],
    );
  });

  group('speaker assignment', () {
    const seg = Segment(
      id: 'g1',
      start: Duration(seconds: 7),
      end: Duration(seconds: 12),
      text: 'matn',
      speakerId: 's1',
    );
    const loaded = TranscriptState(
      status: TranscriptStatus.success,
      transcript: Transcript(
        id: 't1',
        title: 'Kengash',
        speakers: [
          Speaker(id: 's1', label: 'Maʼruzachi 1', ordinal: 1),
          Speaker(id: 's2', label: 'Maʼruzachi 2', ordinal: 2),
        ],
        segments: [seg],
        revision: 3,
      ),
    );

    void answer(String? speakerId, Either<Failure, SegmentEdit> result) => when(
      () => facade.assignSpeaker(
        transcriptId: 't1',
        segmentId: 'g1',
        speakerId: speakerId,
        revision: 3,
      ),
    ).thenAnswer((_) async => result);

    blocTest<TranscriptCubit, TranscriptState>(
      'moves the segment to an existing speaker with the new revision',
      setUp: () => answer(
        's2',
        Right(SegmentEdit(segment: seg.copyWith(speakerId: 's2'), revision: 4)),
      ),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.assignSpeaker('g1', 's2'),
      expect: () => [
        loaded.copyWith(editStatus: EditStatus.saving),
        loaded.copyWith(
          editStatus: EditStatus.saved,
          transcript: loaded.transcript!.copyWith(
            revision: 4,
            segments: [seg.copyWith(speakerId: 's2')],
          ),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a new speaker comes back from the server and joins the list',
      setUp: () => answer(
        null,
        Right(
          SegmentEdit(
            segment: seg.copyWith(speakerId: 's3'),
            revision: 4,
            newSpeaker: const Speaker(
              id: 's3',
              label: 'Maʼruzachi 3',
              ordinal: 3,
            ),
          ),
        ),
      ),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.assignNewSpeaker('g1'),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.saved,
          transcript: loaded.transcript!.copyWith(
            revision: 4,
            speakers: [
              ...loaded.transcript!.speakers,
              const Speaker(id: 's3', label: 'Maʼruzachi 3', ordinal: 3),
            ],
            segments: [seg.copyWith(speakerId: 's3')],
          ),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'the current speaker sends nothing',
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.assignSpeaker('g1', 's1'),
      expect: () => [loaded.copyWith(editStatus: EditStatus.saved)],
      verify: (_) => verifyNever(
        () => facade.assignSpeaker(
          transcriptId: any(named: 'transcriptId'),
          segmentId: any(named: 'segmentId'),
          speakerId: any(named: 'speakerId'),
          revision: any(named: 'revision'),
        ),
      ),
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a 409 fetches the fresh copy and shows the failure',
      setUp: () {
        answer('s2', const Left(Failure.server(statusCode: 409)));
        when(() => facade.getTranscript('t1')).thenAnswer(
          (_) async => Right(loaded.transcript!.copyWith(revision: 6)),
        );
      },
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.assignSpeaker('g1', 's2'),
      skip: 2,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.failure,
          editFailure: const Failure.server(statusCode: 409),
          transcript: loaded.transcript!.copyWith(revision: 6),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'any other failure keeps the transcript and does not refetch',
      setUp: () => answer('s2', const Left(Failure.network())),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.assignSpeaker('g1', 's2'),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.failure,
          editFailure: const Failure.network(),
        ),
      ],
      verify: (_) => verifyNever(() => facade.getTranscript(any())),
    );
  });

  group('split and merge', () {
    const a = Segment(
      id: 'g1',
      start: Duration.zero,
      end: Duration(seconds: 4),
      text: 'Salom dunyo',
      speakerId: 's1',
    );
    const b = Segment(
      id: 'g2',
      start: Duration(seconds: 4),
      end: Duration(seconds: 6),
      text: 'Xayr',
      speakerId: 's1',
    );
    const loaded = TranscriptState(
      status: TranscriptStatus.success,
      transcript: Transcript(
        id: 't1',
        title: 'Kengash',
        speakers: [Speaker(id: 's1', label: 'Maʼruzachi 1', ordinal: 1)],
        segments: [a, b],
        revision: 3,
      ),
    );
    final left = a.copyWith(
      text: 'Salom',
      end: const Duration(seconds: 2),
      edited: true,
    );
    final right = a.copyWith(
      id: 'g3',
      text: 'dunyo',
      start: const Duration(seconds: 2),
      edited: true,
    );
    final merged = a.copyWith(
      text: 'Salom dunyo Xayr',
      end: const Duration(seconds: 6),
      edited: true,
    );

    void splitAnswers(int revision, Either<Failure, SegmentSplit> result) =>
        when(
          () => facade.splitSegment(
            transcriptId: 't1',
            segmentId: 'g1',
            at: 6,
            revision: revision,
          ),
        ).thenAnswer((_) async => result);

    void mergeAnswers(int revision, Either<Failure, SegmentMerge> result) =>
        when(
          () => facade.mergeNext(
            transcriptId: 't1',
            segmentId: 'g1',
            revision: revision,
          ),
        ).thenAnswer((_) async => result);

    blocTest<TranscriptCubit, TranscriptState>(
      'a split puts both parts in place of the segment',
      setUp: () => splitAnswers(
        3,
        Right(SegmentSplit(first: left, second: right, revision: 4)),
      ),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      // Cursor after "Salom ": rune 6 on the server.
      act: (cubit) => cubit.splitSegment('g1', draft: 'Salom dunyo', cursor: 6),
      expect: () => [
        loaded.copyWith(editStatus: EditStatus.saving),
        loaded.copyWith(
          editStatus: EditStatus.saved,
          transcript: loaded.transcript!.copyWith(
            revision: 4,
            segments: [left, right, b],
          ),
        ),
      ],
      verify: (_) => verifyNever(
        () => facade.updateSegmentText(
          transcriptId: any(named: 'transcriptId'),
          segmentId: any(named: 'segmentId'),
          text: any(named: 'text'),
          revision: any(named: 'revision'),
        ),
      ),
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a changed draft is saved first and the split uses its revision',
      setUp: () {
        when(
          () => facade.updateSegmentText(
            transcriptId: 't1',
            segmentId: 'g1',
            text: 'Salom olam',
            revision: 3,
          ),
        ).thenAnswer(
          (_) async => Right(
            SegmentEdit(segment: a.copyWith(text: 'Salom olam'), revision: 4),
          ),
        );
        splitAnswers(
          4,
          Right(SegmentSplit(first: left, second: right, revision: 5)),
        );
      },
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      // One saving, one saved: the draft save does not close the editor.
      act: (cubit) => cubit.splitSegment('g1', draft: 'Salom olam', cursor: 6),
      expect: () => [
        loaded.copyWith(editStatus: EditStatus.saving),
        loaded.copyWith(
          editStatus: EditStatus.saved,
          transcript: loaded.transcript!.copyWith(
            revision: 5,
            segments: [left, right, b],
          ),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a failed draft save splits nothing',
      setUp: () => when(
        () => facade.updateSegmentText(
          transcriptId: any(named: 'transcriptId'),
          segmentId: any(named: 'segmentId'),
          text: any(named: 'text'),
          revision: any(named: 'revision'),
        ),
      ).thenAnswer((_) async => const Left(Failure.network())),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.splitSegment('g1', draft: 'Salom olam', cursor: 6),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.failure,
          editFailure: const Failure.network(),
        ),
      ],
      verify: (_) => verifyNever(
        () => facade.splitSegment(
          transcriptId: any(named: 'transcriptId'),
          segmentId: any(named: 'segmentId'),
          at: any(named: 'at'),
          revision: any(named: 'revision'),
        ),
      ),
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a split that fails after the draft saved keeps the saved text',
      setUp: () {
        when(
          () => facade.updateSegmentText(
            transcriptId: 't1',
            segmentId: 'g1',
            text: 'Salom olam',
            revision: 3,
          ),
        ).thenAnswer(
          (_) async => Right(
            SegmentEdit(segment: a.copyWith(text: 'Salom olam'), revision: 4),
          ),
        );
        when(
          () => facade.splitSegment(
            transcriptId: 't1',
            segmentId: 'g1',
            at: 6,
            revision: 4,
          ),
        ).thenAnswer((_) async => const Left(Failure.network()));
      },
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.splitSegment('g1', draft: 'Salom olam', cursor: 6),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.failure,
          editFailure: const Failure.network(),
          transcript: loaded.transcript!.copyWith(
            revision: 4,
            segments: [
              a.copyWith(text: 'Salom olam'),
              b,
            ],
          ),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a split at either edge sends nothing',
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) async {
        await cubit.splitSegment('g1', draft: 'Salom dunyo', cursor: 0);
        await cubit.splitSegment('g1', draft: 'Salom dunyo ', cursor: 12);
      },
      expect: () => const <TranscriptState>[],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a split 409 fetches the fresh copy and shows the failure',
      setUp: () {
        splitAnswers(3, const Left(Failure.server(statusCode: 409)));
        when(() => facade.getTranscript('t1')).thenAnswer(
          (_) async => Right(loaded.transcript!.copyWith(revision: 7)),
        );
      },
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.splitSegment('g1', draft: 'Salom dunyo', cursor: 6),
      skip: 2,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.failure,
          editFailure: const Failure.server(statusCode: 409),
          transcript: loaded.transcript!.copyWith(revision: 7),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a merge drops the next segment and keeps the joined one',
      setUp: () => mergeAnswers(
        3,
        Right(SegmentMerge(segment: merged, removedId: 'g2', revision: 4)),
      ),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.mergeNext('g1'),
      expect: () => [
        loaded.copyWith(editStatus: EditStatus.saving),
        loaded.copyWith(
          editStatus: EditStatus.saved,
          transcript: loaded.transcript!.copyWith(
            revision: 4,
            segments: [merged],
          ),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a merge from the editor saves a changed draft first',
      setUp: () {
        when(
          () => facade.updateSegmentText(
            transcriptId: 't1',
            segmentId: 'g1',
            text: 'Salom olam',
            revision: 3,
          ),
        ).thenAnswer(
          (_) async => Right(
            SegmentEdit(segment: a.copyWith(text: 'Salom olam'), revision: 4),
          ),
        );
        mergeAnswers(
          4,
          Right(SegmentMerge(segment: merged, removedId: 'g2', revision: 5)),
        );
      },
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.mergeNext('g1', draft: ' Salom  olam '),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.saved,
          transcript: loaded.transcript!.copyWith(
            revision: 5,
            segments: [merged],
          ),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'the last segment has nothing to merge and sends nothing',
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.mergeNext('g2'),
      expect: () => const <TranscriptState>[],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'a merge 409 fetches the fresh copy and shows the failure',
      setUp: () {
        mergeAnswers(3, const Left(Failure.server(statusCode: 409)));
        when(() => facade.getTranscript('t1')).thenAnswer(
          (_) async => Right(loaded.transcript!.copyWith(revision: 7)),
        );
      },
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.mergeNext('g1'),
      skip: 2,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.failure,
          editFailure: const Failure.server(statusCode: 409),
          transcript: loaded.transcript!.copyWith(revision: 7),
        ),
      ],
    );

    blocTest<TranscriptCubit, TranscriptState>(
      'any other merge failure keeps the transcript',
      setUp: () => mergeAnswers(3, const Left(Failure.network())),
      build: () => TranscriptCubit(facade),
      seed: () => loaded,
      act: (cubit) => cubit.mergeNext('g1'),
      skip: 1,
      expect: () => [
        loaded.copyWith(
          editStatus: EditStatus.failure,
          editFailure: const Failure.network(),
        ),
      ],
      verify: (_) => verifyNever(() => facade.getTranscript(any())),
    );
  });

  test('split offsets follow the web: collapsed spaces, runes', () {
    expect(EditRules.serverOffset('Salom dunyo', 6), 6);
    expect(EditRules.serverOffset('Salom   dunyo', 8), 6);
    expect(EditRules.serverOffset('  Salom dunyo', 7), 5);
    expect(EditRules.serverOffset('Salom\n dunyo', 5), 5);
    // An emoji is two UTF-16 units in the field and one rune in Go.
    expect(EditRules.serverOffset('😀 salom', 3), 2);
    expect(EditRules.splitAt('Salom dunyo', 6), 6);
    expect(EditRules.splitAt('Salom dunyo', 0), isNull);
    expect(EditRules.splitAt('Salom dunyo', 11), isNull);
  });

  test('EditRules count bytes, as the server does', () {
    // ʻ is two bytes in UTF-8: 40 of them are 80 bytes, 41 are too many.
    expect(EditRules.speakerLabelTooLong('ʻ' * 40), isFalse);
    expect(EditRules.speakerLabelTooLong('ʻ' * 41), isTrue);
    expect(EditRules.clean(' a \n\t b '), 'a b');
  });

  test('the speaker filter narrows the visible segments', () {
    const all = TranscriptState(
      status: TranscriptStatus.success,
      transcript: transcript,
    );
    expect(all.visibleSegments, hasLength(2));
    final one = all.copyWith(speakerFilter: 's2');
    expect(one.visibleSegments.single.id, 'g2');
  });

  test('TranscriptModel maps times and blank speakers', () {
    final t = TranscriptModel.fromJson(const {
      'id': 't1',
      'title': 'X',
      'duration_ms': 4000,
      'speakers': <Object>[],
      'segments': [
        {'id': 'g', 'start_ms': 1500, 'end_ms': 3000, 'text': 'salom'},
        {'id': 'h', 'start_ms': 3000, 'end_ms': 4000, 'speaker_id': ''},
      ],
    }).toEntity();
    expect(t.duration, const Duration(seconds: 4));
    expect(t.segments.first.start, const Duration(milliseconds: 1500));
    expect(t.segments.first.speakerId, isNull);
    expect(t.segments.last.speakerId, isNull);
    expect(t.segments.last.text, '');
  });
}
