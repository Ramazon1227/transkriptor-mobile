import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/rating/domain/entities/rating.dart';
import 'package:transkriptor_uz/features/rating/domain/i_rating_facade.dart';

part 'rating_cubit.freezed.dart';

enum RatingStatus { initial, loading, success, failure }

enum RatingSaveStatus { idle, saving, saved, failure }

@freezed
abstract class RatingState with _$RatingState {
  const factory RatingState({
    @Default(RatingStatus.initial) RatingStatus status,

    /// Null: not rated yet.
    Rating? rating,
    Failure? failure,
    @Default(RatingSaveStatus.idle) RatingSaveStatus saveStatus,
    Failure? saveFailure,
  }) = _RatingState;
}

/// The caller's 1–5 mark for one transcript. Not optimistic: the stars
/// show what the server stored.
@injectable
class RatingCubit extends Cubit<RatingState> {
  RatingCubit(this._facade) : super(const RatingState());

  final IRatingFacade _facade;
  String? _transcriptId;

  /// [transcriptId] comes from the transcript page.
  Future<void> load(String transcriptId) async {
    _transcriptId = transcriptId;
    emit(state.copyWith(status: RatingStatus.loading, failure: null));
    final result = await _facade.myRating(transcriptId);
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: RatingStatus.failure, failure: failure)),
      (rating) =>
          emit(state.copyWith(status: RatingStatus.success, rating: rating)),
    );
  }

  Future<void> reload() async {
    final id = _transcriptId;
    if (id != null) await load(id);
  }

  /// The note written on the web goes back unchanged. The same score
  /// sends nothing.
  Future<void> rate(int score) async {
    final id = _transcriptId;
    if (id == null || score < 1 || score > 5) return;
    if (state.saveStatus == RatingSaveStatus.saving) return;
    if (state.rating?.score == score) return;
    emit(
      state.copyWith(saveStatus: RatingSaveStatus.saving, saveFailure: null),
    );
    final result = await _facade.setRating(
      id,
      Rating(score: score, note: state.rating?.note ?? ''),
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          saveStatus: RatingSaveStatus.failure,
          saveFailure: failure,
        ),
      ),
      (rating) => emit(
        state.copyWith(saveStatus: RatingSaveStatus.saved, rating: rating),
      ),
    );
  }
}
