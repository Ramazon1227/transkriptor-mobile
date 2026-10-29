import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';

/// Opens an editing sheet over [context], which must see the page's
/// [TranscriptCubit]. The save state is reset on open and on close, so a
/// late answer never lands on the next sheet; nothing opens while a save
/// runs. Gives back what the sheet popped with, if anything.
Future<T?> showEditSheet<T>(BuildContext context, Widget sheet) async {
  final cubit = context.read<TranscriptCubit>();
  if (cubit.state.editStatus == EditStatus.saving) return null;
  cubit.editOpened();
  final result = await showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    // Drag-to-dismiss pops past PopScope; the barrier, back and Cancel
    // still close the sheet, and all three respect a running save.
    enableDrag: false,
    builder: (_) => BlocProvider.value(value: cubit, child: sheet),
  );
  if (!cubit.isClosed) cubit.editClosed();
  return result;
}
