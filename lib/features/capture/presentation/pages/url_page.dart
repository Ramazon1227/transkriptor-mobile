import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/capture/presentation/widgets/capture_placeholder.dart';

/// A direct link to an audio or video file on the web.
/// Placeholder until a later phase builds it.
class UrlPage extends StatelessWidget {
  const UrlPage({super.key});

  @override
  Widget build(BuildContext context) => CapturePlaceholder(
    source: CaptureSource.url,
    title: context.l10n.sourceUrlTitle,
  );
}
