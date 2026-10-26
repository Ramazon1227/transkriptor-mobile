import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
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
