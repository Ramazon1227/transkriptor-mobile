import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/core/widgets/demo_banner.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/capture/application/url_import_cubit.dart';

/// «Havola orqali»: any direct audio/video URL. YouTube, Drive and Dropbox
/// links go on to the real link flow; anything else meets the demo source
/// until the server has `POST /media/url`.
class UrlPage extends StatelessWidget {
  const UrlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UrlImportCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.sourceUrlTitle)),
        body: ContentWidth(
          child: WorkspaceGate(
            builder: (context, workspaceId) =>
                _UrlForm(workspaceId: workspaceId),
          ),
        ),
      ),
    );
  }
}

class _UrlForm extends StatefulWidget {
  const _UrlForm({required this.workspaceId});

  final String workspaceId;

  @override
  State<_UrlForm> createState() => _UrlFormState();
}

class _UrlFormState extends State<_UrlForm> {
  final _url = TextEditingController();

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
      context.read<UrlImportCubit>().edited();
    }
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    unawaited(
      context.read<UrlImportCubit>().submit(
        url: _url.text,
        workspaceId: widget.workspaceId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<UrlImportCubit, UrlImportState>(
      listener: (context, state) {
        final platformUrl = state.platformUrl;
        final jobId = state.jobId;
        if (platformUrl != null) {
          context.read<UrlImportCubit>().consumed();
          // The link page starts nothing by itself: the person still
          // presses its button.
          context.pushReplacement(Routes.link, extra: platformUrl);
        } else if (state.status == UrlImportStatus.success && jobId != null) {
          context.pushReplacement(Routes.jobOf(jobId));
        }
      },
      builder: (context, state) {
        final busy = state.status == UrlImportStatus.loading;
        final failure = state.failure;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            DemoBanner(message: l10n.urlBanner),
            const SizedBox(height: 16),
            Text(l10n.urlIntro, style: AppText.caption),
            const SizedBox(height: 16),
            TextField(
              controller: _url,
              enabled: !busy,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              onChanged: (_) => context.read<UrlImportCubit>().edited(),
              onSubmitted: (_) => _submit(),
              style: AppText.mono.copyWith(
                fontSize: 13,
                color: AppColors.cotton,
              ),
              decoration: InputDecoration(
                labelText: l10n.urlLabel,
                hintText: 'https://',
                errorText: state.urlInvalid ? l10n.urlInvalid : null,
                errorMaxLines: 3,
                suffixIcon: TextButton(
                  onPressed: busy ? null : _paste,
                  child: Text(l10n.linkPaste),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(l10n.urlPlatformsNote, style: AppText.caption),
            const SizedBox(height: 24),
            if (state.status == UrlImportStatus.notAvailable) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.sf1,
                  borderRadius: BorderRadius.circular(AppRadii.segment),
                  border: const Border(
                    left: BorderSide(color: AppColors.warn, width: 3),
                  ),
                ),
                child: Text(l10n.urlNotReady, style: AppText.body),
              ),
              const SizedBox(height: 16),
            ],
            if (failure != null) ...[
              Text(
                failure.message(l10n),
                style: const TextStyle(color: AppColors.bad),
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
                  : Text(l10n.urlSubmit),
            ),
          ],
        );
      },
    );
  }
}
