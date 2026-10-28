import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Keeps a page's content at a readable width on tablets and in
/// landscape, centred; on a phone in portrait it changes nothing. The app
/// bar and the bottom bar stay full width — only the body is held in.
class ContentWidth extends StatelessWidget {
  const ContentWidth({required this.child, this.maxWidth = form, super.key});

  /// Forms and single-column pages: sign-in, upload, a job, the recorder.
  static const double form = 520;

  /// Lists and reading: files, the home screen, a transcript.
  static const double list = 760;

  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        if (box.maxWidth <= maxWidth) return child;
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: math.min(box.maxWidth, maxWidth),
            height: box.hasBoundedHeight ? box.maxHeight : null,
            child: child,
          ),
        );
      },
    );
  }
}
