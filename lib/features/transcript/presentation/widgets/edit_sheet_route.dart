import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';

/// Opens an editing sheet over [context], which must see the page's
/// [TranscriptCubit]. The save state is reset on open and on close, so a
/// late answer never lands on the next sheet; nothing opens while a save
/// runs.
Future<void> showEditSheet(BuildContext context, Widget sheet) async {
  final cubit = context.read<TranscriptCubit>();
  if (cubit.state.editStatus == EditStatus.saving) return;
  cubit.editOpened();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    // Drag-to-dismiss pops past PopScope; the barrier, back and Cancel
    // still close the sheet, and all three respect a running save.
    enableDrag: false,
    builder: (_) => BlocProvider.value(value: cubit, child: sheet),
  );
  if (!cubit.isClosed) cubit.editClosed();
}
