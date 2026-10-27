import 'package:dartz/dartz.dart' show Either;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/transcript/domain/edit_rules.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';

part 'transcript_cubit.freezed.dart';

/// One request of an edit: takes the transcript as it stands and gives
/// back the one with the server's answer applied.
typedef _Step = Future<Either<Failure, Transcript>> Function(Transcript);

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

  /// Whether a segment comes after [segmentId] in the whole transcript —
  /// the speaker filter does not change what "next" means to the server.
  bool hasNext(String segmentId) {
    final segments = transcript?.segments ?? const <Segment>[];
    final i = segments.indexWhere((s) => s.id == segmentId);
    return i >= 0 && i < segments.length - 1;
  }

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
    final current = _segment(transcript, segmentId);
    if (current == null) return _gone();
    if (current.text == clean) return _unchanged();
    await _edit([_textStep(segmentId, clean)]);
  }

  /// Moves a segment to another speaker of this transcript. The current
  /// one sends nothing.
  Future<void> assignSpeaker(String segmentId, String speakerId) async {
    final transcript = state.transcript;
    if (transcript == null || state.editStatus == EditStatus.saving) return;
    final current = _segment(transcript, segmentId);
    if (current == null) return _gone();
    if (current.speakerId == speakerId) return _unchanged();
    await _edit([_speakerStep(segmentId, speakerId)]);
  }

  /// Moves a segment to a speaker the server opens with its default name
  /// ("Maʼruzachi N"), as the web's «Yangi maʼruzachi» does; the name is
  /// changed afterwards like any other speaker's.
  Future<void> assignNewSpeaker(String segmentId) async {
    final transcript = state.transcript;
    if (transcript == null || state.editStatus == EditStatus.saving) return;
    if (_segment(transcript, segmentId) == null) return _gone();
    await _edit([_speakerStep(segmentId, null)]);
  }

  /// Splits a segment at the cursor in its editor. A changed [draft] is
  /// saved first, as the web does, so the split goes against the text on
  /// screen; if that save fails nothing is split. A point at either edge
  /// sends nothing — the server would refuse it.
  Future<void> splitSegment(
    String segmentId, {
    required String draft,
    required int cursor,
  }) async {
    final transcript = state.transcript;
    if (transcript == null || state.editStatus == EditStatus.saving) return;
    final current = _segment(transcript, segmentId);
    if (current == null) return _gone();
    final at = EditRules.splitAt(draft, cursor);
    if (at == null) return;
    await _edit([
      ..._flush(current, draft),
      (t) async => (await _facade.splitSegment(
        transcriptId: t.id,
        segmentId: segmentId,
        at: at,
        revision: t.revision,
      )).map((split) => _applySplit(t, segmentId, split)),
    ]);
  }

  /// Folds the next segment into this one. From the editor, a changed
  /// [draft] is saved first; from the menu there is no draft. The last
  /// segment has nothing to take and sends nothing.
  Future<void> mergeNext(String segmentId, {String? draft}) async {
    final transcript = state.transcript;
    if (transcript == null || state.editStatus == EditStatus.saving) return;
    final current = _segment(transcript, segmentId);
    if (current == null) return _gone();
    if (!state.hasNext(segmentId)) return;
    await _edit([
      if (draft != null) ..._flush(current, draft),
      (t) async => (await _facade.mergeNext(
        transcriptId: t.id,
        segmentId: segmentId,
        revision: t.revision,
      )).map((merge) => _applyMerge(t, merge)),
    ]);
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
    if (current.first.label == clean) return _unchanged();

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

  /// Runs [steps] one after another under one `saving`, each against the
  /// revision the previous one returned. Not optimistic: every step
  /// replaces rows with what the server stored. On a failure the steps
  /// that went through stay applied; a 409 fetches the fresh copy so the
  /// next try goes against the current revision, and the person's draft
  /// stays in the open editor.
  Future<void> _edit(List<_Step> steps) async {
    var current = state.transcript!;
    emit(state.copyWith(editStatus: EditStatus.saving, editFailure: null));
    for (final step in steps) {
      final result = await step(current);
      if (isClosed) return;
      final failure = result.fold<Failure?>((f) => f, (next) {
        current = next;
        return null;
      });
      if (failure == null) continue;
      var shown = current;
      if (failure case ServerFailure(statusCode: 409)) {
        await _refetch(current.id);
        if (isClosed) return;
        shown = state.transcript ?? current;
      }
      emit(
        state.copyWith(
          editStatus: EditStatus.failure,
          editFailure: failure,
          transcript: shown,
        ),
      );
      return;
    }
    emit(state.copyWith(editStatus: EditStatus.saved, transcript: current));
  }

  _Step _textStep(String segmentId, String clean) =>
      (t) async => (await _facade.updateSegmentText(
        transcriptId: t.id,
        segmentId: segmentId,
        text: clean,
        revision: t.revision,
      )).map((edit) => _applyEdit(t, edit));

  /// [speakerId] null opens a new speaker.
  _Step _speakerStep(String segmentId, String? speakerId) =>
      (t) async => (await _facade.assignSpeaker(
        transcriptId: t.id,
        segmentId: segmentId,
        speakerId: speakerId,
        revision: t.revision,
      )).map((edit) => _applyEdit(t, edit));

  /// The web's `flush`: a draft that is blank or would store the same
  /// text is not saved.
  List<_Step> _flush(Segment current, String draft) {
    final clean = EditRules.clean(draft);
    if (clean.isEmpty || clean == current.text) return const [];
    return [_textStep(current.id, clean)];
  }

  static Transcript _applySplit(
    Transcript t,
    String segmentId,
    SegmentSplit split,
  ) => t.copyWith(
    revision: split.revision,
    segments: [
      for (final s in t.segments)
        if (s.id == segmentId) ...[split.first, split.second] else s,
    ],
  );

  static Transcript _applyMerge(Transcript t, SegmentMerge merge) => t.copyWith(
    revision: merge.revision,
    segments: [
      for (final s in t.segments)
        if (s.id == merge.segment.id)
          merge.segment
        else if (s.id != merge.removedId)
          s,
    ],
  );

  static Transcript _applyEdit(Transcript t, SegmentEdit edit) {
    final opened = edit.newSpeaker;
    return t.copyWith(
      revision: edit.revision,
      speakers: opened == null || t.speakers.any((s) => s.id == opened.id)
          ? t.speakers
          : [...t.speakers, opened],
      segments: t.segments
          .map((s) => s.id == edit.segment.id ? edit.segment : s)
          .toList(),
    );
  }

  static Segment? _segment(Transcript t, String id) {
    for (final s in t.segments) {
      if (s.id == id) return s;
    }
    return null;
  }

  /// Nothing to send: the editor closes as if it saved.
  void _unchanged() =>
      emit(state.copyWith(editStatus: EditStatus.saved, editFailure: null));

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
