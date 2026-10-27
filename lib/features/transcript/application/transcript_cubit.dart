import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/transcript/domain/edit_rules.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';

part 'transcript_cubit.freezed.dart';

enum TranscriptStatus { initial, loading, success, empty, failure }

/// One save at a time: a segment text or a speaker name. Kept apart from
/// [TranscriptStatus] so a failed save never hides the transcript.
enum EditStatus { idle, saving, saved, failure }

@freezed
abstract class TranscriptState with _$TranscriptState {
  const factory TranscriptState({
    @Default(TranscriptStatus.initial) TranscriptStatus status,
    Transcript? transcript,

    /// Null shows every speaker.
    String? speakerFilter,
    Failure? failure,
    @Default(EditStatus.idle) EditStatus editStatus,
    Failure? editFailure,
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

  /// Saves one segment's text against the revision on screen. Not
  /// optimistic: the row is replaced by what the server stored. An
  /// unchanged text sends nothing.
  Future<void> saveSegmentText(String segmentId, String text) async {
    final transcript = state.transcript;
    if (transcript == null || state.editStatus == EditStatus.saving) return;
    final clean = EditRules.clean(text);
    final current = transcript.segments.where((s) => s.id == segmentId);
    if (current.isEmpty) return _gone();
    if (current.first.text == clean) {
      emit(state.copyWith(editStatus: EditStatus.saved, editFailure: null));
      return;
    }

    emit(state.copyWith(editStatus: EditStatus.saving, editFailure: null));
    final result = await _facade.updateSegmentText(
      transcriptId: transcript.id,
      segmentId: segmentId,
      text: clean,
      revision: transcript.revision,
    );
    if (isClosed) return;
    await result.fold(
      (failure) async {
        // 409: someone saved in between. The fresh copy is fetched so the
        // next save goes against the current revision; the person's draft
        // stays in the open editor.
        if (failure case ServerFailure(statusCode: 409)) {
          await _refetch(transcript.id);
          if (isClosed) return;
        }
        emit(
          state.copyWith(editStatus: EditStatus.failure, editFailure: failure),
        );
      },
      (edit) async {
        final latest = state.transcript ?? transcript;
        emit(
          state.copyWith(
            editStatus: EditStatus.saved,
            transcript: latest.copyWith(
              revision: edit.revision,
              segments: latest.segments
                  .map((s) => s.id == edit.segment.id ? edit.segment : s)
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  /// "Maʼruzachi 1" → a real name. An empty or unchanged name sends
  /// nothing.
  Future<void> renameSpeaker(String speakerId, String label) async {
    final transcript = state.transcript;
    if (transcript == null || state.editStatus == EditStatus.saving) return;
    final clean = EditRules.clean(label);
    if (clean.isEmpty) return;
    final current = transcript.speakers.where((s) => s.id == speakerId);
    if (current.isEmpty) return _gone();
    if (current.first.label == clean) {
      emit(state.copyWith(editStatus: EditStatus.saved, editFailure: null));
      return;
    }

    emit(state.copyWith(editStatus: EditStatus.saving, editFailure: null));
    final result = await _facade.renameSpeaker(
      transcriptId: transcript.id,
      speakerId: speakerId,
      label: clean,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(editStatus: EditStatus.failure, editFailure: failure),
      ),
      (speaker) {
        final latest = state.transcript ?? transcript;
        emit(
          state.copyWith(
            editStatus: EditStatus.saved,
            transcript: latest.copyWith(
              speakers: latest.speakers
                  .map((s) => s.id == speaker.id ? speaker : s)
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  /// An editor opens: it must not see the previous one's `saved` or
  /// failure. Called on open, not only on close, so a stale state can
  /// never close or mark the new editor.
  void editOpened() => _resetEdit();

  /// The editor closed. A save still in flight keeps its `saving`, so a
  /// second save cannot start against the same revision.
  void editClosed() => _resetEdit();

  void _resetEdit() {
    if (state.editStatus == EditStatus.saving) return;
    emit(state.copyWith(editStatus: EditStatus.idle, editFailure: null));
  }

  /// The row is no longer there (a 409 refetch removed it): the same
  /// answer the server gives, so the editor says so instead of waiting.
  void _gone() => emit(
    state.copyWith(
      editStatus: EditStatus.failure,
      editFailure: const Failure.server(statusCode: 404),
    ),
  );

  /// Replaces the transcript in place, without the loading state. A
  /// failed refetch keeps the old copy: the save failure is shown anyway.
  Future<void> _refetch(String id) async {
    final result = await _facade.getTranscript(id);
    if (isClosed) return;
    result.fold((_) {}, (fresh) => emit(state.copyWith(transcript: fresh)));
  }
}
