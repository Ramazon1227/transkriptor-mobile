import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
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
  generating,
  success,
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
    @Default(NoteSaveStatus.idle) NoteSaveStatus noteStatus,
    Failure? noteFailure,

    /// A star toggle failed and was undone.
    Failure? favoriteFailure,
  }) = _SummaryState;
}

/// The «Xulosa» tab of one transcript. The template list and the star
/// are real; generation goes through the facade's demo source. Template
/// loading and generation are independent: a failed list keeps the
/// summary and the other way round.
@injectable
class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit(this._facade) : super(const SummaryState());

  final ISummaryFacade _facade;
  Transcript? _transcript;

  /// Bumped by generate and delete: a late summary for an older request
  /// (or one deleted meanwhile) is dropped.
  int _generation = 0;

  /// [transcript] comes from the editor.
  Future<void> start(Transcript transcript) {
    _transcript = transcript;
    if (!canSummarize(transcript)) {
      emit(state.copyWith(status: SummaryStatus.tooShort));
      return Future.value();
    }
    return loadTemplates();
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

  Future<void> generate() async {
    final transcript = _transcript;
    if (transcript == null || state.status == SummaryStatus.tooShort) return;
    final generation = ++_generation;
    emit(
      state.copyWith(
        status: SummaryStatus.generating,
        failure: null,
        noteStatus: NoteSaveStatus.idle,
        noteFailure: null,
      ),
    );
    final result = await _facade.generate(transcript, template: state.template);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: SummaryStatus.failure, failure: failure)),
      (summary) =>
          emit(state.copyWith(status: SummaryStatus.success, summary: summary)),
    );
  }

  /// Confirmed in the tab before it gets here.
  void delete() {
    if (state.status == SummaryStatus.tooShort) return;
    _generation++;
    emit(
      state.copyWith(
        status: SummaryStatus.idle,
        summary: null,
        failure: null,
        noteStatus: NoteSaveStatus.idle,
        noteFailure: null,
      ),
    );
  }

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
  /// kinds in the app's language).
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
}
