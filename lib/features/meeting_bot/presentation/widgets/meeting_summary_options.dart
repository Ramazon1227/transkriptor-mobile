import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/summary/application/summary_cubit.dart';
import 'package:transkriptor_uz/features/summary/presentation/widgets/template_picker_sheet.dart';

/// The bot form's post-meeting summary (T14.1): off by default (AI only
/// on request). When on, a template from the summary library and whether
/// internal participants get the mail too. The template comes from the
/// [SummaryCubit] above (only its template list is used here).
class MeetingSummaryOptions extends StatelessWidget {
  const MeetingSummaryOptions({
    required this.summarize,
    required this.shareInternal,
    required this.onSummarize,
    required this.onShareInternal,
    this.enabled = true,
    super.key,
  });

  final bool summarize;
  final bool shareInternal;
  final ValueChanged<bool> onSummarize;
  final ValueChanged<bool> onShareInternal;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: AppColors.sf1,
      borderRadius: BorderRadius.circular(AppRadii.card),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            key: const Key('meet_summarize'),
            value: summarize,
            onChanged: enabled ? onSummarize : null,
            title: Text(l10n.meetSummarize),
            subtitle: Text(l10n.meetSummarizeBody, style: AppText.caption),
          ),
          if (summarize) ...[
            const Divider(height: 1),
            _TemplateRow(enabled: enabled),
            const Divider(height: 1),
            SwitchListTile(
              key: const Key('meet_share_internal'),
              value: shareInternal,
              onChanged: enabled ? onShareInternal : null,
              title: Text(l10n.meetShareInternal),
              subtitle: Text(
                l10n.meetShareInternalBody,
                style: AppText.caption,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TemplateRow extends StatelessWidget {
  const _TemplateRow({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<SummaryCubit>().state;
    final loading = state.templatesStatus == TemplatesStatus.loading;
    return ListTile(
      key: const Key('meet_summary_template'),
      enabled: enabled,
      onTap: () => showTemplatePicker(context),
      title: Text(l10n.meetSummaryTemplate),
      subtitle: Text(
        state.template?.name ?? l10n.summaryTemplateDefault,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppText.caption.copyWith(color: AppColors.cotton),
      ),
      trailing: loading
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.expand_more_rounded),
    );
  }
}
