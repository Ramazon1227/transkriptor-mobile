import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/files_empty_view.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/source_tabs.dart';
import 'package:transkriptor_uz/features/notes/application/notes_cubit.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/presentation/widgets/note_title.dart';

/// The «Eslatmalar» tab's body. Reaching the last row loads the next page.
class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      // A failed refresh or next page keeps the rows; say so.
      listenWhen: (prev, next) =>
          next.failure != null &&
          prev.failure != next.failure &&
          next.items.isNotEmpty,
      listener: (context, state) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.failure!.message(context.l10n))),
      ),
      builder: (context, state) {
        final cubit = context.read<NotesCubit>();
        Future<void> refresh() async {
          unawaited(cubit.refresh());
          await cubit.stream.firstWhere((s) => !s.refreshing);
        }

        final items = state.visibleItems;
        return switch (state.status) {
          NotesStatus.initial || NotesStatus.loading => const AppLoadingView(),
          NotesStatus.failure => AppErrorView(
            failure: state.failure!,
            onRetry: cubit.refresh,
          ),
          NotesStatus.empty => RefreshIndicator(
            onRefresh: refresh,
            child: const FilesEmptyView(tab: FilesTab.notes, canWrite: false),
          ),
          NotesStatus.success when items.isEmpty => RefreshIndicator(
            onRefresh: refresh,
            child: const FilesNoMatchView(),
          ),
          NotesStatus.success => RefreshIndicator(
            onRefresh: refresh,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length + (state.loadingMore ? 1 : 0),
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                if (i >= items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                // The search filters only what is loaded; the next page is
                // fetched when the full list's end comes into view.
                if (i == items.length - 1 &&
                    state.nextCursor != null &&
                    state.query.isEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => unawaited(cubit.loadMore()),
                  );
                }
                return NoteTile(note: items[i]);
              },
            ),
          ),
        };
      },
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({required this.note, super.key});

  final NoteSummary note;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final date = note.updatedAt ?? note.createdAt;
    final hasTitle = note.title.trim().isNotEmpty;
    return InkWell(
      key: Key('note_${note.id}'),
      onTap: () async {
        final changed = await context.push<bool>(Routes.noteOf(note.id));
        if ((changed ?? false) && context.mounted) {
          await context.read<NotesCubit>().refresh();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SourceIcon(source: CaptureSource.note),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noteDisplayTitle(l10n, note.title, note.excerpt),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bodyMedium,
                  ),
                  if (hasTitle && note.excerpt.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      note.excerpt,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption,
                    ),
                  ],
                  if (date != null) ...[
                    const SizedBox(height: 4),
                    Text(Formatters.date(date), style: AppText.mono),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
