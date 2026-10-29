import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/capture/presentation/widgets/capture_placeholder.dart';

/// Live dictation: text appears while the person speaks.
/// Placeholder until a later phase builds it.
class DictationPage extends StatelessWidget {
  const DictationPage({super.key});

  @override
  Widget build(BuildContext context) => CapturePlaceholder(
    source: CaptureSource.dictation,
    title: context.l10n.sourceDictationTitle,
  );
}
