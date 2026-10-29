import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';

/// A home entry card: a small drawn composition (no image assets) over a
/// title. Every card shares the frame — the source's icon, a sound wave
/// running right — and ends in that source's own object (a file, a video
/// frame, a level meter, a meeting grid), so the cards read as one family
/// but are told apart at a glance.
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
                      Positioned.fill(
                        child: CustomPaint(painter: _ScenePainter(source)),
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

/// Wave bars from the icon into the source's object on the right. Drawn
/// in surface tones and a little saffron.
class _ScenePainter extends CustomPainter {
  const _ScenePainter(this.source);

  final CaptureSource source;

  static final _surface = Paint()..color = AppColors.sf2;
  static final _line = Paint()..color = AppColors.sf3;
  static final _accent = Paint()..color = AppColors.accent;
  static final _bar = Paint()..color = AppColors.accent.withValues(alpha: .55);

  @override
  void paint(Canvas canvas, Size size) {
    final object = Rect.fromLTWH(
      size.width * .40,
      4,
      size.width * .60,
      size.height - 8,
    );
    _wave(canvas, size, object.left);
    switch (source) {
      case CaptureSource.upload:
        _files(canvas, object);
      case CaptureSource.youtube:
        _video(canvas, object);
      case CaptureSource.recording:
      case CaptureSource.dictation:
        _meter(canvas, object);
      case CaptureSource.meeting:
        _meeting(canvas, object);
      case CaptureSource.screen:
      case CaptureSource.cloud:
      case CaptureSource.url:
      case CaptureSource.note:
        _page(canvas, object);
    }
  }

  void _wave(Canvas canvas, Size size, double end) {
    const heights = [10.0, 22.0, 14.0, 28.0, 12.0, 18.0];
    final cy = size.height / 2;
    var x = 52.0;
    for (final h in heights) {
      if (x + 3 > end - 4) break;
      _pill(canvas, Rect.fromLTWH(x, cy - h / 2, 3, h), _bar);
      x += 7;
    }
  }

  void _pill(Canvas canvas, Rect r, Paint paint) => canvas.drawRRect(
    RRect.fromRectAndRadius(r, Radius.circular(r.shortestSide / 2)),
    paint,
  );

  void _lines(
    Canvas canvas,
    Rect area,
    List<double> widths, {
    double gap = 12,
  }) {
    for (var i = 0; i < widths.length; i++) {
      final top = area.top + i * gap;
      if (top + 5 > area.bottom) break;
      _pill(
        canvas,
        Rect.fromLTWH(area.left, top, area.width * widths[i], 5),
        _line,
      );
    }
  }

  /// Text lines on a page — the result every source ends in.
  void _page(Canvas canvas, Rect r) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(AppRadii.segment)),
      _surface,
    );
    _lines(canvas, r.deflate(12), const [.72, .52, .64], gap: 13);
  }

  /// Two files, the front one with a folded corner and an arrow up.
  void _files(Canvas canvas, Rect r) {
    final w = r.height * .78;
    final back = Rect.fromLTWH(r.center.dx - w * .35, r.top, w, r.height - 6);
    final front = back.translate(-w * .42, 6);
    canvas.drawRRect(
      RRect.fromRectAndRadius(back, const Radius.circular(6)),
      _line,
    );
    const fold = 12.0;
    final sheet = Path()
      ..moveTo(front.left + 6, front.top)
      ..lineTo(front.right - fold, front.top)
      ..lineTo(front.right, front.top + fold)
      ..lineTo(front.right, front.bottom - 6)
      ..quadraticBezierTo(
        front.right,
        front.bottom,
        front.right - 6,
        front.bottom,
      )
      ..lineTo(front.left + 6, front.bottom)
      ..quadraticBezierTo(
        front.left,
        front.bottom,
        front.left,
        front.bottom - 6,
      )
      ..lineTo(front.left, front.top + 6)
      ..quadraticBezierTo(front.left, front.top, front.left + 6, front.top)
      ..close();
    canvas
      ..drawPath(sheet, _surface)
      ..drawPath(
        Path()
          ..moveTo(front.right - fold, front.top)
          ..lineTo(front.right - fold, front.top + fold)
          ..lineTo(front.right, front.top + fold)
          ..close(),
        _line,
      );
    final c = Offset(front.center.dx, front.center.dy + 2);
    final arrow = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas
      ..drawLine(c.translate(0, 9), c.translate(0, -8), arrow)
      ..drawPath(
        Path()
          ..moveTo(c.dx - 6, c.dy - 2)
          ..lineTo(c.dx, c.dy - 8)
          ..lineTo(c.dx + 6, c.dy - 2),
        arrow,
      );
  }

  /// A video frame with a play mark and a seek bar.
  void _video(Canvas canvas, Rect r) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(AppRadii.segment)),
      _surface,
    );
    final c = Offset(r.center.dx, r.center.dy - 5);
    canvas.drawPath(
      Path()
        ..moveTo(c.dx - 6, c.dy - 9)
        ..lineTo(c.dx + 10, c.dy)
        ..lineTo(c.dx - 6, c.dy + 9)
        ..close(),
      _accent,
    );
    final track = Rect.fromLTWH(r.left + 10, r.bottom - 11, r.width - 20, 4);
    _pill(canvas, track, _line);
    _pill(
      canvas,
      Rect.fromLTWH(track.left, track.top, track.width * .4, 4),
      _accent,
    );
  }

  /// A live level meter: bars rising to the right, the loudest saffron.
  void _meter(Canvas canvas, Rect r) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(AppRadii.segment)),
      _surface,
    );
    const levels = [.25, .45, .7, .5, .9, .6, .35, .55, .3];
    final inner = r.deflate(10);
    final step = inner.width / levels.length;
    for (var i = 0; i < levels.length; i++) {
      final h = inner.height * levels[i];
      _pill(
        canvas,
        Rect.fromLTWH(
          inner.left + i * step + (step - 4) / 2,
          inner.center.dy - h / 2,
          4,
          h,
        ),
        levels[i] >= .7 ? _accent : _line,
      );
    }
  }

  /// Four participant tiles, each a head in a speaker colour.
  void _meeting(Canvas canvas, Rect r) {
    const gap = 4.0;
    final w = (r.width - gap) / 2;
    final h = (r.height - gap) / 2;
    for (var i = 0; i < 4; i++) {
      final tile = Rect.fromLTWH(
        r.left + (i % 2) * (w + gap),
        r.top + (i ~/ 2) * (h + gap),
        w,
        h,
      );
      canvas
        ..drawRRect(
          RRect.fromRectAndRadius(tile, const Radius.circular(6)),
          _surface,
        )
        ..drawCircle(
          tile.center,
          h * .26,
          Paint()..color = AppColors.speaker(i + 1).withValues(alpha: .8),
        );
    }
  }

  @override
  bool shouldRepaint(covariant _ScenePainter oldDelegate) =>
      oldDelegate.source != source;
}
