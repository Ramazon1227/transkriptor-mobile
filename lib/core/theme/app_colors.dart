import 'package:flutter/painting.dart';

/// Mirrors `design/tokens.css`, the single source for colour. Change the
/// token there first, then here.
abstract final class AppColors {
  // Surfaces — warm near-black, not navy. Elevation separates them.
  static const Color sf0 = Color(0xFF120F16);
  static const Color sf1 = Color(0xFF1A161F);
  static const Color sf2 = Color(0xFF241E2A);
  static const Color sf3 = Color(0xFF342C3B);

  // Text on the dark ground.
  static const Color cotton = Color(0xFFF3EFE9);
  static const Color mutedDark = Color(0xFF9B919F);

  // Saffron: action and active state. Text on it is always dark.
  static const Color accent = Color(0xFFFFAE2B);
  static const Color accentHi = Color(0xFFFFC761);
  static const Color accentSoft = Color(0xFF33240A);
  static const Color accentText = Color(0xFF1A1206);

  // Coral: needs attention. Mint: machine markers only.
  static const Color warn = Color(0xFFFF8A5C);
  static const Color mint = Color(0xFF5FD9BE);

  // Error red. tokens.css has no red yet; these are the web app's
  // `.flash--bad` pair (tr-frontend `styles/app.css`), so both clients
  // say "failed" in the same colour. Only for errors — never decoration.
  static const Color bad = Color(0xFFFF7A8F);
  static const Color badSoft = Color(0xFF3D1119);

  // Diarization colours. Neighbouring speakers never get close hues, so
  // the sequence jumps on purpose.
  static const List<Color> speakers = [
    Color(0xFF7AA2FF),
    Color(0xFFFFAE2B),
    Color(0xFF5FD9BE),
    Color(0xFFFF8FA3),
  ];

  /// Speaker colour by first-appearance ordinal (from 1).
  static Color speaker(int ordinal) =>
      speakers[(ordinal <= 0 ? 0 : ordinal - 1) % speakers.length];
}
