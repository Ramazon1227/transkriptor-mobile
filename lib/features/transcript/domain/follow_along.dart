import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Which segment the player is in. Segments come in position order, so
/// their starts rise; times are segment level only (no word timing).
abstract final class FollowAlong {
  /// How far back to look past the last segment that started: diarized
  /// segments may overlap, and a short one inside a long one must not
  /// hide the long one.
  static const int _overlapLookBack = 3;

  /// The id of the segment being spoken at [t]: the latest one that has
  /// started and not yet ended. Null before the first, after the last
  /// and in a silent gap between two.
  static String? activeId(List<Segment> segments, Duration t) {
    var lo = 0;
    var hi = segments.length - 1;
    var last = -1;
    while (lo <= hi) {
      final mid = (lo + hi) >> 1;
      if (segments[mid].start <= t) {
        last = mid;
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }
    for (var i = last; i >= 0 && i > last - _overlapLookBack; i--) {
      if (t < segments[i].end) return segments[i].id;
    }
    return null;
  }
}
