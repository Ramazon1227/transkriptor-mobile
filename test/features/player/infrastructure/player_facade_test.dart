import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/features/links/domain/i_links_facade.dart';
import 'package:transkriptor_uz/features/player/infrastructure/facades/player_facade.dart';
import 'package:transkriptor_uz/features/player/infrastructure/repositories/player_repository.dart';
import 'package:transkriptor_uz/features/player/infrastructure/storage/player_speed_storage.dart';

class _MockRepository extends Mock implements PlayerRepository;

class _MockLinks extends Mock implements ILinksFacade;

class _MockStorage extends Mock implements PlayerSpeedStorage;

void main() {
  late _MockStorage storage;
  late PlayerFacade facade;

  setUp(() {
    storage = _MockStorage();
    facade = PlayerFacade(_MockRepository(), _MockLinks(), storage);
  });

  test('the saved speed round-trips as text', () async {
    when(() => storage.write(any())).thenAnswer((_) async {});
    await facade.saveSpeed(0.25);
    verify(() => storage.write('0.25')).called(1);

    when(() => storage.read()).thenAnswer((_) async => '0.25');
    expect(await facade.savedSpeed(), 0.25);
  });

  test('nothing saved, garbage or a broken keychain: no speed', () async {
    when(() => storage.read()).thenAnswer((_) async => null);
    expect(await facade.savedSpeed(), isNull);

    when(() => storage.read()).thenAnswer((_) async => 'tez');
    expect(await facade.savedSpeed(), isNull);

    when(() => storage.read()).thenThrow(Exception('keychain'));
    expect(await facade.savedSpeed(), isNull);
  });

  test('a store that cannot be written is not an error', () async {
    when(() => storage.write(any())).thenThrow(Exception('keychain'));
    await expectLater(facade.saveSpeed(2), completes);
  });
}
