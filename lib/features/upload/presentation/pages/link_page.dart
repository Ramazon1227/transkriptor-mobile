import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_service.dart';
import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/advanced_options.dart';
import 'package:transkriptor_uz/features/upload/presentation/pages/advanced_settings_page.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/advanced_settings_tile.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/service_picker.dart';

class LinkPage extends StatelessWidget {
  const LinkPage({this.initialUrl, super.key});

  /// Prefilled when «Havola orqali» recognised a YouTube/Drive/Dropbox
  /// link; nothing is sent until the person presses the button.
  final String? initialUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UploadBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.linkTitle)),
        body: ContentWidth(
          child: WorkspaceGate(
            builder: (context, workspaceId) =>
                _LinkForm(workspaceId: workspaceId, initialUrl: initialUrl),
          ),
        ),
      ),
    );
  }
}

class _LinkForm extends StatefulWidget {
  const _LinkForm({required this.workspaceId, this.initialUrl});

  final String workspaceId;
  final String? initialUrl;

  @override
  State<_LinkForm> createState() => _LinkFormState();
}

class _LinkFormState extends State<_LinkForm> {
  late final _url = TextEditingController(text: widget.initialUrl);

  /// «Qoʻshimcha sozlamalar» (A-0): for this link only.
  late AdvancedOptions _options = AdvancedOptions.initial(
    workspaceId: widget.workspaceId,
  );
  JobService _service = JobService.transcription;

  /// A link is fetched by the server: there is nothing to play here, so
  /// the hints fold shows a note instead (A-3). Nothing is uploaded from
  /// the phone, so the destination never locks.
  Future<void> _openAdvanced() async {
    FocusScope.of(context).unfocus();
    final saved = await AdvancedSettingsPage.open(
      context,
      value: _options,
      workspaces:
          context.read<AccountCubit>().state.account?.workspaces ?? const [],
      hintsNote: context.l10n.advancedHintsLinkNote,
    );
    if (saved != null && mounted) setState(() => _options = saved);
  }

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
        workspaceId: _options.workspaceId,
        folderId: _options.folderId,
        numSpeakers: _options.numSpeakers,
        service: _service,
        options: _options.jobOptionsFor(),
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
            ServicePicker(
              value: _service,
              enabled: !busy,
              onChanged: (v) => setState(() => _service = v),
            ),
            const SizedBox(height: 22),
            AdvancedSettingsTile(
              value: _options,
              currentWorkspaceId: widget.workspaceId,
              onTap: busy ? null : _openAdvanced,
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
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontVariations: [FontVariation('wght', 500)],
              ),
            ),
          ),
          Expanded(child: Text(body, style: AppText.muted)),
        ],
      ),
    );
  }
}
