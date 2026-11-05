import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/core/widgets/demo_banner.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/upload/application/advanced_settings_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/advanced_rules.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/advanced_options.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/advanced_problem_text.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/advanced_settings_tile.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/hint_editor.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/speaker_count_picker.dart';

/// «Qoʻshimcha sozlamalar» (ClickUp A-0…A-4): terms, destination, speaker
/// hints and speaker count in four folds, and «Saqlash». The choice is
/// for this upload only: «Saqlash» hands it back, back drops it.
class AdvancedSettingsPage extends StatelessWidget {
  const AdvancedSettingsPage({
    required this.value,
    required this.workspaces,
    this.sources = const [],
    this.destinationLocked = false,
    this.hintsNote,
    super.key,
  });

  final AdvancedOptions value;

  /// Every workspace of the account; the page keeps the writable ones.
  final List<Workspace> workspaces;

  /// Local files that can be played to mark speakers.
  final List<HintSource> sources;

  /// A file already went to the server with its destination.
  final bool destinationLocked;

  /// Shown instead of the hint editor when [sources] is empty.
  final String? hintsNote;

  /// The saved choice, or null when the person went back.
  static Future<AdvancedOptions?> open(
    BuildContext context, {
    required AdvancedOptions value,
    required List<Workspace> workspaces,
    List<HintSource> sources = const [],
    bool destinationLocked = false,
    String? hintsNote,
  }) => Navigator.of(context).push<AdvancedOptions>(
    MaterialPageRoute(
      builder: (_) => AdvancedSettingsPage(
        value: value,
        workspaces: workspaces,
        sources: sources,
        destinationLocked: destinationLocked,
        hintsNote: hintsNote,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdvancedSettingsCubit>()
        ..start(
          initial: value,
          workspaces: workspaces,
          sources: sources,
          destinationLocked: destinationLocked,
        ),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(context.l10n.advancedTitle),
        ),
        body: SafeArea(
          child: ContentWidth(child: _Body(hintsNote: hintsNote)),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({this.hintsNote});

  final String? hintsNote;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AdvancedSettingsCubit, AdvancedSettingsState>(
      builder: (context, state) {
        final cubit = context.read<AdvancedSettingsCubit>();
        final draft = state.draft;
        final problem = state.problem;
        final termCount = draft.terms.length;
        final list = draft.glossaryId == null ? '' : draft.glossaryName;
        final folder = draft.folderId == null
            ? rootFolderLabel(l10n, personal: state.personalDestination)
            : draft.folderName;
        final hintCount = draft.hintCount;
        final speakers = draft.numSpeakers;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _Fold(
              section: AdvancedSection.terms,
              title: l10n.advancedTermsTitle,
              value: [
                if (list.isNotEmpty) list,
                if (termCount > 0) l10n.advancedTermsCount(termCount),
              ].join(' · ').ifEmpty(l10n.advancedNone),
              child: const _TermsSection(),
            ),
            _Fold(
              section: AdvancedSection.destination,
              title: l10n.advancedDestTitle,
              value: '${draft.workspaceName} › $folder'.trim(),
              child: const _DestinationSection(),
            ),
            _Fold(
              section: AdvancedSection.hints,
              title: l10n.advancedHintsTitle,
              value: hintCount > 0
                  ? l10n.advancedHintsCount(hintCount)
                  : l10n.advancedNone,
              child: _HintsSection(note: hintsNote),
            ),
            _Fold(
              section: AdvancedSection.speakers,
              title: l10n.advancedSpeakersTitle,
              value: speakers == null
                  ? l10n.advancedSpeakersAuto
                  : l10n.advancedSpeakersCount(speakers),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.advancedSpeakersText, style: AppText.caption),
                  const SizedBox(height: 12),
                  SpeakerCountPicker(
                    value: speakers,
                    showLabel: false,
                    onChanged: cubit.setSpeakers,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (problem != null) ...[
              Text(
                advancedProblemText(l10n, problem),
                key: const Key('advanced_problem'),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 12),
            ],
            FilledButton(
              key: const Key('advanced_save'),
              onPressed: problem != null
                  ? null
                  : () {
                      final saved = cubit.save();
                      if (saved != null) Navigator.of(context).pop(saved);
                    },
              child: Text(l10n.advancedSave),
            ),
            const SizedBox(height: 10),
            Text(l10n.advancedFoot, style: AppText.caption),
          ],
        );
      },
    );
  }
}

extension on String {
  String ifEmpty(String other) => isEmpty ? other : this;
}

/// One collapsible section: a header with the title and what is chosen,
/// the body only while open. One fold is open at a time.
class _Fold extends StatelessWidget {
  const _Fold({
    required this.section,
    required this.title,
    required this.value,
    required this.child,
  });

  final AdvancedSection section;
  final String title;
  final String value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final open = context.select<AdvancedSettingsCubit, bool>(
      (c) => c.state.open == section,
    );
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.sf2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            button: true,
            expanded: open,
            child: InkWell(
              key: Key('advanced_fold_${section.name}'),
              onTap: () =>
                  context.read<AdvancedSettingsCubit>().toggle(section),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 56),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          title,
                          style: AppText.body.copyWith(color: AppColors.cotton),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Text(
                          value,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.mono.copyWith(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        open
                            ? Icons.expand_less_rounded
                            : Icons.expand_more_rounded,
                        color: AppColors.mutedDark,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (open)
            Padding(padding: const EdgeInsets.only(bottom: 20), child: child),
        ],
      ),
    );
  }
}

Widget _label(String text) => Padding(
  padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
  child: Text(text.toUpperCase(), style: AppText.label),
);

Widget _check(bool on) => on
    ? const Icon(Icons.check, size: 18, color: AppColors.accent)
    : const SizedBox(width: 18);

/// A list that failed to load: what, and a retry.
class _LoadFailed extends StatelessWidget {
  const _LoadFailed({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
        TextButton(
          onPressed: context.read<AdvancedSettingsCubit>().retry,
          child: Text(context.l10n.retry),
        ),
      ],
    );
  }
}

const Widget _loading = Padding(
  padding: EdgeInsets.all(12),
  child: Center(
    child: SizedBox.square(
      dimension: 20,
      child: CircularProgressIndicator(strokeWidth: 2),
    ),
  ),
);

/// A-1: one of the workspace's lists and free terms for this file.
class _TermsSection extends StatefulWidget {
  const _TermsSection();

  @override
  State<_TermsSection> createState() => _TermsSectionState();
}

class _TermsSectionState extends State<_TermsSection> {
  late final TextEditingController _text = TextEditingController(
    text: context.read<AdvancedSettingsCubit>().state.draft.termsText,
  );

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AdvancedSettingsCubit, AdvancedSettingsState>(
      buildWhen: (p, n) =>
          p.draft.termsText != n.draft.termsText ||
          p.draft.glossaryId != n.draft.glossaryId ||
          p.glossaries != n.glossaries ||
          p.glossariesStatus != n.glossariesStatus,
      builder: (context, state) {
        final cubit = context.read<AdvancedSettingsCubit>();
        final count = state.draft.terms.length;
        final problem = AdvancedRules.termsProblem(state.draft.termsText);
        final chosen = state.draft.glossaryId;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.advancedTermsText, style: AppText.caption),
            _label(l10n.advancedTermsList),
            if (state.glossariesStatus == AdvancedLoad.loading &&
                state.glossaries.isEmpty)
              _loading
            else if (state.glossariesStatus == AdvancedLoad.failure)
              _LoadFailed(text: l10n.advancedTermsListsFailed)
            else
              ActionGroup(
                children: [
                  ActionRow(
                    key: const Key('advanced_glossary_none'),
                    label: l10n.advancedTermsNoList,
                    showChevron: false,
                    trailing: _check(chosen == null),
                    onTap: () => cubit.selectGlossary(null),
                  ),
                  for (final g in state.glossaries)
                    ActionRow(
                      key: Key('advanced_glossary_${g.id}'),
                      label: g.name,
                      value: '${g.termCount}',
                      showChevron: false,
                      trailing: _check(chosen == g.id),
                      onTap: () => cubit.selectGlossary(g),
                    ),
                ],
              ),
            _label(l10n.advancedTermsFree),
            TextField(
              key: const Key('advanced_terms'),
              controller: _text,
              minLines: 4,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              autocorrect: false,
              enableSuggestions: false,
              onChanged: cubit.setTerms,
              decoration: InputDecoration(
                hintText: l10n.advancedTermsPlaceholder,
                errorText: problem == null
                    ? null
                    : advancedProblemText(l10n, problem),
                errorMaxLines: 3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.advancedTermsCounter(count, AdvancedRules.maxTerms),
              style: AppText.mono.copyWith(
                fontSize: 12,
                color: count > AdvancedRules.maxTerms
                    ? Theme.of(context).colorScheme.error
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            Text(l10n.advancedTermsNote, style: AppText.caption),
          ],
        );
      },
    );
  }
}

/// A-2: a workspace the person can write to, and one of its folders.
class _DestinationSection extends StatelessWidget {
  const _DestinationSection();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AdvancedSettingsCubit, AdvancedSettingsState>(
      buildWhen: (p, n) =>
          p.draft.workspaceId != n.draft.workspaceId ||
          p.draft.folderId != n.draft.folderId ||
          p.folders != n.folders ||
          p.foldersStatus != n.foldersStatus ||
          p.balanceSeconds != n.balanceSeconds ||
          p.workspaces != n.workspaces ||
          p.destinationLocked != n.destinationLocked,
      builder: (context, state) {
        final cubit = context.read<AdvancedSettingsCubit>();
        final locked = state.destinationLocked;
        final draft = state.draft;
        int? fallback;
        for (final w in state.workspaces) {
          if (w.id == draft.workspaceId) fallback = w.balanceSeconds;
        }
        final balance = state.balanceSeconds ?? fallback;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.advancedDestText, style: AppText.caption),
            if (locked) ...[
              const SizedBox(height: 10),
              Text(
                l10n.advancedDestLocked,
                key: const Key('advanced_dest_locked'),
                style: AppText.caption.copyWith(color: AppColors.warn),
              ),
            ],
            _label(l10n.advancedDestWorkspace),
            ActionGroup(
              children: [
                for (final w in state.workspaces)
                  ActionRow(
                    key: Key('advanced_ws_${w.id}'),
                    label: w.isPersonal
                        ? l10n.advancedDestPersonal(w.name)
                        : w.name,
                    showChevron: false,
                    trailing: _check(w.id == draft.workspaceId),
                    onTap: locked ? null : () => cubit.selectWorkspace(w),
                  ),
              ],
            ),
            _label(l10n.advancedDestFolder),
            if (state.foldersStatus == AdvancedLoad.loading &&
                state.folders.isEmpty)
              _loading
            else if (state.foldersStatus == AdvancedLoad.failure)
              _LoadFailed(text: l10n.advancedDestFoldersFailed)
            else
              ActionGroup(
                children: [
                  ActionRow(
                    key: const Key('advanced_folder_none'),
                    icon: Icons.inbox_outlined,
                    label: rootFolderLabel(
                      l10n,
                      personal: state.personalDestination,
                    ),
                    showChevron: false,
                    trailing: _check(draft.folderId == null),
                    onTap: locked ? null : () => cubit.selectFolder(null),
                  ),
                  for (final f in state.folders)
                    ActionRow(
                      key: Key('advanced_folder_${f.id}'),
                      icon: Icons.folder_outlined,
                      label: f.name,
                      showChevron: false,
                      trailing: _check(draft.folderId == f.id),
                      onTap: locked ? null : () => cubit.selectFolder(f),
                    ),
                ],
              ),
            if (balance != null) ...[
              const SizedBox(height: 12),
              Text(
                l10n.advancedDestBalance(
                  l10n.minutesShort(Formatters.minutesLeft(balance)),
                ),
                style: AppText.mono.copyWith(fontSize: 13),
              ),
            ],
          ],
        );
      },
    );
  }
}

/// A-3: play a picked file and tie intervals to names. «Namuna»: the STT
/// service does not take them yet.
class _HintsSection extends StatelessWidget {
  const _HintsSection({this.note});

  final String? note;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AdvancedSettingsCubit, AdvancedSettingsState>(
      buildWhen: (p, n) =>
          p.sources != n.sources || p.source?.key != n.source?.key,
      builder: (context, state) {
        final source = state.source;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DemoBanner(message: l10n.advancedHintsDemo),
            const SizedBox(height: 12),
            Text(l10n.advancedHintsText, style: AppText.caption),
            const SizedBox(height: 12),
            if (source == null)
              Text(
                note ?? l10n.advancedHintsNoFile,
                key: const Key('advanced_hints_note'),
                style: AppText.caption.copyWith(color: AppColors.cotton),
              )
            else ...[
              if (state.sources.length > 1) ...[
                _label(l10n.advancedHintsFile),
                ActionGroup(
                  children: [
                    for (final s in state.sources)
                      ActionRow(
                        key: Key('advanced_source_${s.key}'),
                        icon: Icons.graphic_eq_rounded,
                        label: s.name,
                        showChevron: false,
                        trailing: _check(s.key == source.key),
                        onTap: () => context
                            .read<AdvancedSettingsCubit>()
                            .selectSource(s.key),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              HintEditor(key: ValueKey(source.key), source: source),
            ],
          ],
        );
      },
    );
  }
}
