import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/edit_failure_text.dart';

/// Bottom sheet that edits one string through [TranscriptCubit]: a
/// segment's text or a speaker's name. It closes only when the cubit says
/// the save went through; on a failure the draft stays, so nothing typed
/// is lost.
class EditTextSheet extends StatefulWidget {
  const EditTextSheet({
    required this.title,
    required this.initial,
    required this.multiline,
    required this.tooLong,
    required this.tooLongMessage,
    required this.onSave,
    super.key,
  });

  final String title;
  final String initial;

  /// Segment text wraps over lines; a name is one line.
  final bool multiline;
  final bool Function(String) tooLong;
  final String tooLongMessage;
  final void Function(TranscriptCubit cubit, String text) onSave;

  /// Opens the sheet over [context], which must see the page's
  /// [TranscriptCubit]. The save state is reset on open and on close.
  static Future<void> show(BuildContext context, EditTextSheet sheet) async {
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

  @override
  State<EditTextSheet> createState() => _EditTextSheetState();
}

class _EditTextSheetState extends State<EditTextSheet> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initial,
  )..addListener(_onChanged);

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tooLong = widget.tooLong(_controller.text);
    // A name cannot be blank; a segment can be cleared on purpose (noise
    // heard as words), the server keeps its time range.
    final blank = !widget.multiline && _controller.text.trim().isEmpty;
    return BlocConsumer<TranscriptCubit, TranscriptState>(
      listenWhen: (prev, next) =>
          prev.editStatus != next.editStatus &&
          next.editStatus == EditStatus.saved,
      listener: (context, _) => Navigator.of(context).pop(),
      buildWhen: (prev, next) =>
          prev.editStatus != next.editStatus ||
          prev.editFailure != next.editFailure,
      builder: (context, state) {
        final saving = state.editStatus == EditStatus.saving;
        final failure = state.editFailure;
        // Closed mid-save, the answer would land on whatever opens next.
        return PopScope(
          canPop: !saving,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              16,
              20,
              16 + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(widget.title, style: AppText.label),
                const SizedBox(height: 12),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  enabled: !saving,
                  minLines: widget.multiline ? 3 : 1,
                  maxLines: widget.multiline ? 10 : 1,
                  keyboardType: widget.multiline
                      ? TextInputType.multiline
                      : TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    errorText: tooLong ? widget.tooLongMessage : null,
                  ),
                ),
                if (failure != null) ...[
                  const SizedBox(height: 10),
                  EditFailureText(failure: failure),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: saving
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: Text(l10n.cancel),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: saving || tooLong || blank
                          ? null
                          : () => widget.onSave(
                              context.read<TranscriptCubit>(),
                              _controller.text,
                            ),
                      child: Text(l10n.transcriptSave),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
