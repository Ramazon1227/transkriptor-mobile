import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/speaker_count_picker.dart';

class LinkPage extends StatelessWidget {
  const LinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UploadBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.linkTitle)),
        body: WorkspaceGate(
          builder: (context, workspaceId) =>
              _LinkForm(workspaceId: workspaceId),
        ),
      ),
    );
  }
}

class _LinkForm extends StatefulWidget {
  const _LinkForm({required this.workspaceId});

  final String workspaceId;

  @override
  State<_LinkForm> createState() => _LinkFormState();
}

class _LinkFormState extends State<_LinkForm> {
  final _url = TextEditingController();
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
    }
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<UploadBloc>().add(
      UploadLinkSubmitted(
        url: _url.text,
        workspaceId: widget.workspaceId,
        numSpeakers: _speakers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<UploadBloc, UploadState>(
      listenWhen: (prev, next) => prev.status != next.status,
      listener: (context, state) {
        final job = state.job;
        if (state.status == UploadStatus.success && job != null) {
          context.pushReplacement(Routes.jobOf(job.id));
        }
      },
      builder: (context, state) {
        final busy =
            state.status == UploadStatus.uploading ||
            state.status == UploadStatus.success;
        final failure = state.failure;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            TextField(
              controller: _url,
              enabled: !busy,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              style: AppText.mono.copyWith(
                fontSize: 13,
                color: AppColors.cotton,
              ),
              decoration: InputDecoration(
                labelText: l10n.linkLabel,
                hintText: 'https://',
                errorText: state.linkInvalid ? l10n.linkInvalid : null,
                errorMaxLines: 3,
                suffixIcon: TextButton(
                  onPressed: busy ? null : _paste,
                  child: Text(l10n.linkPaste),
                ),
              ),
            ),
            const SizedBox(height: 22),
            SpeakerCountPicker(
              value: _speakers,
              enabled: !busy,
              onChanged: (v) => setState(() => _speakers = v),
            ),
            const SizedBox(height: 24),
            Text(l10n.linkWhich.toUpperCase(), style: AppText.label),
            _Source(name: l10n.sourceYoutube, body: l10n.linkYoutubeBody),
            _Source(name: l10n.sourceDrive, body: l10n.linkDriveBody),
            _Source(name: l10n.sourceDropbox, body: l10n.linkDropboxBody),
            const SizedBox(height: 8),
            Text(
              l10n.linkServerFetches,
              style: AppText.muted.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 28),
            if (failure != null) ...[
              Text(
                failure.message(l10n),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 12),
            ],
            FilledButton(
              onPressed: busy ? null : _submit,
              child: busy
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.sendStart),
            ),
          ],
        );
      },
    );
  }
}

class _Source extends StatelessWidget {
  const _Source({required this.name, required this.body});

  final String name;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.sf2)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(body, style: AppText.muted)),
        ],
      ),
    );
  }
}
