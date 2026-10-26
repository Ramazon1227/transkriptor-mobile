import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/example/application/example_bloc.dart';
import 'package:transkriptor_uz/features/example/domain/entities/post.dart';
import 'package:transkriptor_uz/features/example/domain/i_example_facade.dart';

class _MockExampleFacade extends Mock implements IExampleFacade;

void main() {
  late _MockExampleFacade facade;

  const posts = [Post(id: 1, userId: 1, title: 'sarlavha', body: 'matn')];

  setUp(() => facade = _MockExampleFacade());

  group('ExampleBloc', () {
    blocTest<ExampleBloc, ExampleState>(
      'emits loading then success when posts load',
      setUp: () =>
          when(() => facade.getPosts(userId: any(named: 'userId')))
              .thenAnswer((_) async => const Right(posts)),
      build: () => ExampleBloc(facade),
      act: (bloc) => bloc.add(const ExampleStarted(userId: 1)),
      expect: () => const [
        ExampleState(status: ExampleStatus.loading, userId: 1),
        ExampleState(status: ExampleStatus.success, userId: 1, posts: posts),
      ],
      verify: (_) => verify(() => facade.getPosts(userId: 1)).called(1),
    );

    blocTest<ExampleBloc, ExampleState>(
      'emits empty, not failure, for an empty list',
      setUp: () =>
          when(() => facade.getPosts(userId: any(named: 'userId')))
              .thenAnswer((_) async => const Right(<Post>[])),
      build: () => ExampleBloc(facade),
      act: (bloc) => bloc.add(const ExampleStarted()),
      expect: () => const [
        ExampleState(status: ExampleStatus.loading),
        ExampleState(status: ExampleStatus.empty),
      ],
    );

    blocTest<ExampleBloc, ExampleState>(
      'emits failure with the facade failure',
      setUp: () =>
          when(() => facade.getPosts(userId: any(named: 'userId')))
              .thenAnswer((_) async => const Left(Failure.network())),
      build: () => ExampleBloc(facade),
      act: (bloc) => bloc.add(const ExampleStarted()),
      expect: () => const [
        ExampleState(status: ExampleStatus.loading),
        ExampleState(status: ExampleStatus.failure, failure: Failure.network()),
      ],
    );

    blocTest<ExampleBloc, ExampleState>(
      'a late answer for an old filter never overwrites the newer one',
      setUp: () {
        final slow = Completer<void>();
        when(() => facade.getPosts(userId: 1)).thenAnswer((_) async {
          await slow.future;
          return const Right(posts);
        });
        when(() => facade.getPosts(userId: 2))
            .thenAnswer((_) async => const Right(<Post>[]));
        addTearDown(slow.complete);
      },
      build: () => ExampleBloc(facade),
      act: (bloc) async {
        bloc.add(const ExampleStarted(userId: 1));
        await Future<void>.delayed(Duration.zero);
        bloc.add(const ExampleUserChanged(2));
      },
      expect: () => const [
        ExampleState(status: ExampleStatus.loading, userId: 1),
        ExampleState(status: ExampleStatus.loading, userId: 2),
        ExampleState(status: ExampleStatus.empty, userId: 2),
      ],
    );
  });
}
