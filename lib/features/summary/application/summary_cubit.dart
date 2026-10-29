import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/summary/domain/i_summary_facade.dart';
import 'package:transkriptor_uz/features/summary/domain/summary_rules.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

part 'summary_cubit.freezed.dart';

enum TemplatesStatus { initial, loading, success, failure }

enum SummaryStatus {
  /// Nothing generated yet (or deleted).
  idle,

  /// The transcript is too short to summarise; nothing is offered.
  tooShort,

  /// Asking the server whether a summary exists.
  loading,

  /// Being written (server: PENDING, polled).
  generating,
  success,

  /// The request failed ([SummaryState.failure]) or the server could not
  /// write it ([Summary.error] on [SummaryState.summary]).
  failure,
}

enum NoteSaveStatus { idle, saving, saved, failure }

@freezed
abstract class SummaryState with _$SummaryState {
  const factory SummaryState({
    @Default(TemplatesStatus.initial) TemplatesStatus templatesStatus,
    SummaryTemplateLibrary? library,
    Failure? templatesFailure,

    /// Null: the default template.
    SummaryTemplate? template,
    @Default(SummaryStatus.idle) SummaryStatus status,
    Summary? summary,
    Failure? failure,

    /// The server has no summary API: generation is the demo sample and
    /// the tab says so.
    @Default(false) bool sample,

    /// A delete that did not go through; the summary stays.
    Failure? actionFailure,
    @Default(NoteSaveStatus.idle) NoteSaveStatus noteStatus,
    Failure? noteFailure,

    /// A star toggle failed and was undone.
    Failure? favoriteFailure,
  }) = _SummaryState;
}

/// The «Xulosa» tab of one transcript. Opening reads the stored summary
/// and the template list; a summary is written only when the person
/// presses the button (AI only on request). A PENDING summary is polled
/// until it is DONE or FAILED. Template loading and the summary are
/// independent: a failed list keeps the summary and the other way round.
@injectable
class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit(this._facade, this._policy) : super(const SummaryState());

  final ISummaryFacade _facade;
  final JobPollPolicy _policy;
  Transcript? _transcript;
  Timer? _timer;
  late Duration _interval = _policy.first;

  /// The last failure was the first read, so «retry» reads again instead
  /// of generating.
  bool _loadFailed = false;

  /// Bumped by load, generate and delete: a late answer (or poll) for an
  /// older action is dropped.
  int _generation = 0;

  /// [transcript] comes from the editor.
  Future<void> start(Transcript transcript) async {
    _transcript = transcript;
    if (!canSummarize(transcript)) {
      emit(state.copyWith(status: SummaryStatus.tooShort));
      return;
    }
    await Future.wait([loadTemplates(), _load(transcript.id)]);
  }

  Future<void> loadTemplates() async {
    if (state.templatesStatus == TemplatesStatus.loading) return;
    emit(
      state.copyWith(
        templatesStatus: TemplatesStatus.loading,
        templatesFailure: null,
      ),
    );
    final result = await _facade.templates();
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          templatesStatus: TemplatesStatus.failure,
          templatesFailure: failure,
        ),
      ),
      (library) => emit(
        state.copyWith(
          templatesStatus: TemplatesStatus.success,
          library: library,
          template: state.template ?? library.preferred,
        ),
      ),
    );
  }

  /// Only picks; the person presses «create» (or regenerate) after.
  void selectTemplate(SummaryTemplate template) =>
      emit(state.copyWith(template: template));

  /// The retry button: a failed first read reads again, anything else
  /// generates again.
  Future<void> retry() {
    final transcript = _transcript;
    if (_loadFailed && transcript != null) return _load(transcript.id);
    return generate();
  }

  Future<void> _load(String transcriptId) async {
    _timer?.cancel();
    final generation = ++_generation;
    _loadFailed = false;
    _interval = _policy.first;
    emit(state.copyWith(status: SummaryStatus.loading, failure: null));
    final result = await _facade.load(transcriptId);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) {
        _loadFailed = true;
        emit(state.copyWith(status: SummaryStatus.failure, failure: failure));
      },
      (loaded) {
        emit(state.copyWith(sample: loaded.sample));
        _apply(generation, loaded.summary);
      },
    );
  }

  Future<void> generate() async {
    final transcript = _transcript;
    if (transcript == null ||
        state.status == SummaryStatus.tooShort ||
        state.status == SummaryStatus.generating) {
      return;
    }
    _timer?.cancel();
    final generation = ++_generation;
    _loadFailed = false;
    emit(
      state.copyWith(
        status: SummaryStatus.generating,
        failure: null,
        actionFailure: null,
        noteStatus: NoteSaveStatus.idle,
        noteFailure: null,
      ),
    );
    final result = await _facade.generate(transcript, template: state.template);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: SummaryStatus.failure, failure: failure)),
      (summary) {
        if (summary.sample) emit(state.copyWith(sample: true));
        _interval = _policy.first;
        _apply(generation, summary);
      },
    );
  }

  /// Confirmed in the tab before it gets here. Not optimistic: a failed
  /// delete keeps the summary and says so.
  Future<void> delete() async {
    final transcript = _transcript;
    if (transcript == null || state.status == SummaryStatus.tooShort) return;
    _timer?.cancel();
    final generation = ++_generation;
    final result = await _facade.delete(transcript.id);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) => emit(state.copyWith(actionFailure: failure)),
      (_) => emit(
        state.copyWith(
          status: SummaryStatus.idle,
          summary: null,
          failure: null,
          actionFailure: null,
          noteStatus: NoteSaveStatus.idle,
          noteFailure: null,
        ),
      ),
    );
  }

  /// Shows [summary] by its progress; a PENDING one is polled.
  void _apply(int generation, Summary? summary) {
    if (summary == null) {
      emit(state.copyWith(status: SummaryStatus.idle, summary: null));
      return;
    }
    switch (summary.progress) {
      case SummaryProgress.pending:
        emit(
          state.copyWith(status: SummaryStatus.generating, summary: summary),
        );
        _schedule(generation);
      case SummaryProgress.failed:
        emit(
          state.copyWith(
            status: SummaryStatus.failure,
            summary: summary,
            failure: null,
          ),
        );
      case SummaryProgress.done || SummaryProgress.unknown:
        emit(
          state.copyWith(
            status: SummaryStatus.success,
            summary: summary,
            failure: null,
          ),
        );
    }
  }

  void _schedule(int generation) {
    _timer?.cancel();
    _timer = Timer(_interval, () => unawaited(_poll(generation)));
  }

  Future<void> _poll(int generation) async {
    final transcript = _transcript;
    if (transcript == null) return;
    final result = await _facade.refresh(transcript.id);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) {
        // One dropped connection must not end the wait; anything else
        // (403, 404: the transcript is gone) stops it.
        if (_isTransient(failure)) {
          _interval = _policy.max;
          _schedule(generation);
          return;
        }
        emit(state.copyWith(status: SummaryStatus.failure, failure: failure));
      },
      (summary) {
        _interval = _policy.next(_interval, changed: false);
        _apply(generation, summary);
      },
    );
  }

  static bool _isTransient(Failure f) => switch (f) {
    NetworkFailure() || TimeoutFailure() => true,
    ServerFailure(:final statusCode) => statusCode == null || statusCode >= 500,
    _ => false,
  };

  /// Optimistic: the star flips at once and flips back on failure.
  Future<void> toggleFavorite(SummaryTemplate template) async {
    final library = state.library;
    if (library == null) return;
    final next = !template.favorite;
    emit(
      state.copyWith(
        library: library.withFavorite(template.id, favorite: next),
        template: state.template?.id == template.id
            ? state.template?.copyWith(favorite: next)
            : state.template,
        favoriteFailure: null,
      ),
    );
    final result = await _facade.setFavorite(template.id, favorite: next);
    if (isClosed) return;
    result.fold(
      (failure) {
        final current = state.library;
        emit(
          state.copyWith(
            library: current?.withFavorite(template.id, favorite: !next),
            template: state.template?.id == template.id
                ? state.template?.copyWith(favorite: !next)
                : state.template,
            favoriteFailure: failure,
          ),
        );
      },
      (stored) {
        if (stored == next) return;
        emit(
          state.copyWith(
            library: state.library?.withFavorite(template.id, favorite: stored),
          ),
        );
      },
    );
  }

  /// [sections] carry their resolved titles (the tab names the known
  /// kinds in the app's language); a server summary goes as its own
  /// Tiptap body instead.
  Future<void> saveAsNote({
    required String title,
    required List<SummarySection> sections,
  }) async {
    final transcript = _transcript;
    if (transcript == null ||
        state.summary == null ||
        state.noteStatus == NoteSaveStatus.saving) {
      return;
    }
    emit(state.copyWith(noteStatus: NoteSaveStatus.saving, noteFailure: null));
    final result = await _facade.saveAsNote(
      transcriptId: transcript.id,
      title: title,
      sections: sections,
      body: state.summary?.body,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          noteStatus: NoteSaveStatus.failure,
          noteFailure: failure,
        ),
      ),
      (_) => emit(state.copyWith(noteStatus: NoteSaveStatus.saved)),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
