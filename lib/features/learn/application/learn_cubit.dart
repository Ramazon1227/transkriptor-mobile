import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/learn/domain/i_learn_facade.dart';
import 'package:transkriptor_uz/features/learn/domain/learn_rules.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

part 'learn_cubit.freezed.dart';

enum LearnStatus { initial, ready, tooShort }

enum LearnCreateStatus {
  idle,
  creating,

  /// The text gave nothing to ask about (all sentences too short).
  empty,
  failure,
}

@freezed
abstract class LearnState with _$LearnState {
  const factory LearnState({
    @Default(LearnStatus.initial) LearnStatus status,
    @Default(LearnSets()) LearnSets sets,
    @Default(LearnCreateStatus.idle) LearnCreateStatus createStatus,
    Failure? failure,
  }) = _LearnState;
}

/// The «Oʻrganish» tab: the session's sets for one transcript and the
/// creation of new ones. Creating returns the new set so the tab can
/// open it at once.
@injectable
class LearnCubit extends Cubit<LearnState> {
  LearnCubit(this._facade) : super(const LearnState());

  final ILearnFacade _facade;
  Transcript? _transcript;

  /// [transcript] comes from the editor.
  Future<void> start(Transcript transcript) async {
    _transcript = transcript;
    if (!canLearn(transcript)) {
      emit(state.copyWith(status: LearnStatus.tooShort));
      return;
    }
    emit(state.copyWith(status: LearnStatus.ready));
    final result = await _facade.sets(transcript.id);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (sets) => emit(state.copyWith(sets: sets)),
    );
  }

  Future<FlashcardSet?> createFlashcards({
    required int count,
    required LearnDifficulty difficulty,
  }) async {
    final transcript = _ready();
    if (transcript == null) return null;
    _creating();
    final result = await _facade.createFlashcards(
      transcript,
      count: count,
      difficulty: difficulty,
    );
    if (isClosed) return null;
    final created = result.fold<FlashcardSet?>(
      (failure) {
        _failed(failure);
        return null;
      },
      (set) {
        if (set.cards.isEmpty) {
          emit(state.copyWith(createStatus: LearnCreateStatus.empty));
          return null;
        }
        emit(
          state.copyWith(
            createStatus: LearnCreateStatus.idle,
            sets: state.sets.copyWith(
              flashcards: [set, ...state.sets.flashcards],
            ),
          ),
        );
        return set;
      },
    );
    return created;
  }

  Future<QuizSet?> createQuiz({
    required int count,
    required LearnDifficulty difficulty,
    required Set<QuizQuestionType> types,
  }) async {
    final transcript = _ready();
    if (transcript == null || types.isEmpty) return null;
    _creating();
    final result = await _facade.createQuiz(
      transcript,
      count: count,
      difficulty: difficulty,
      types: types,
    );
    if (isClosed) return null;
    final created = result.fold<QuizSet?>(
      (failure) {
        _failed(failure);
        return null;
      },
      (set) {
        if (set.questions.isEmpty) {
          emit(state.copyWith(createStatus: LearnCreateStatus.empty));
          return null;
        }
        emit(
          state.copyWith(
            createStatus: LearnCreateStatus.idle,
            sets: state.sets.copyWith(quizzes: [set, ...state.sets.quizzes]),
          ),
        );
        return set;
      },
    );
    return created;
  }

  Transcript? _ready() {
    if (state.status != LearnStatus.ready ||
        state.createStatus == LearnCreateStatus.creating) {
      return null;
    }
    return _transcript;
  }

  void _creating() => emit(
    state.copyWith(createStatus: LearnCreateStatus.creating, failure: null),
  );

  void _failed(Failure failure) => emit(
    state.copyWith(createStatus: LearnCreateStatus.failure, failure: failure),
  );
}
