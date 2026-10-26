import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';

/// The logo mark: a sound wave turning into lines of text, on mint
/// (`design/logos.html`, option 1). Drawn, so it needs no asset.
class AppMark extends StatelessWidget {
  const AppMark({this.size = 32, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: const CustomPaint(painter: _MarkPainter()),
    );
  }
}

class _MarkPainter extends CustomPainter {
  const _MarkPainter();

  static const _ink = Color(0xFF06281F);

  /// Bars in the 32×32 design grid: x, y, width, height.
  static const _bars = <(double, double, double, double)>[
    (5, 12, 2.6, 8),
    (9, 8.5, 2.6, 15),
    (13, 11, 2.6, 10),
    (18, 10.5, 9, 2.6),
    (18, 14.7, 6.5, 2.6),
    (18, 18.9, 8, 2.6),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final k = size.width / 32;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(8 * k)),
      Paint()..color = AppColors.mint,
    );
    final ink = Paint()..color = _ink;
    for (final (x, y, w, h) in _bars) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x * k, y * k, w * k, h * k),
          Radius.circular(1.3 * k),
        ),
        ink,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
