import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/features/share/application/share_cubit.dart';
import 'package:transkriptor_uz/features/share/domain/entities/share_link.dart';

/// Public read links of one transcript: open one, copy it, revoke the
/// live ones. The same options as the web dialog.
class ShareSheet extends StatelessWidget {
  const ShareSheet({required this.transcriptId, super.key});

  final String transcriptId;

  static Future<void> show(BuildContext context, String transcriptId) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ShareSheet(transcriptId: transcriptId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<ShareCubit>();
        unawaited(cubit.load(transcriptId));
        return cubit;
      },
      child: const _ShareView(),
    );
  }
}

String _failureText(AppLocalizations l10n, Failure failure) =>
    switch (failure) {
      // VIEWER: may read the transcript, may not hand it out.
      ServerFailure(statusCode: 403) => l10n.shareForbidden,
      _ => failure.message(l10n),
    };

class _ShareView extends StatelessWidget {
  const _ShareView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ShareCubit, ShareState>(
      builder: (context, state) {
        final created = state.created;
        final busy = state.actionStatus == ShareActionStatus.busy;
        final failure = state.actionFailure;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.shareTitle, style: AppText.title),
              const SizedBox(height: 16),
              if (created != null && created.url != null)
                _CreatedLink(url: created.url!)
              else
                _Options(state: state, busy: busy),
              if (failure != null) ...[
                const SizedBox(height: 12),
                Text(
                  _failureText(l10n, failure),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 20),
              _LiveLinks(state: state, busy: busy),
            ],
          ),
        );
      },
    );
  }
}

class _Options extends StatelessWidget {
  const _Options({required this.state, required this.busy});

  final ShareState state;
  final bool busy;

  String _expiryLabel(AppLocalizations l10n, int days) => switch (days) {
    0 => l10n.shareNoExpiry,
    365 => l10n.shareOneYear,
    _ => l10n.shareDays(days),
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<ShareCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: state.includeMedia,
          onChanged: busy ? null : (v) => cubit.setIncludeMedia(value: v),
          title: Text(l10n.shareIncludeMedia),
          subtitle: Text(l10n.shareIncludeMediaHint, style: AppText.muted),
        ),
        const SizedBox(height: 8),
        Text(l10n.shareExpiry, style: AppText.label),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            for (final days in shareExpiryDays)
              ChoiceChip(
                label: Text(_expiryLabel(l10n, days)),
                selected: state.expiresDays == days,
                onSelected: busy ? null : (_) => cubit.setExpiresDays(days),
              ),
          ],
        ),
        const SizedBox(height: 20),
        FilledButton(
          key: const Key('share_create'),
          onPressed: busy ? null : cubit.create,
          child: Text(l10n.shareOpen),
        ),
      ],
    );
  }
}

/// The new link with its copy button. Only state of its own: whether it
/// was copied, for the button's label.
class _CreatedLink extends StatefulWidget {
  const _CreatedLink({required this.url});

  final String url;

  @override
  State<_CreatedLink> createState() => _CreatedLinkState();
}

class _CreatedLinkState extends State<_CreatedLink> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.url));
    if (mounted) setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.shareLinkLabel, style: AppText.label),
        const SizedBox(height: 8),
        SelectableText(widget.url, style: AppText.mono),
        const SizedBox(height: 12),
        FilledButton.icon(
          key: const Key('share_copy'),
          onPressed: _copy,
          icon: Icon(_copied ? Icons.check : Icons.copy, size: 18),
          label: Text(_copied ? l10n.shareCopied : l10n.shareCopy),
        ),
        const SizedBox(height: 10),
        Text(l10n.shareShownOnce, style: AppText.muted),
      ],
    );
  }
}

class _LiveLinks extends StatelessWidget {
  const _LiveLinks({required this.state, required this.busy});

  final ShareState state;
  final bool busy;

  String _meta(AppLocalizations l10n, ShareLink link) {
    final expires = link.expiresAt;
    return [
      if (expires == null)
        l10n.shareNoExpiryShort
      else
        l10n.shareUntil(Formatters.date(expires)),
      l10n.shareViews(link.viewCount),
      if (link.includeMedia) l10n.shareWithAudio,
    ].join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final listFailure = state.listFailure;
    if (state.listStatus == ShareListStatus.failure && listFailure != null) {
      return Text(_failureText(l10n, listFailure), style: AppText.muted);
    }
    if (state.links.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.shareActive, style: AppText.label),
        for (final link in state.links)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              link.createdAt == null ? '' : Formatters.date(link.createdAt!),
            ),
            subtitle: Text(_meta(l10n, link), style: AppText.muted),
            trailing: TextButton(
              onPressed: busy
                  ? null
                  : () => context.read<ShareCubit>().revoke(link.id),
              child: Text(l10n.shareRevoke),
            ),
          ),
      ],
    );
  }
}
