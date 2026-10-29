import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/presentation/widgets/player_panel.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/presentation/editor_actions.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/editor_tabs.dart';

/// The editor: player on top, then Transkript · AI suhbat · Xulosa ·
/// Oʻrganish. The title renames on tap; «…» holds the file's actions.
class TranscriptPage extends StatelessWidget {
  const TranscriptPage({required this.transcriptId, super.key});

  final String transcriptId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final cubit = getIt<TranscriptCubit>();
            unawaited(cubit.load(transcriptId));
            return cubit;
          },
        ),
        BlocProvider(create: (_) => getIt<PlayerCubit>()),
      ],
      child: _EditorView(transcriptId: transcriptId),
    );
  }
}

class _EditorView extends StatefulWidget {
  const _EditorView({required this.transcriptId});

  final String transcriptId;

  @override
  State<_EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<_EditorView> {
  /// Playback stops when the app leaves the screen.
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onHide: () => unawaited(context.read<PlayerCubit>().pause()),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TranscriptCubit, TranscriptState>(
      // The file is known once the transcript is; a 409 refetch keeps the
      // same one and does not reopen it.
      listenWhen: (p, n) =>
          n.transcript != null &&
          p.transcript?.mediaId != n.transcript?.mediaId,
      listener: (context, state) => unawaited(
        context.read<PlayerCubit>().open(state.transcript!.mediaId),
      ),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: const _Title(),
          actions: [
            BlocSelector<TranscriptCubit, TranscriptState, bool>(
              selector: (s) => s.transcript != null,
              builder: (context, loaded) => loaded
                  ? IconButton(
                      key: const Key('transcript_more'),
                      tooltip: context.l10n.editorMore,
                      icon: const Icon(Icons.more_horiz_rounded),
                      onPressed: () => EditorActions.fileActions(context),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        body: ContentWidth(
          maxWidth: ContentWidth.list,
          child: BlocBuilder<TranscriptCubit, TranscriptState>(
            buildWhen: (p, n) =>
                p.status != n.status ||
                (p.transcript == null) != (n.transcript == null),
            builder: (context, state) => switch (state.status) {
              TranscriptStatus.initial ||
              TranscriptStatus.loading => const AppLoadingView(),
              TranscriptStatus.failure => AppErrorView(
                failure: state.failure!,
                onRetry: () =>
                    context.read<TranscriptCubit>().load(widget.transcriptId),
              ),
              TranscriptStatus.empty ||
              TranscriptStatus.success => const _Editor(),
            },
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    final title = context.select<TranscriptCubit, String?>(
      (c) => c.state.transcript?.title,
    );
    if (title == null) return const SizedBox.shrink();
    return InkWell(
      key: const Key('transcript_title'),
      onTap: () => EditorActions.renameTitle(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppText.heading,
        ),
      ),
    );
  }
}

/// Player above the tabs; on a short, wide screen (a phone on its side)
/// the player moves to a column on the left so the text keeps its height.
class _Editor extends StatefulWidget {
  const _Editor();

  @override
  State<_Editor> createState() => _EditorState();
}

class _EditorState extends State<_Editor> {
  /// The tabs keep their state when the layout turns with the phone.
  final GlobalKey _tabsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final transcript = context.select<TranscriptCubit, Transcript?>(
      (c) => c.state.transcript,
    );
    if (transcript == null) return const SizedBox.shrink();
    final tabs = EditorTabs(key: _tabsKey, transcript: transcript);
    return LayoutBuilder(
      builder: (context, box) {
        final side = box.maxWidth > box.maxHeight && box.maxHeight < 600;
        if (side) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: box.maxWidth * .42,
                child: const SingleChildScrollView(child: PlayerPanel()),
              ),
              Expanded(child: tabs),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PlayerPanel(),
            Expanded(child: tabs),
          ],
        );
      },
    );
  }
}
