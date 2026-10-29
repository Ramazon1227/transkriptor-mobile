import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/dictation_event.dart';
import 'package:transkriptor_uz/features/capture/domain/i_dictation_facade.dart';

part 'dictation_cubit.freezed.dart';

enum DictationStatus { idle, listening, stopped, saving, saved }

@freezed
abstract class DictationState with _$DictationState {
  const factory DictationState({
    @Default(DictationStatus.idle) DictationStatus status,

    /// Settled sentences, in order.
    @Default(<String>[]) List<String> finals,

    /// The sentence still being heard; shown muted.
    @Default('') String partial,
    @Default(Duration.zero) Duration elapsed,

    /// Of the last save; the text stays.
    Failure? failure,
  }) = _DictationState;

  const DictationState._();

  /// What is copied and saved: one settled sentence per line.
  String get text => finals.join('\n');
}

@injectable
class DictationCubit extends Cubit<DictationState> {
  DictationCubit(this._facade) : super(const DictationState());

  final IDictationFacade _facade;
  final Stopwatch _stopwatch = Stopwatch();
  StreamSubscription<DictationEvent>? _events;
  Timer? _ticker;

  void start({required List<String> samples}) {
    if (state.status == DictationStatus.listening ||
        state.status == DictationStatus.saving) {
      return;
    }
    // Starting again after a stop goes on with the same text.
    emit(
      state.copyWith(
        status: DictationStatus.listening,
        partial: '',
        failure: null,
      ),
    );
    _stopwatch.start();
    _ticker = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!isClosed) emit(state.copyWith(elapsed: _stopwatch.elapsed));
    });
    _events = _facade.listen(samples: samples).listen(_onEvent);
  }

  void _onEvent(DictationEvent event) {
    if (isClosed || state.status != DictationStatus.listening) return;
    switch (event) {
      case DictationPartial(:final text):
        emit(state.copyWith(partial: text));
      case DictationFinal(:final text):
        emit(state.copyWith(finals: [...state.finals, text], partial: ''));
    }
  }

  Future<void> stop() async {
    if (state.status != DictationStatus.listening) return;
    await _stopListening();
    if (isClosed) return;
    // A half-heard sentence is dropped, not kept as text.
    emit(
      state.copyWith(
        status: DictationStatus.stopped,
        partial: '',
        elapsed: _stopwatch.elapsed,
      ),
    );
  }

  Future<void> discard() async {
    await _stopListening();
    _stopwatch.reset();
    if (!isClosed) emit(const DictationState());
  }

  Future<void> saveAsNote({
    required String workspaceId,
    required String title,
  }) async {
    if (state.status != DictationStatus.stopped || state.finals.isEmpty) {
      return;
    }
    emit(state.copyWith(status: DictationStatus.saving, failure: null));
    final result = await _facade.saveAsNote(
      workspaceId: workspaceId,
      title: title,
      text: state.text,
    );
    if (isClosed) return;
    result.fold(
      (f) => emit(state.copyWith(status: DictationStatus.stopped, failure: f)),
      (_) => emit(state.copyWith(status: DictationStatus.saved)),
    );
  }

  Future<void> _stopListening() async {
    _stopwatch.stop();
    _ticker?.cancel();
    _ticker = null;
    await _events?.cancel();
    _events = null;
  }

  @override
  Future<void> close() async {
    await _stopListening();
    await super.close();
  }
}
