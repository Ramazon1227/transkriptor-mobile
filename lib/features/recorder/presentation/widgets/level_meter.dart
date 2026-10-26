import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/features/recorder/application/recorder_cubit.dart';

/// Recent input levels as bars, newest on the right. Empty slots on the
/// left are drawn flat, so the meter fills in as recording goes on.
class LevelMeter extends StatelessWidget {
  const LevelMeter({required this.levels, super.key});

  /// Each 0–1, most recent last.
  final List<double> levels;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(size: Size.infinite, painter: _MeterPainter(levels)),
    );
  }
}

class _MeterPainter extends CustomPainter {
  _MeterPainter(this.levels);

  final List<double> levels;

  @override
  void paint(Canvas canvas, Size size) {
    const slots = recorderMeterLength;
    const gap = 3.0;
    final barWidth = (size.width - gap * (slots - 1)) / slots;
    if (barWidth <= 0) return;
    final paint = Paint();
    final offset = slots - levels.length;
    for (var i = 0; i < slots; i++) {
      final index = i - offset;
      final level = index >= 0 ? levels[index] : 0.0;
      final height = (size.height * level).clamp(4.0, size.height);
      paint.color = index >= 0 ? AppColors.accent : AppColors.sf3;
      final x = i * (barWidth + gap);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, (size.height - height) / 2, barWidth, height),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_MeterPainter oldDelegate) => oldDelegate.levels != levels;
}
