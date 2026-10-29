import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_empty_view.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/follow_along.dart';
import 'package:transkriptor_uz/features/transcript/presentation/editor_actions.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/segment_tile.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/speaker_filter_bar.dart';

/// The Transkript tab: toolbar, the edit-mode hint, the segments. While
/// the player plays, the segment under the playhead is highlighted and
/// kept in view — until the person scrolls on their own; «Joriy joyga»
/// brings the following back.
class TranscriptTab extends StatefulWidget {
  const TranscriptTab({this.sentiment = const {}, super.key});

  /// Segment id → sentiment label of a finished analysis; a labelled
  /// segment gets a small marker. Empty: no markers.
  final Map<String, SentimentLabel> sentiment;

  @override
  State<TranscriptTab> createState() => _TranscriptTabState();
}

class _TranscriptTabState extends State<TranscriptTab> {
  final ScrollController _scroll = ScrollController();
  final Map<String, GlobalKey> _keys = {};

  /// Auto-scroll on; a manual scroll turns it off.
  bool _follow = true;
  bool _filterOpen = false;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  GlobalKey _keyOf(String id) => _keys.putIfAbsent(id, GlobalKey.new);

  static String? _activeOf(TranscriptState t, PlayerState p) =>
      p.canPlay ? FollowAlong.activeId(t.visibleSegments, p.position) : null;

  /// Brings [id] into view. A tile far off is not built yet: jump to
  /// where it should roughly be, then let the built tile settle it.
  void _reveal(String id, {bool animate = true}) {
    final tile = _keys[id]?.currentContext;
    if (tile != null) {
      Scrollable.ensureVisible(
        tile,
        alignment: .25,
        duration: animate ? const Duration(milliseconds: 250) : Duration.zero,
      );
      return;
    }
    if (!_scroll.hasClients) return;
    final segments = context.read<TranscriptCubit>().state.visibleSegments;
    final i = segments.indexWhere((s) => s.id == id);
    if (i < 0 || segments.isEmpty) return;
    final max = _scroll.position.maxScrollExtent;
    _scroll.jumpTo(max * i / segments.length);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final built = _keys[id]?.currentContext;
      if (mounted && built != null) {
        Scrollable.ensureVisible(built, alignment: .25);
      }
    });
  }

  void _resumeFollow() {
    setState(() => _follow = true);
    final id = _activeOf(
      context.read<TranscriptCubit>().state,
      context.read<PlayerCubit>().state,
    );
    if (id != null) _reveal(id);
  }

  bool _onScroll(UserScrollNotification n) {
    if (n.direction != ScrollDirection.idle && _follow) {
      setState(() => _follow = false);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<TranscriptCubit, TranscriptState>(
      buildWhen: (p, n) =>
          p.transcript != n.transcript ||
          p.speakerFilter != n.speakerFilter ||
          p.showSpeakers != n.showSpeakers ||
          p.editMode != n.editMode,
      builder: (context, state) {
        final transcript = state.transcript!;
        if (transcript.segments.isEmpty) {
          return AppEmptyView(message: l10n.transcriptEmpty);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Toolbar(
              state: state,
              filterOpen: _filterOpen || state.speakerFilter != null,
              onFilter: () => setState(() => _filterOpen = !_filterOpen),
            ),
            Expanded(
              child: BlocListener<PlayerCubit, PlayerState>(
                listenWhen: (p, n) =>
                    _follow &&
                    n.playing &&
                    _activeOf(state, p) != _activeOf(state, n),
                listener: (context, player) {
                  final id = _activeOf(state, player);
                  if (id != null) _reveal(id);
                },
                child: Stack(
                  children: [
                    NotificationListener<UserScrollNotification>(
                      onNotification: _onScroll,
                      child: _Segments(
                        state: state,
                        controller: _scroll,
                        keyOf: _keyOf,
                        sentiment: widget.sentiment,
                        // In the list, not above it: on a short screen
                        // they scroll away instead of squeezing the text.
                        header: [
                          if (_filterOpen || state.speakerFilter != null)
                            SpeakerFilterBar(
                              speakers: transcript.speakers,
                              selected: state.speakerFilter,
                              onChanged: context
                                  .read<TranscriptCubit>()
                                  .filterSpeaker,
                            ),
                          if (state.editMode) const _EditHint(),
                        ],
                      ),
                    ),
                    if (!_follow)
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: BlocSelector<PlayerCubit, PlayerState, bool>(
                          selector: (p) => p.canPlay,
                          builder: (context, canPlay) => canPlay
                              ? FilledButton.tonalIcon(
                                  key: const Key('follow_resume'),
                                  onPressed: _resumeFollow,
                                  icon: const Icon(
                                    Icons.my_location_rounded,
                                    size: 18,
                                  ),
                                  label: Text(l10n.editorFollow),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Segments extends StatelessWidget {
  const _Segments({
    required this.state,
    required this.controller,
    required this.keyOf,
    required this.header,
    required this.sentiment,
  });

  final Map<String, SentimentLabel> sentiment;

  /// Filter bar and edit hint, first in the list.
  final List<Widget> header;
  final TranscriptState state;
  final ScrollController controller;
  final GlobalKey Function(String) keyOf;

  @override
  Widget build(BuildContext context) {
    final transcript = state.transcript!;
    final speakers = {for (final s in transcript.speakers) s.id: s};
    final segments = state.visibleSegments;
    return BlocBuilder<PlayerCubit, PlayerState>(
      // Rebuilt when the highlighted segment or playability changes, not
      // on every position tick.
      buildWhen: (p, n) =>
          p.canPlay != n.canPlay ||
          _TranscriptTabState._activeOf(state, p) !=
              _TranscriptTabState._activeOf(state, n),
      builder: (context, player) {
        final active = _TranscriptTabState._activeOf(state, player);
        final canPlay = player.canPlay;
        return ListView.builder(
          key: const Key('transcript_segments'),
          controller: controller,
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 72),
          itemCount: segments.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: header,
              );
            }
            final segment = segments[index - 1];
            return SegmentTile(
              key: keyOf(segment.id),
              segment: segment,
              speaker: speakers[segment.speakerId],
              showSpeaker: state.showSpeakers,
              active: segment.id == active,
              sentiment: sentiment[segment.id],
              onSpeakerTap: () =>
                  EditorActions.speakerMenu(context, segment.id),
              onLongPress: () => EditorActions.segmentMenu(context, segment),
              onDoubleTap: state.editMode
                  ? () => EditorActions.editText(context, segment)
                  : null,
              onTimeTap: canPlay
                  ? () => context.read<PlayerCubit>().seekTo(
                      segment.start,
                      play: true,
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({
    required this.state,
    required this.filterOpen,
    required this.onFilter,
  });

  final TranscriptState state;
  final bool filterOpen;
  final VoidCallback onFilter;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final transcript = state.transcript!;
    final cubit = context.read<TranscriptCubit>();
    final duration = transcript.duration;
    final meta = [
      if (duration != null) Formatters.timecode(duration),
      if (transcript.speakers.isNotEmpty)
        l10n.transcriptSpeakers(transcript.speakers.length),
    ].join(' · ');
    Color tint({required bool on}) =>
        on ? AppColors.accent : AppColors.mutedDark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 8, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              meta,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.mono,
            ),
          ),
          if (transcript.speakers.isNotEmpty)
            IconButton(
              key: const Key('transcript_toggle_speakers'),
              tooltip: l10n.editorShowSpeakers,
              isSelected: state.showSpeakers,
              onPressed: () =>
                  cubit.setShowSpeakers(value: !state.showSpeakers),
              icon: Icon(
                state.showSpeakers
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: tint(on: state.showSpeakers),
              ),
            ),
          if (transcript.speakers.length > 1)
            IconButton(
              key: const Key('transcript_filter'),
              tooltip: l10n.editorFilterSpeakers,
              isSelected: filterOpen,
              onPressed: onFilter,
              icon: Icon(
                Icons.filter_list_rounded,
                color: tint(on: state.speakerFilter != null),
              ),
            ),
          IconButton(
            key: const Key('transcript_edit_mode'),
            tooltip: l10n.editorEdit,
            isSelected: state.editMode,
            onPressed: () => cubit.setEditMode(value: !state.editMode),
            icon: Icon(Icons.edit_outlined, color: tint(on: state.editMode)),
          ),
        ],
      ),
    );
  }
}

/// Edit mode says how to edit, in one line under the toolbar.
class _EditHint extends StatelessWidget {
  const _EditHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('edit_hint'),
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: const BoxDecoration(
        color: AppColors.accentSoft,
        border: Border(left: BorderSide(color: AppColors.accent, width: 3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.touch_app_outlined,
            size: 18,
            color: AppColors.accent,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.l10n.editorEditHint,
              style: AppText.caption.copyWith(color: AppColors.cotton),
            ),
          ),
        ],
      ),
    );
  }
}
