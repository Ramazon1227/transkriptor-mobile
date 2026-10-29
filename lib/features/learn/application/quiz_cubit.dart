import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';

part 'quiz_cubit.freezed.dart';

@freezed
abstract class QuizState with _$QuizState {
  const factory QuizState({
    @Default(<QuizQuestion>[]) List<QuizQuestion> questions,
    @Default(0) int index,

    /// The chosen answer per question; null = not answered yet.
    @Default(<int?>[]) List<int?> answers,
    @Default(false) bool finished,
  }) = _QuizState;

  const QuizState._();

  QuizQuestion? get current =>
      index < questions.length && !finished ? questions[index] : null;

  int? get currentAnswer => index < answers.length ? answers[index] : null;

  int get score => [
    for (var i = 0; i < questions.length; i++)
      if (i < answers.length && answers[i] == questions[i].correctIndex) i,
  ].length;
}

/// Runs one quiz: one question at a time, an answer is final and marked
/// at once.
@injectable
class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(const QuizState());

  /// The set comes from the tab that opened the runner.
  void start(QuizSet set) => emit(
    QuizState(
      questions: set.questions,
      answers: List<int?>.filled(set.questions.length, null),
    ),
  );

  void choose(int option) {
    final q = state.current;
    if (q == null || state.currentAnswer != null) return;
    if (option < 0 || option >= q.answerCount) return;
    final answers = [...state.answers];
    answers[state.index] = option;
    emit(state.copyWith(answers: answers));
  }

  /// Only after answering.
  void next() {
    if (state.current == null || state.currentAnswer == null) return;
    if (state.index >= state.questions.length - 1) {
      emit(state.copyWith(finished: true));
    } else {
      emit(state.copyWith(index: state.index + 1));
    }
  }

  void restart() => emit(
    QuizState(
      questions: state.questions,
      answers: List<int?>.filled(state.questions.length, null),
    ),
  );
}
