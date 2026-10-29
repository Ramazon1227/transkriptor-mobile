import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/application/dictation_cubit.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/dictation_event.dart';
import 'package:transkriptor_uz/features/capture/domain/i_dictation_facade.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/demo/demo_dictation_repository.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/repositories/note_repository.dart';

import '../../helpers/fake_http_adapter.dart';

class _MockFacade extends Mock implements IDictationFacade;

void main() {
  late _MockFacade facade;
  late StreamController<DictationEvent> events;

  setUp(() {
    facade = _MockFacade();
    events = StreamController<DictationEvent>();
    when(() => facade.listen(samples: any(named: 'samples')))
        .thenAnswer((_) => events.stream);
  });

  // Not awaited: a controller nobody listened to never finishes closing.
  tearDown(() => unawaited(events.close()));

  test('partial text grows, final text settles it', () async {
    final cubit = DictationCubit(facade)..start(samples: const []);
    expect(cubit.state.status, DictationStatus.listening);
    events
      ..add(const DictationEvent.partial('Assalomu'))
      ..add(const DictationEvent.partial('Assalomu alaykum'));
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.partial, 'Assalomu alaykum');
    expect(cubit.state.finals, isEmpty);

    events.add(const DictationEvent.finalText('Assalomu alaykum.'));
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.partial, '');
    expect(cubit.state.finals, ['Assalomu alaykum.']);

    events.add(const DictationEvent.partial('Yana'));
    await Future<void>.delayed(Duration.zero);
    await cubit.stop();
    // A half-heard sentence is dropped.
    expect(cubit.state.status, DictationStatus.stopped);
    expect(cubit.state.partial, '');
    expect(cubit.state.text, 'Assalomu alaykum.');

    // Nothing arrives after stop.
    expect(events.hasListener, isFalse);
    await cubit.close();
  });

  blocTest<DictationCubit, DictationState>(
    'saves the settled text as a note',
    setUp: () => when(
      () => facade.saveAsNote(
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        text: any(named: 'text'),
      ),
    ).thenAnswer((_) async => const Right(unit)),
    build: () => DictationCubit(facade),
    seed: () => const DictationState(
      status: DictationStatus.stopped,
      finals: ['Bir.', 'Ikki.'],
    ),
    act: (c) => c.saveAsNote(workspaceId: 'w1', title: 'Diktovka'),
    expect: () => const [
      DictationState(status: DictationStatus.saving, finals: ['Bir.', 'Ikki.']),
      DictationState(status: DictationStatus.saved, finals: ['Bir.', 'Ikki.']),
    ],
    verify: (_) => verify(
      () => facade.saveAsNote(
        workspaceId: 'w1',
        title: 'Diktovka',
        text: 'Bir.\nIkki.',
      ),
    ).called(1),
  );

  blocTest<DictationCubit, DictationState>(
    'a failed save keeps the text',
    setUp: () => when(
      () => facade.saveAsNote(
        workspaceId: any(named: 'workspaceId'),
        title: any(named: 'title'),
        text: any(named: 'text'),
      ),
    ).thenAnswer((_) async => const Left(Failure.network())),
    build: () => DictationCubit(facade),
    seed: () =>
        const DictationState(status: DictationStatus.stopped, finals: ['Bir.']),
    act: (c) => c.saveAsNote(workspaceId: 'w1', title: 't'),
    skip: 1,
    expect: () => const [
      DictationState(
        status: DictationStatus.stopped,
        finals: ['Bir.'],
        failure: Failure.network(),
      ),
    ],
  );

  blocTest<DictationCubit, DictationState>(
    'discard clears everything',
    build: () => DictationCubit(facade),
    seed: () =>
        const DictationState(status: DictationStatus.stopped, finals: ['x']),
    act: (c) => c.discard(),
    expect: () => const [DictationState()],
  );

  test('the demo source plays words as partials, then the sentence', () async {
    final source = DemoDictationRepository.withGap(Duration.zero);
    final got = await source.listen(const ['Bir ikki uch.']).take(3).toList();
    expect(got, const [
      DictationEvent.partial('Bir'),
      DictationEvent.partial('Bir ikki'),
      DictationEvent.finalText('Bir ikki uch.'),
    ]);
  });

  test('POST /notes sends a Tiptap doc of paragraphs', () async {
    final http = FakeHttpAdapter({
      'POST /api/v1/notes': (
        201,
        ok({
          'note': {'id': 'n1'},
        }),
      ),
    });
    final result = await NoteRepository(fakeDio(http)).create(
      workspaceId: 'w1',
      title: 'Diktovka',
      paragraphs: const ['Bir.', 'Ikki.'],
    );
    expect(result.isRight(), isTrue);
    expect(http.sent.single.body, {
      'workspace_id': 'w1',
      'title': 'Diktovka',
      'body': {
        'type': 'doc',
        'content': [
          {
            'type': 'paragraph',
            'content': [
              {'type': 'text', 'text': 'Bir.'},
            ],
          },
          {
            'type': 'paragraph',
            'content': [
              {'type': 'text', 'text': 'Ikki.'},
            ],
          },
        ],
      },
    });
  });
}
