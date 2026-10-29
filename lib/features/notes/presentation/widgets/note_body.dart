import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';

/// A note's body, read-only: headings, paragraphs, lists, quotes and code
/// in their shape; marks (bold, colour, links) are not drawn.
class NoteBody extends StatelessWidget {
  const NoteBody({required this.blocks, super.key});

  final List<NoteBlock> blocks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [for (final b in blocks) _Block(b)],
    );
  }
}

class _Block extends StatelessWidget {
  const _Block(this.block);

  final NoteBlock block;

  @override
  Widget build(BuildContext context) {
    final b = block;
    final child = switch (b.kind) {
      NoteBlockKind.heading => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 4),
        child: Text(
          b.text,
          style: switch (b.level) {
            1 => AppText.title,
            2 => AppText.heading,
            _ => AppText.bodyStrong,
          },
        ),
      ),
      NoteBlockKind.paragraph => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(b.text, style: AppText.body),
      ),
      NoteBlockKind.listItem => Padding(
        padding: EdgeInsets.only(left: 18.0 * b.depth, bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              child: Text(
                b.marker,
                style: AppText.body.copyWith(color: AppColors.mutedDark),
              ),
            ),
            Expanded(child: Text(b.text, style: AppText.body)),
          ],
        ),
      ),
      NoteBlockKind.code => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.sf1,
          borderRadius: BorderRadius.circular(AppRadii.segment),
        ),
        child: Text(b.text, style: AppText.mono.copyWith(fontSize: 13)),
      ),
    };
    if (!b.quoted) return child;
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.sf3, width: 3)),
      ),
      child: child,
    );
  }
}
