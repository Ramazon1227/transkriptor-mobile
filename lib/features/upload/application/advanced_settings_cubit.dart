import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';
import 'package:transkriptor_uz/features/glossary/domain/entities/glossary.dart';
import 'package:transkriptor_uz/features/glossary/domain/i_glossary_facade.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/upload/domain/advanced_rules.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/advanced_options.dart';

part 'advanced_settings_cubit.freezed.dart';

/// The four folds of the panel; one is open at a time.
enum AdvancedSection { terms, destination, hints, speakers }

/// One of the destination workspace's lists (folders, glossaries,
/// balance). Each loads on its own: one failing keeps the others.
enum AdvancedLoad { initial, loading, success, failure }

@freezed
abstract class AdvancedSettingsState with _$AdvancedSettingsState {
  const factory AdvancedSettingsState({
    /// What «Saqlash» hands back; the page's choice until then.
    required AdvancedOptions draft,

    /// Where the file may go: the workspaces the person can write to.
    @Default(<Workspace>[]) List<Workspace> workspaces,

    /// A file of this upload already reached the server with its
    /// destination; workspace and folder cannot change.
    @Default(false) bool destinationLocked,

    /// Local files that can be played to mark speakers; empty for a link.
    @Default(<HintSource>[]) List<HintSource> sources,

    /// The file whose hints are shown.
    String? sourceKey,
    @Default(AdvancedSection.terms) AdvancedSection? open,
    @Default(AdvancedLoad.initial) AdvancedLoad foldersStatus,
    @Default(<Folder>[]) List<Folder> folders,
    @Default(AdvancedLoad.initial) AdvancedLoad glossariesStatus,
    @Default(<Glossary>[]) List<Glossary> glossaries,
    @Default(AdvancedLoad.initial) AdvancedLoad balanceStatus,
    int? balanceSeconds,

    /// Why the last «Qoʻshish» was refused; cleared by the next try.
    AdvancedProblem? hintProblem,
  }) = _AdvancedSettingsState;

  const AdvancedSettingsState._();

  /// What blocks «Saqlash», or null.
  AdvancedProblem? get problem => AdvancedRules.saveProblem(
    termsText: draft.termsText,
    speakers: draft.numSpeakers,
    hints: draft.hints.values,
  );

  /// The chosen workspace is the personal one: its no-folder place is
  /// «Mening fayllarim», a team's is «Umumiy fayllar».
  bool get personalDestination {
    for (final w in workspaces) {
      if (w.id == draft.workspaceId) return w.isPersonal;
    }
    return false;
  }

  HintSource? get source {
    for (final s in sources) {
      if (s.key == sourceKey) return s;
    }
    return sources.isEmpty ? null : sources.first;
  }

  List<SpeakerHint> get sourceHints {
    final key = source?.key;
    return key == null ? const [] : draft.hints[key] ?? const [];
  }
}

/// «Qoʻshimcha sozlamalar» (ClickUp A-0…A-4): edits a draft of one
/// upload's options. Nothing is stored: the page hands the draft back on
/// «Saqlash» and drops it on back.
@injectable
class AdvancedSettingsCubit extends Cubit<AdvancedSettingsState> {
  AdvancedSettingsCubit(this._library, this._glossaries, this._billing)
    : super(
        AdvancedSettingsState(draft: AdvancedOptions.initial(workspaceId: '')),
      );

  final ILibraryFacade _library;
  final IGlossaryFacade _glossaries;
  final IBillingFacade _billing;

  /// Bumped on every workspace change; a late answer for the previous
  /// workspace is dropped.
  int _generation = 0;

  /// [initial] is the page's current choice. [workspaces] are every
  /// workspace of the account; those the person cannot write to are left
  /// out, except the one already chosen.
  void start({
    required AdvancedOptions initial,
    required List<Workspace> workspaces,
    List<HintSource> sources = const [],
    bool destinationLocked = false,
  }) {
    var draft = initial;
    if (draft.workspaceName.isEmpty) {
      for (final w in workspaces) {
        if (w.id == draft.workspaceId) {
          draft = draft.copyWith(workspaceName: w.name);
        }
      }
    }
    emit(
      AdvancedSettingsState(
        draft: draft,
        workspaces: [
          for (final w in workspaces)
            if (w.role.canWrite || w.id == initial.workspaceId) w,
        ],
        sources: sources,
        sourceKey: sources.isEmpty ? null : sources.first.key,
        destinationLocked: destinationLocked,
      ),
    );
    unawaited(_load(initial.workspaceId));
  }

  /// After a failed list.
  Future<void> retry() => _load(state.draft.workspaceId);

  void toggle(AdvancedSection section) =>
      emit(state.copyWith(open: state.open == section ? null : section));

  void setTerms(String text) =>
      emit(state.copyWith(draft: state.draft.copyWith(termsText: text)));

  /// Null: no list.
  void selectGlossary(Glossary? glossary) => emit(
    state.copyWith(
      draft: state.draft.copyWith(
        glossaryId: glossary?.id,
        glossaryName: glossary?.name ?? '',
      ),
    ),
  );

  /// Folders and lists belong to a workspace: changing it clears both.
  void selectWorkspace(Workspace workspace) {
    if (state.destinationLocked || workspace.id == state.draft.workspaceId) {
      return;
    }
    emit(
      state.copyWith(
        draft: state.draft.copyWith(
          workspaceId: workspace.id,
          workspaceName: workspace.name,
          folderId: null,
          folderName: '',
          glossaryId: null,
          glossaryName: '',
        ),
        folders: const [],
        glossaries: const [],
        balanceSeconds: null,
      ),
    );
    unawaited(_load(workspace.id));
  }

  /// Null: no folder.
  void selectFolder(Folder? folder) {
    if (state.destinationLocked) return;
    emit(
      state.copyWith(
        draft: state.draft.copyWith(
          folderId: folder?.id,
          folderName: folder?.name ?? '',
        ),
      ),
    );
  }

  /// Null is Auto.
  void setSpeakers(int? count) =>
      emit(state.copyWith(draft: state.draft.copyWith(numSpeakers: count)));

  void selectSource(String key) =>
      emit(state.copyWith(sourceKey: key, hintProblem: null));

  /// Adds «[label]: [start]–[end]» to the shown file. [length] is the
  /// file's, when the player knows it. True when it was added; otherwise
  /// [AdvancedSettingsState.hintProblem] says why.
  bool addHint({
    required String label,
    required String start,
    required String end,
    Duration? length,
  }) {
    final source = state.source;
    if (source == null) return false;
    final s = AdvancedRules.parseTime(start);
    final e = AdvancedRules.parseTime(end);
    if (s == null || e == null) {
      emit(state.copyWith(hintProblem: const HintBadTime()));
      return false;
    }
    // Half a second of slack: the player's length is rounded.
    if (length != null &&
        length > Duration.zero &&
        e > length.inMilliseconds + 500) {
      emit(state.copyWith(hintProblem: const HintPastEnd()));
      return false;
    }
    final next = SpeakerHint(label: label, startMs: s, endMs: e);
    final existing = state.sourceHints;
    final problem = AdvancedRules.hintProblem(
      next,
      existing,
      state.draft.numSpeakers,
    );
    if (problem != null) {
      emit(state.copyWith(hintProblem: problem));
      return false;
    }
    _setHints(source.key, AdvancedRules.addHint(next, existing));
    return true;
  }

  void removeHint(SpeakerHint hint) {
    final source = state.source;
    if (source == null) return;
    _setHints(source.key, [
      for (final h in state.sourceHints)
        if (h != hint) h,
    ]);
  }

  /// The draft to apply, or null while [AdvancedSettingsState.problem]
  /// blocks it.
  AdvancedOptions? save() => state.problem == null ? state.draft : null;

  void _setHints(String key, List<SpeakerHint> hints) {
    final all = {...state.draft.hints};
    if (hints.isEmpty) {
      all.remove(key);
    } else {
      all[key] = hints;
    }
    emit(
      state.copyWith(
        draft: state.draft.copyWith(hints: all),
        hintProblem: null,
      ),
    );
  }

  Future<void> _load(String workspaceId) async {
    if (workspaceId.isEmpty) return;
    final generation = ++_generation;
    bool current() =>
        !isClosed &&
        generation == _generation &&
        state.draft.workspaceId == workspaceId;
    emit(
      state.copyWith(
        foldersStatus: AdvancedLoad.loading,
        glossariesStatus: AdvancedLoad.loading,
        balanceStatus: AdvancedLoad.loading,
      ),
    );
    await Future.wait([
      _library.getFolders(workspaceId: workspaceId).then((r) {
        if (!current()) return;
        r.fold(
          (_) => emit(state.copyWith(foldersStatus: AdvancedLoad.failure)),
          (folders) => emit(
            state.copyWith(
              foldersStatus: AdvancedLoad.success,
              folders: folders,
            ),
          ),
        );
      }),
      _glossaries.glossaries(workspaceId: workspaceId).then((r) {
        if (!current()) return;
        r.fold(
          (_) => emit(state.copyWith(glossariesStatus: AdvancedLoad.failure)),
          (lists) => emit(
            state.copyWith(
              glossariesStatus: AdvancedLoad.success,
              glossaries: lists,
            ),
          ),
        );
      }),
      _billing.balance(workspaceId).then((r) {
        if (!current()) return;
        r.fold(
          (_) => emit(state.copyWith(balanceStatus: AdvancedLoad.failure)),
          (b) => emit(
            state.copyWith(
              balanceStatus: AdvancedLoad.success,
              balanceSeconds: b.balanceSeconds,
            ),
          ),
        );
      }),
    ]);
  }
}
