import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';

/// Every way a file gets into the app, plus notes. Used by the source
/// sheet, the home cards and (later) the files list.
enum CaptureSource {
  upload,
  youtube,
  recording,
  dictation,
  screen,
  cloud,
  meeting,
  url,
  note,
}

extension CaptureSourceIcon on CaptureSource {
  IconData get icon => switch (this) {
    CaptureSource.upload => Icons.upload_file_rounded,
    CaptureSource.youtube => Icons.smart_display_rounded,
    CaptureSource.recording => Icons.mic_rounded,
    CaptureSource.dictation => Icons.keyboard_voice_rounded,
    CaptureSource.screen => Icons.screenshot_monitor_rounded,
    CaptureSource.cloud => Icons.cloud_rounded,
    CaptureSource.meeting => Icons.video_camera_front_rounded,
    CaptureSource.url => Icons.link_rounded,
    CaptureSource.note => Icons.sticky_note_2_rounded,
  };
}

/// A rounded tile with the source's icon: saffron on its soft ground,
/// because every source is an action. Mint stays for machine markers.
class SourceIcon extends StatelessWidget {
  const SourceIcon({required this.source, this.size = 40, super.key});

  final CaptureSource source;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadii.segment),
      ),
      child: Icon(source.icon, color: AppColors.accent, size: size * .5),
    );
  }
}
