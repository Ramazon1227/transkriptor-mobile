import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/tab_placeholder.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/transcript_tab.dart';

/// Transkript · AI suhbat · Xulosa · Oʻrganish, underlined. A tab is built
/// the first time it is opened and then kept, so switching back finds it
/// as it was (scroll, a typed question, a loaded summary).
class EditorTabs extends StatefulWidget {
  const EditorTabs({required this.transcript, super.key});

  /// Loaded; the tabs other than Transkript take it as it is now.
  final Transcript transcript;

  @override
  State<EditorTabs> createState() => _EditorTabsState();
}

class _EditorTabsState extends State<EditorTabs>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 4, vsync: this)
    ..addListener(_onTab);
  final Set<int> _opened = {0};

  void _onTab() {
    if (!mounted) return;
    setState(() => _opened.add(_tabs.index));
  }

  @override
  void dispose() {
    _tabs
      ..removeListener(_onTab)
      ..dispose();
    super.dispose();
  }

  Widget _tab(int i) {
    if (!_opened.contains(i)) return const SizedBox.shrink();
    return switch (i) {
      0 => const TranscriptTab(),
      // M-R5: AiChatTab(transcriptId: widget.transcript.id)
      1 => const TabPlaceholder(icon: Icons.forum_outlined),
      // M-R5: SummaryTab(transcript: widget.transcript)
      2 => const TabPlaceholder(icon: Icons.notes_rounded),
      // M-R5: LearnTab(transcript: widget.transcript)
      _ => const TabPlaceholder(icon: Icons.school_outlined),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabBar(
          key: const Key('editor_tabs'),
          controller: _tabs,
          isScrollable: true,
          tabs: [
            Tab(text: l10n.editorTabTranscript),
            Tab(text: l10n.editorTabAiChat),
            Tab(text: l10n.editorTabSummary),
            Tab(text: l10n.editorTabLearn),
          ],
        ),
        Expanded(
          child: IndexedStack(
            index: _tabs.index,
            sizing: StackFit.expand,
            children: [for (var i = 0; i < 4; i++) _tab(i)],
          ),
        ),
      ],
    );
  }
}
