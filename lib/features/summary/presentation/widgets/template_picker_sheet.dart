import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/summary/application/summary_cubit.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';

/// Opens the template library. Picking closes the sheet; starring keeps
/// it open.
Future<void> showTemplatePicker(BuildContext context) {
  final cubit = context.read<SummaryCubit>();
  if (cubit.state.templatesStatus == TemplatesStatus.failure) {
    unawaited(cubit.loadTemplates());
  }
  return showAppSheet<void>(
    context,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: const TemplatePickerSheet(),
    ),
  );
}

class TemplatePickerSheet extends StatelessWidget {
  const TemplatePickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppSheet(
      title: l10n.summaryTemplatesTitle,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: BlocBuilder<SummaryCubit, SummaryState>(
        builder: (context, state) {
          final cubit = context.read<SummaryCubit>();
          final library = state.library;
          if (state.templatesStatus == TemplatesStatus.failure) {
            return AppErrorView(
              failure: state.templatesFailure ?? const Failure.unknown(),
              onRetry: cubit.loadTemplates,
            );
          }
          if (library == null) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (library.templates.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Text(l10n.summaryTemplatesEmpty, style: AppText.caption),
            );
          }
          final groups = <(String, List<SummaryTemplate>)>[
            (l10n.summaryTemplatesFavorites, library.favorites),
            for (final c in library.categories)
              (c.name, library.inCategory(c.id)),
            (l10n.summaryTemplatesMine, library.mine),
          ];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.favoriteFailure != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  child: Text(
                    l10n.summaryFavoriteFailed,
                    style: AppText.caption.copyWith(color: AppColors.bad),
                  ),
                ),
              for (final (title, items) in groups)
                if (items.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                    child: Text(title.toUpperCase(), style: AppText.label),
                  ),
                  for (final t in items)
                    _TemplateRow(
                      template: t,
                      selected: state.template?.id == t.id,
                      onPick: () {
                        cubit.selectTemplate(t);
                        Navigator.of(context).pop();
                      },
                      onStar: () => cubit.toggleFavorite(t),
                    ),
                ],
            ],
          );
        },
      ),
    );
  }
}

class _TemplateRow extends StatelessWidget {
  const _TemplateRow({
    required this.template,
    required this.selected,
    required this.onPick,
    required this.onStar,
  });

  final SummaryTemplate template;
  final bool selected;
  final VoidCallback onPick;
  final VoidCallback onStar;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return InkWell(
      key: Key('summary_template_${template.id}'),
      onTap: onPick,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  template.name,
                  style: (selected ? AppText.bodyStrong : AppText.body)
                      .copyWith(
                        color: selected ? AppColors.accent : AppColors.cotton,
                      ),
                ),
              ),
              if (selected)
                const Icon(Icons.check_rounded, color: AppColors.accent),
              IconButton(
                tooltip: template.favorite
                    ? l10n.summaryUnstar
                    : l10n.summaryStar,
                onPressed: onStar,
                icon: Icon(
                  template.favorite
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: template.favorite
                      ? AppColors.accent
                      : AppColors.mutedDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
