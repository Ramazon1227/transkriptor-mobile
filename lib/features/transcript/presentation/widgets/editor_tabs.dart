import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/ai_chat/presentation/widgets/ai_chat_tab.dart';
import 'package:transkriptor_uz/features/learn/presentation/widgets/learn_tab.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/sentiment/application/sentiment_cubit.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';
import 'package:transkriptor_uz/features/sentiment/presentation/widgets/sentiment_tab.dart';
import 'package:transkriptor_uz/features/summary/presentation/widgets/summary_tab.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/transcript_tab.dart';

/// Transkript · AI suhbat · Xulosa · Oʻrganish · Tahlil, underlined. A tab
/// is built the first time it is opened and then kept, so switching back
/// finds it as it was (scroll, a typed question, a loaded summary).
///
/// The sentiment analysis is shared by two tabs: «Tahlil» shows it and
/// the Transkript tab marks labelled segments. Its cubit is made when
/// «Tahlil» is first opened (one GET, no analysis is started) and polls
/// only while that tab is the one in view.
class EditorTabs extends StatefulWidget {
  const EditorTabs({required this.transcript, super.key});

  /// Loaded; the tabs other than Transkript take it as it is now.
  final Transcript transcript;

  @override
  State<EditorTabs> createState() => _EditorTabsState();
}

class _EditorTabsState extends State<EditorTabs>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: _count, vsync: this)
    ..addListener(_onTab);
  final Set<int> _opened = {0};

  static const int _count = 5;
  static const int _sentimentTab = 4;

  SentimentCubit? _sentiment;
  StreamSubscription<SentimentState>? _sentimentSub;

  /// Segment id → label, for the Transkript tab's markers.
  Map<String, SentimentLabel> _labels = const {};

  void _onTab() {
    if (!mounted) return;
    final i = _tabs.index;
    if (i == _sentimentTab && _sentiment == null) {
      final cubit = getIt<SentimentCubit>();
      _sentiment = cubit;
      _sentimentSub = cubit.stream.listen((s) {
        if (mounted && !identical(s.labels, _labels)) {
          setState(() => _labels = s.labels);
        }
      });
      unawaited(cubit.load(widget.transcript.id));
    } else {
      unawaited(_sentiment?.setActive(active: i == _sentimentTab));
    }
    setState(() => _opened.add(i));
  }

  @override
  void dispose() {
    _tabs
      ..removeListener(_onTab)
      ..dispose();
    unawaited(_sentimentSub?.cancel());
    unawaited(_sentiment?.close());
    super.dispose();
  }

  Widget _tab(int i) {
    if (!_opened.contains(i)) return const SizedBox.shrink();
    return switch (i) {
      0 => TranscriptTab(sentiment: _labels),
      // A timecode in an answer seeks the same player the transcript uses.
      1 => AiChatTab(
        transcriptId: widget.transcript.id,
        onSeek: (at) => context.read<PlayerCubit>().seekTo(at, play: true),
      ),
      2 => SummaryTab(transcript: widget.transcript),
      3 => LearnTab(transcript: widget.transcript),
      _ => BlocProvider<SentimentCubit>.value(
        value: _sentiment!,
        child: SentimentTab(speakers: widget.transcript.speakers),
      ),
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
            Tab(text: l10n.editorTabSentiment),
          ],
        ),
        Expanded(
          child: IndexedStack(
            index: _tabs.index,
            sizing: StackFit.expand,
            children: [for (var i = 0; i < _count; i++) _tab(i)],
          ),
        ),
      ],
    );
  }
}
