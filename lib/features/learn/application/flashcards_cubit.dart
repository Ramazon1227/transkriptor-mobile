import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';

part 'flashcards_cubit.freezed.dart';

@freezed
abstract class FlashcardsState with _$FlashcardsState {
  const factory FlashcardsState({
    @Default(<Flashcard>[]) List<Flashcard> cards,
    @Default(0) int index,

    /// The back (the answer) is showing.
    @Default(false) bool flipped,

    /// Card indexes marked «Bilaman» / «Takrorlash»; a card is in at most
    /// one of them.
    @Default(<int>{}) Set<int> known,
    @Default(<int>{}) Set<int> repeat,

    /// Past the last card: the result screen.
    @Default(false) bool finished,
  }) = _FlashcardsState;

  const FlashcardsState._();

  Flashcard? get current =>
      index < cards.length && !finished ? cards[index] : null;

  bool get hasPrevious => index > 0;
}

/// Walks one flashcard set: flip, mark, move.
@injectable
class FlashcardsCubit extends Cubit<FlashcardsState> {
  FlashcardsCubit() : super(const FlashcardsState());

  /// The set comes from the tab that opened the viewer.
  void start(FlashcardSet set) => emit(FlashcardsState(cards: set.cards));

  void flip() {
    if (state.current == null) return;
    emit(state.copyWith(flipped: !state.flipped));
  }

  void next() {
    if (state.finished || state.cards.isEmpty) return;
    if (state.index >= state.cards.length - 1) {
      emit(state.copyWith(finished: true, flipped: false));
    } else {
      emit(state.copyWith(index: state.index + 1, flipped: false));
    }
  }

  void previous() {
    if (state.finished) {
      emit(state.copyWith(finished: false, flipped: false));
      return;
    }
    if (!state.hasPrevious) return;
    emit(state.copyWith(index: state.index - 1, flipped: false));
  }

  /// Marks the current card and moves on.
  void mark({required bool known}) {
    if (state.current == null) return;
    final i = state.index;
    emit(
      state.copyWith(
        known: known ? {...state.known, i} : ({...state.known}..remove(i)),
        repeat: known ? ({...state.repeat}..remove(i)) : {...state.repeat, i},
      ),
    );
    next();
  }

  /// From the start; [onlyRepeat] keeps just the cards marked
  /// «Takrorlash».
  void restart({bool onlyRepeat = false}) {
    final cards = onlyRepeat
        ? [for (final i in state.repeat.toList()..sort()) state.cards[i]]
        : state.cards;
    if (cards.isEmpty) return;
    emit(FlashcardsState(cards: cards));
  }
}
