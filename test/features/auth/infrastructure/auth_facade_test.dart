import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/models/token_pair.dart';
import 'package:transkriptor_uz/core/network/session_manager.dart';
import 'package:transkriptor_uz/core/storage/token_storage.dart';
import 'package:transkriptor_uz/features/auth/infrastructure/facades/auth_facade.dart';
import 'package:transkriptor_uz/features/auth/infrastructure/models/me_model.dart';
import 'package:transkriptor_uz/features/auth/infrastructure/repositories/auth_repository.dart';

class _MockRepository extends Mock implements AuthRepository;

class _MockStorage extends Mock implements TokenStorage;

void main() {
  late _MockRepository repository;
  late _MockStorage storage;
  late SessionManager session;
  late AuthFacade facade;

  const me = MeModel(
    user: UserModel(id: 'u1', email: 'e@misol.uz', fullName: 'Ism'),
    workspaces: [
      WorkspaceModel(id: 'w1', name: 'S', isPersonal: true, balanceSeconds: 60),
    ],
  );

  setUp(() {
    repository = _MockRepository();
    storage = _MockStorage();
    session = SessionManager()..expire();
    facade = AuthFacade(repository, storage, session);
    when(
      () => storage.save(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
      ),
    ).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});
  });

  group('login', () {
    test('stores the pair, clears the expired flag, returns /me', () async {
      when(() => repository.login(email: 'e@misol.uz', password: 'p'))
          .thenAnswer(
            (_) async =>
                const Right(TokenPair(accessToken: 'a', refreshToken: 'r')),
          );
      when(() => repository.me()).thenAnswer((_) async => const Right(me));

      final result = await facade.login(email: 'e@misol.uz', password: 'p');

      final account = result.getOrElse(() => throw StateError('left'));
      expect(account.user.fullName, 'Ism');
      expect(account.currentWorkspace?.balanceSeconds, 60);
      expect(session.isExpired, isFalse);
      verify(() => storage.save(accessToken: 'a', refreshToken: 'r')).called(1);
    });

    test('a wrong password stores nothing', () async {
      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(Failure.unauthorized()));

      final result = await facade.login(email: 'e', password: 'x');

      expect(result, const Left<Failure, Object>(Failure.unauthorized()));
      expect(session.isExpired, isTrue);
      verifyNever(
        () => storage.save(
          accessToken: any(named: 'accessToken'),
          refreshToken: any(named: 'refreshToken'),
        ),
      );
    });

    test('an empty token pair is a parsing failure', () async {
      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(TokenPair()));

      final result = await facade.login(email: 'e', password: 'x');

      expect(result, const Left<Failure, Object>(Failure.parsing()));
    });
  });

  test(
    'a failed /me after login forgets the tokens and stays signed out',
    () async {
      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async =>
            const Right(TokenPair(accessToken: 'a', refreshToken: 'r')),
      );
      when(() => repository.me())
          .thenAnswer((_) async => const Left(Failure.network()));

      final result = await facade.login(email: 'e', password: 'p');

      expect(result, const Left<Failure, Object>(Failure.network()));
      verify(() => storage.clear()).called(1);
      expect(session.isExpired, isTrue);
    },
  );

  test('register signs in like login: stores the pair, returns /me', () async {
    when(
      () => repository.register(
        email: 'yangi@misol.uz',
        password: 'parol-12345',
        fullName: 'Dilnoza',
      ),
    ).thenAnswer(
      (_) async =>
          const Right(TokenPair(accessToken: 'a2', refreshToken: 'r2')),
    );
    when(() => repository.me()).thenAnswer((_) async => const Right(me));

    final result = await facade.register(
      email: 'yangi@misol.uz',
      password: 'parol-12345',
      fullName: 'Dilnoza',
    );

    expect(result.isRight(), isTrue);
    verify(() => storage.save(accessToken: 'a2', refreshToken: 'r2')).called(1);
    expect(session.isExpired, isFalse);
  });

  group('logout', () {
    test('revokes on the server and forgets the tokens', () async {
      session.markAuthenticated();
      when(() => storage.readRefreshToken()).thenAnswer((_) async => 'r');
      when(() => repository.logout(refreshToken: 'r'))
          .thenAnswer((_) async => const Right(unit));

      await facade.logout();

      verify(() => repository.logout(refreshToken: 'r')).called(1);
      verify(() => storage.clear()).called(1);
      expect(session.isExpired, isTrue);
    });

    test('still logs out locally when the server cannot be reached', () async {
      session.markAuthenticated();
      when(() => storage.readRefreshToken()).thenAnswer((_) async => 'r');
      when(() => repository.logout(refreshToken: 'r'))
          .thenAnswer((_) async => const Left(Failure.network()));

      final result = await facade.logout();

      expect(result.isRight(), isTrue);
      verify(() => storage.clear()).called(1);
      expect(session.isExpired, isTrue);
    });
  });
}
