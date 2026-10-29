import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/presentation/widgets/speed_sheet.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';

/// What the «…» sheet hands back for the page to open.
enum FileAction { rename, speed, export, share, comments, rating, retranscribe }

/// «…» in the editor's app bar: view switches act at once; everything
/// that opens its own sheet closes this one first.
class FileActionsSheet extends StatelessWidget {
  const FileActionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void pop(FileAction a) => Navigator.of(context).pop(a);
    return AppSheet(
      title: l10n.editorMore,
      child: BlocBuilder<TranscriptCubit, TranscriptState>(
        builder: (context, state) {
          final cubit = context.read<TranscriptCubit>();
          final transcript = state.transcript;
          final hasSpeakers = transcript?.speakers.isNotEmpty ?? false;
          final hasText = transcript?.segments.isNotEmpty ?? false;
          final canReplay = transcript?.mediaId.isNotEmpty ?? false;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ActionGroup(
                children: [
                  if (hasSpeakers)
                    ActionRow(
                      key: const Key('file_show_speakers'),
                      icon: Icons.people_outline_rounded,
                      label: l10n.editorShowSpeakers,
                      onTap: () =>
                          cubit.setShowSpeakers(value: !state.showSpeakers),
                      trailing: Switch(
                        value: state.showSpeakers,
                        onChanged: (v) => cubit.setShowSpeakers(value: v),
                      ),
                    ),
                  BlocSelector<PlayerCubit, PlayerState, (bool, double)>(
                    selector: (p) => (p.canPlay, p.speed),
                    builder: (context, p) => ActionRow(
                      key: const Key('file_speed'),
                      icon: Icons.speed_rounded,
                      label: l10n.editorPlaybackSpeed,
                      value: formatSpeed(p.$2),
                      onTap: p.$1 ? () => pop(FileAction.speed) : null,
                    ),
                  ),
                  ActionRow(
                    key: const Key('file_edit'),
                    icon: Icons.edit_outlined,
                    label: l10n.editorEdit,
                    onTap: () => cubit.setEditMode(value: !state.editMode),
                    trailing: Switch(
                      value: state.editMode,
                      onChanged: (v) => cubit.setEditMode(value: v),
                    ),
                  ),
                  ActionRow(
                    key: const Key('file_rename'),
                    icon: Icons.title_rounded,
                    label: l10n.editorRenameTitle,
                    onTap: () => pop(FileAction.rename),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ActionGroup(
                children: [
                  if (hasText)
                    ActionRow(
                      key: const Key('file_export'),
                      icon: Icons.file_download_outlined,
                      label: l10n.exportTitle,
                      onTap: () => pop(FileAction.export),
                    ),
                  ActionRow(
                    key: const Key('file_share'),
                    icon: Icons.ios_share_rounded,
                    label: l10n.shareTitle,
                    onTap: () => pop(FileAction.share),
                  ),
                  ActionRow(
                    key: const Key('file_comments'),
                    icon: Icons.chat_bubble_outline_rounded,
                    label: l10n.editorComments,
                    onTap: () => pop(FileAction.comments),
                  ),
                  ActionRow(
                    key: const Key('file_rating'),
                    icon: Icons.star_outline_rounded,
                    label: l10n.editorRating,
                    onTap: () => pop(FileAction.rating),
                  ),
                  if (canReplay)
                    ActionRow(
                      key: const Key('file_retranscribe'),
                      icon: Icons.replay_rounded,
                      label: l10n.editorRetranscribe,
                      onTap: () => pop(FileAction.retranscribe),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
