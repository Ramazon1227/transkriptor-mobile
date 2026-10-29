import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';

/// A home entry card: a small drawn composition (no image assets) over a
/// title. The drawing is the same for every source — a page of text lines
/// with a sound wave running into it — with the source's icon on top, so
/// the cards read as one family.
class IllustratedCard extends StatelessWidget {
  const IllustratedCard({
    required this.source,
    required this.title,
    required this.onTap,
    this.busy = false,
    super.key,
  });

  final CaptureSource source;
  final String title;
  final VoidCallback? onTap;

  /// Shows a spinner in place of the icon (e.g. the file picker is open).
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadii.card);
    return Semantics(
      button: true,
      label: title,
      excludeSemantics: true,
      child: Material(
        color: AppColors.sf1,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: busy ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 64,
                  child: Stack(
                    children: [
                      const Positioned.fill(
                        child: CustomPaint(painter: _ScenePainter()),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: busy
                            ? const SizedBox.square(
                                dimension: 40,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : SourceIcon(source: source, size: 44),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyStrong,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Wave bars on the left turning into text lines on the right, the logo's
/// idea at card size. Drawn in surface tones and a little saffron.
class _ScenePainter extends CustomPainter {
  const _ScenePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final page = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * .38, 4, size.width * .62, size.height - 8),
      const Radius.circular(AppRadii.segment),
    );
    canvas.drawRRect(page, Paint()..color = AppColors.sf2);

    // Text lines on the page.
    final line = Paint()..color = AppColors.sf3;
    final left = page.left + 12;
    final widths = [.72, .52, .64];
    for (var i = 0; i < widths.length; i++) {
      final w = (page.width - 24) * widths[i];
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, page.top + 12 + i * 13.0, w, 5),
          const Radius.circular(2.5),
        ),
        line,
      );
    }

    // Wave bars running from the icon into the page.
    final bar = Paint()..color = AppColors.accent.withValues(alpha: .55);
    const heights = [10.0, 22.0, 14.0, 28.0, 12.0, 18.0];
    final cy = size.height / 2;
    var x = 52.0;
    for (final h in heights) {
      if (x + 3 > page.left + 4) break;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, cy - h / 2, 3, h),
          const Radius.circular(1.5),
        ),
        bar,
      );
      x += 7;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
