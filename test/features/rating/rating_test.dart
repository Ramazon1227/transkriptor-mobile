import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/rating/application/rating_cubit.dart';
import 'package:transkriptor_uz/features/rating/domain/entities/rating.dart';
import 'package:transkriptor_uz/features/rating/domain/i_rating_facade.dart';
import 'package:transkriptor_uz/features/rating/infrastructure/facades/rating_facade.dart';
import 'package:transkriptor_uz/features/rating/infrastructure/repositories/rating_repository.dart';

import '../../helpers/fake_http_adapter.dart';

class _MockFacade extends Mock implements IRatingFacade;

void main() {
  setUpAll(() => registerFallbackValue(const Rating(score: 1)));

  group('RatingFacade over the repository', () {
    test('null rating is "not rated"; PUT sends score and note', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/transcript/t1/rating': (200, ok({'rating': null})),
        'PUT /api/v1/transcript/t1/rating': (
          200,
          ok({
            'rating': {
              'score': 4,
              'note': 'ismlar',
              'updated_at': '2026-10-29T09:30:00Z',
            },
          }),
        ),
      });
      final facade = RatingFacade(RatingRepository(fakeDio(http)));

      final mine = await facade.myRating('t1');
      expect(mine, const Right<Failure, Rating?>(null));

      final set = await facade.setRating(
        't1',
        const Rating(score: 4, note: 'ismlar'),
      );
      expect(
        set,
        const Right<Failure, Rating>(Rating(score: 4, note: 'ismlar')),
      );
      expect(http.sent.last.body, {'score': 4, 'note': 'ismlar'});
    });
  });

  group('RatingCubit', () {
    late _MockFacade facade;
    setUp(() => facade = _MockFacade());

    blocTest<RatingCubit, RatingState>(
      'a tap stores the score and keeps the web note',
      setUp: () {
        when(() => facade.myRating('t1')).thenAnswer(
          (_) async => const Right(Rating(score: 2, note: 'shovqin')),
        );
        when(
          () => facade.setRating('t1', const Rating(score: 5, note: 'shovqin')),
        ).thenAnswer(
          (_) async => const Right(Rating(score: 5, note: 'shovqin')),
        );
      },
      build: () => RatingCubit(facade),
      act: (c) async {
        await c.load('t1');
        await c.rate(5);
      },
      skip: 2,
      expect: () => [
        const RatingState(
          status: RatingStatus.success,
          rating: Rating(score: 2, note: 'shovqin'),
          saveStatus: RatingSaveStatus.saving,
        ),
        const RatingState(
          status: RatingStatus.success,
          rating: Rating(score: 5, note: 'shovqin'),
          saveStatus: RatingSaveStatus.saved,
        ),
      ],
    );

    blocTest<RatingCubit, RatingState>(
      'the same score sends nothing; a failure keeps the old stars',
      setUp: () {
        when(() => facade.myRating('t1'))
            .thenAnswer((_) async => const Right(Rating(score: 3)));
        when(() => facade.setRating(any(), any()))
            .thenAnswer((_) async => const Left(Failure.network()));
      },
      build: () => RatingCubit(facade),
      act: (c) async {
        await c.load('t1');
        await c.rate(3);
        await c.rate(1);
      },
      verify: (c) {
        verify(() => facade.setRating('t1', const Rating(score: 1))).called(1);
        expect(c.state.rating, const Rating(score: 3));
        expect(c.state.saveStatus, RatingSaveStatus.failure);
      },
    );
  });
}
