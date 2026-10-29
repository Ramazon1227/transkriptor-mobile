import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/filter_tab.dart';

/// «Teg: hammasi» plus the tags on the open folder's rows. Hidden when no
/// row has a tag.
class TagFilterBar extends StatelessWidget {
  const TagFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      buildWhen: (prev, next) =>
          prev.items != next.items || prev.tag != next.tag,
      builder: _bar,
    );
  }

  Widget _bar(BuildContext context, LibraryState state) {
    final l10n = context.l10n;
    final tags = state.tags;
    final selected = state.tag;
    if (tags.isEmpty) return const SizedBox.shrink();
    final bloc = context.read<LibraryBloc>();
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        children: [
          FilterTab(
            key: const Key('tag_all'),
            label: l10n.filesTagAll,
            selected: selected == null,
            onTap: () => bloc.add(const LibraryTagSelected(null)),
          ),
          for (final t in tags)
            FilterTab(
              key: Key('tag_$t'),
              label: '#$t',
              selected: selected == t,
              onTap: () => bloc.add(LibraryTagSelected(t)),
            ),
        ],
      ),
    );
  }
}
