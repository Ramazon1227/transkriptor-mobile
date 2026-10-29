import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/capture/presentation/widgets/capture_placeholder.dart';

/// Online meeting (Google Meet) recording.
/// Placeholder until a later phase builds it.
class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) => CapturePlaceholder(
    source: CaptureSource.meeting,
    title: context.l10n.sourceMeetingTitle,
  );
}
