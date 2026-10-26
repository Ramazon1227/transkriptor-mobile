import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';

part 'transcript_cubit.freezed.dart';

enum TranscriptStatus { initial, loading, success, empty, failure }

@freezed
abstract class TranscriptState with _$TranscriptState {
  const factory TranscriptState({
    @Default(TranscriptStatus.initial) TranscriptStatus status,
    Transcript? transcript,

    /// Null shows every speaker.
    String? speakerFilter,
    Failure? failure,
  }) = _TranscriptState;

  const TranscriptState._();

  List<Segment> get visibleSegments {
    final segments = transcript?.segments ?? const <Segment>[];
    final filter = speakerFilter;
    if (filter == null) return segments;
    return segments.where((s) => s.speakerId == filter).toList();
  }
}

@injectable
class TranscriptCubit extends Cubit<TranscriptState> {
  TranscriptCubit(this._facade) : super(const TranscriptState());

  final ITranscriptFacade _facade;

  /// [id] comes from the route.
  Future<void> load(String id) async {
    emit(state.copyWith(status: TranscriptStatus.loading, failure: null));
    final result = await _facade.getTranscript(id);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(status: TranscriptStatus.failure, failure: failure),
      ),
      (transcript) => emit(
        state.copyWith(
          status: transcript.segments.isEmpty
              ? TranscriptStatus.empty
              : TranscriptStatus.success,
          transcript: transcript,
        ),
      ),
    );
  }

  void filterSpeaker(String? speakerId) {
    emit(state.copyWith(speakerFilter: speakerId));
  }
}
