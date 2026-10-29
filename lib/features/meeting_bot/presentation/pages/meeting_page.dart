import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/meeting_bot/application/meeting_bot_cubit.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/entities/meeting_bot.dart';
import 'package:transkriptor_uz/features/meeting_bot/presentation/widgets/meeting_bot_status_view.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/speaker_count_picker.dart';

/// «Onlayn uchrashuv»: send the Google Meet bot, follow it, and see the
/// recent ones. The host admits the bot from Meet's lobby; nothing here
/// tries to get around that.
class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.sourceMeetingTitle)),
      body: ContentWidth(
        child: WorkspaceGate(
          builder: (context, workspaceId) => BlocProvider(
            key: ValueKey(workspaceId),
            create: (_) {
              final cubit = getIt<MeetingBotCubit>();
              unawaited(cubit.load(workspaceId));
              return cubit;
            },
            child: const _MeetingBody(),
          ),
        ),
      ),
    );
  }
}

class _MeetingBody extends StatelessWidget {
  const _MeetingBody();

  @override
  Widget build(BuildContext context) {
    final active = context.select<MeetingBotCubit, MeetingBot?>(
      (c) => c.state.active,
    );
    final routeMissing = context.select<MeetingBotCubit, bool>(
      (c) => c.state.routeMissing,
    );
    if (routeMissing) return const _RouteMissing();
    if (active != null) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) context.read<MeetingBotCubit>().dismiss();
        },
        child: const MeetingBotStatusView(),
      );
    }
    return const _FormAndList();
  }
}

class _RouteMissing extends StatelessWidget {
  const _RouteMissing();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        const Center(
          child: SourceIcon(source: CaptureSource.meeting, size: 64),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.meetRouteMissingTitle,
          textAlign: TextAlign.center,
          style: AppText.title,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.meetRouteMissingBody,
          textAlign: TextAlign.center,
          style: AppText.caption,
        ),
        const SizedBox(height: 28),
        OutlinedButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text(l10n.back),
        ),
      ],
    );
  }
}

class _FormAndList extends StatefulWidget {
  const _FormAndList();

  @override
  State<_FormAndList> createState() => _FormAndListState();
}

class _FormAndListState extends State<_FormAndList> {
  final _url = TextEditingController();
  bool _keepVideo = false;
  int? _speakers;

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text?.trim();
    if (text != null && text.isNotEmpty && mounted) {
      _url.text = text;
      context.read<MeetingBotCubit>().urlEdited();
    }
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    unawaited(
      context.read<MeetingBotCubit>().submit(
        url: _url.text,
        keepVideo: _keepVideo,
        numSpeakers: _speakers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<MeetingBotCubit, MeetingBotState>(
      builder: (context, state) {
        final busy = state.submitting;
        final canSend = state.available && !busy;
        final failure = state.actionFailure;
        return RefreshIndicator(
          onRefresh: () async {
            final id = state.workspaceId;
            if (id != null) await context.read<MeetingBotCubit>().load(id);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              Row(
                children: [
                  const SourceIcon(source: CaptureSource.meeting, size: 44),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(l10n.meetHeadline, style: AppText.heading),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(l10n.meetIntro, style: AppText.caption),
              const SizedBox(height: 20),
              if (!state.available) ...[
                _Note(text: l10n.meetUnavailable, color: AppColors.warn),
                const SizedBox(height: 16),
              ],
              TextField(
                controller: _url,
                enabled: !busy,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                onChanged: (_) => context.read<MeetingBotCubit>().urlEdited(),
                onSubmitted: (_) => canSend ? _submit() : null,
                style: AppText.mono.copyWith(
                  fontSize: 13,
                  color: AppColors.cotton,
                ),
                decoration: InputDecoration(
                  labelText: l10n.meetUrlLabel,
                  hintText: 'https://meet.google.com/abc-defg-hij',
                  errorText: state.urlInvalid ? l10n.meetUrlInvalid : null,
                  errorMaxLines: 3,
                  suffixIcon: TextButton(
                    onPressed: busy ? null : _paste,
                    child: Text(l10n.linkPaste),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Material(
                color: AppColors.sf1,
                borderRadius: BorderRadius.circular(AppRadii.card),
                clipBehavior: Clip.antiAlias,
                child: SwitchListTile(
                  value: _keepVideo,
                  onChanged: busy
                      ? null
                      : (v) => setState(() => _keepVideo = v),
                  title: Text(l10n.meetKeepVideo),
                  subtitle: Text(
                    l10n.meetKeepVideoBody,
                    style: AppText.caption,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SpeakerCountPicker(
                value: _speakers,
                enabled: !busy,
                onChanged: (v) => setState(() => _speakers = v),
              ),
              const SizedBox(height: 20),
              _Note(text: l10n.meetHostNote, color: AppColors.mutedDark),
              if (state.defaultBotName.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.meetBotName(state.defaultBotName),
                  style: AppText.caption,
                ),
              ],
              const SizedBox(height: 20),
              if (failure != null) ...[
                Text(
                  failure.message(l10n),
                  style: const TextStyle(color: AppColors.bad),
                ),
                const SizedBox(height: 12),
              ],
              FilledButton(
                onPressed: canSend ? _submit : null,
                child: busy
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.meetJoin),
              ),
              const SizedBox(height: 32),
              _RecentBots(state: state),
            ],
          ),
        );
      },
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.segment),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Text(
        text,
        style: AppText.caption.copyWith(color: AppColors.cotton),
      ),
    );
  }
}

class _RecentBots extends StatelessWidget {
  const _RecentBots({required this.state});

  final MeetingBotState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = state.listStatus;
    final Widget content;
    if (state.items.isNotEmpty) {
      content = ActionGroup(
        children: [
          for (final bot in state.items)
            ActionRow(
              icon: Icons.video_camera_front_outlined,
              label: bot.meetingTitle ?? bot.meetUrl,
              subtitle: [
                meetingStatusLabel(l10n, bot.status),
                if (bot.createdAt case final at?)
                  '${Formatters.date(at)} ${Formatters.clock(at)}',
              ].join(' · '),
              onTap: () => context.read<MeetingBotCubit>().watch(bot),
            ),
        ],
      );
    } else if (status == MeetingListStatus.failure) {
      content = Text(
        state.listFailure?.message(l10n) ?? l10n.errorUnknown,
        style: AppText.caption,
      );
    } else if (status == MeetingListStatus.empty) {
      content = Text(l10n.meetRecentEmpty, style: AppText.caption);
    } else {
      content = const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
          child: Text(l10n.meetRecent.toUpperCase(), style: AppText.label),
        ),
        content,
      ],
    );
  }
}
