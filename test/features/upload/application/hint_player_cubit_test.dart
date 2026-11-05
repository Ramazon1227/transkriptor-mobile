import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';
import 'package:transkriptor_uz/features/upload/application/hint_player_cubit.dart';

import '../../../helpers/editor_fakes.dart';

void main() {
  test('opens the local file and reports its length', () async {
    final engines = FakeEngineFactory();
    final cubit = HintPlayerCubit(engines);
    await cubit.open('/tmp/a b.mp3');
    await pumpEventQueue();
    final engine = engines.made.single;
    expect(engine.opened, Uri.file('/tmp/a b.mp3'));
    expect(engine.opened!.isScheme('file'), isTrue);
    expect(cubit.state.status, HintPlayerStatus.ready);
    expect(cubit.state.duration, const Duration(minutes: 1));
    await cubit.close();
    expect(engine.disposed, isTrue);
  });

  test('a file it cannot open is a failure', () async {
    final engines = FakeEngineFactory()..failOpen = true;
    final cubit = HintPlayerCubit(engines);
    await cubit.open('/tmp/a.mp3');
    expect(cubit.state.status, HintPlayerStatus.failure);
    await cubit.close();
  });

  test(
    '±5 s stays inside the file; play from a hint seeks then plays',
    () async {
      final engines = FakeEngineFactory();
      final cubit = HintPlayerCubit(engines);
      await cubit.open('/tmp/a.mp3');
      await pumpEventQueue();
      final engine = engines.made.single;
      await cubit.seekBy(const Duration(seconds: -5));
      expect(cubit.state.position, Duration.zero);
      await cubit.seekTo(const Duration(minutes: 2));
      expect(cubit.state.position, const Duration(minutes: 1));
      await cubit.playFrom(const Duration(seconds: 15));
      await pumpEventQueue();
      expect(engine.calls, containsAllInOrder(['seek:15000', 'play']));
      expect(cubit.state.playing, isTrue);
      await cubit.toggle();
      await pumpEventQueue();
      expect(cubit.state.playing, isFalse);
      await cubit.close();
    },
  );

  test('play at the end starts over', () async {
    final engines = FakeEngineFactory();
    final cubit = HintPlayerCubit(engines);
    await cubit.open('/tmp/a.mp3');
    await pumpEventQueue();
    final engine = engines.made.single
      ..push(
        const PlaybackSnapshot(
          position: Duration(minutes: 1),
          duration: Duration(minutes: 1),
        ),
      );
    await pumpEventQueue();
    await cubit.toggle();
    expect(engine.calls, containsAllInOrder(['seek:0', 'play']));
    await cubit.close();
  });
}
