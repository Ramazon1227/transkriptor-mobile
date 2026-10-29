import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/widgets/ai_chat_tab.dart';
import 'package:transkriptor_uz/features/learn/presentation/widgets/learn_tab.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/summary/presentation/widgets/summary_tab.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
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
      // A timecode in an answer seeks the same player the transcript uses.
      1 => AiChatTab(
        transcriptId: widget.transcript.id,
        onSeek: (at) => context.read<PlayerCubit>().seekTo(at, play: true),
      ),
      2 => SummaryTab(transcript: widget.transcript),
      _ => LearnTab(transcript: widget.transcript),
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
