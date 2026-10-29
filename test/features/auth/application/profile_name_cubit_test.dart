import 'dart:async';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/application/profile_name_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';
import 'package:transkriptor_uz/features/auth/domain/name_rules.dart';

class _MockAuthFacade extends Mock implements IAuthFacade;

void main() {
  late _MockAuthFacade facade;

  setUp(() => facade = _MockAuthFacade());

  test('sends the cleaned name and keeps the stored user', () async {
    when(() => facade.updateName(any())).thenAnswer(
      (_) async =>
          const Right(AppUser(id: 'u1', email: 'e', fullName: 'Ali Valiyev')),
    );
    final cubit = ProfileNameCubit(facade);
    addTearDown(cubit.close);
    await cubit.save('  Ali   Valiyev ');
    verify(() => facade.updateName('Ali Valiyev')).called(1);
    expect(cubit.state.status, ProfileNameStatus.success);
    expect(cubit.state.user?.fullName, 'Ali Valiyev');
  });

  test('an invalid name is refused without a request', () async {
    final cubit = ProfileNameCubit(facade);
    addTearDown(cubit.close);
    await cubit.save('   ');
    expect(cubit.state.invalid, NameError.empty);
    await cubit.save('x' * 200);
    expect(cubit.state.invalid, NameError.tooLong);
    verifyNever(() => facade.updateName(any()));
  });

  test('a failure is kept for the field; a double tap sends once', () async {
    final pending = Completer<Either<Failure, AppUser>>();
    when(() => facade.updateName(any())).thenAnswer((_) => pending.future);
    final cubit = ProfileNameCubit(facade);
    addTearDown(cubit.close);
    final first = cubit.save('Ali');
    await cubit.save('Ali');
    pending.complete(const Left(Failure.network()));
    await first;
    verify(() => facade.updateName('Ali')).called(1);
    expect(cubit.state.status, ProfileNameStatus.failure);
    expect(cubit.state.failure, const Failure.network());
  });
}
