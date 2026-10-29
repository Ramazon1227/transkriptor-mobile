import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/capture/presentation/widgets/capture_placeholder.dart';

/// Screen recording with its audio.
/// Placeholder until a later phase builds it.
class ScreenRecordPage extends StatelessWidget {
  const ScreenRecordPage({super.key});

  @override
  Widget build(BuildContext context) => CapturePlaceholder(
    source: CaptureSource.screen,
    title: context.l10n.sourceScreenTitle,
  );
}
