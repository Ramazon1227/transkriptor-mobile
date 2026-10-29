import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';

/// The page of a capture source that is not built yet: its title, «Tez
/// orada» and the way back. Each source has its own page class around
/// this, so a later phase replaces one page without touching the router.
class CapturePlaceholder extends StatelessWidget {
  const CapturePlaceholder({
    required this.source,
    required this.title,
    super.key,
  });

  final CaptureSource source;
  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ContentWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          children: [
            Center(child: SourceIcon(source: source, size: 64)),
            const SizedBox(height: 20),
            Text(
              l10n.comingSoon,
              textAlign: TextAlign.center,
              style: AppText.title,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.comingSoonBody,
              textAlign: TextAlign.center,
              style: AppText.caption,
            ),
            const SizedBox(height: 28),
            OutlinedButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: Text(l10n.back),
            ),
          ],
        ),
      ),
    );
  }
}
