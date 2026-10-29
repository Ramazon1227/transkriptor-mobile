/// Timecodes and dates the way the design book writes them:
/// `00:04:38`, `12.10.2026`.
abstract final class Formatters {
  /// `HH:MM:SS`; hours are kept even when zero, so columns line up.
  static String timecode(Duration d) {
    final total = d.inSeconds < 0 ? 0 : d.inSeconds;
    final h = total ~/ 3600;
    final m = (total % 3600) ~/ 60;
    final s = total % 60;
    return '${_two(h)}:${_two(m)}:${_two(s)}';
  }

  /// `dd.MM.yyyy` in local time.
  static String date(DateTime d) {
    final l = d.toLocal();
    return '${_two(l.day)}.${_two(l.month)}.${l.year}';
  }

  /// `14:05` in local time.
  static String clock(DateTime d) {
    final l = d.toLocal();
    return '${_two(l.hour)}:${_two(l.minute)}';
  }

  /// `49 000` — whole so'm, thousands split by a space as Uzbek writes
  /// prices.
  static String money(num amount) {
    final digits = amount.round().abs().toString();
    final out = StringBuffer(amount < 0 ? '-' : '');
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) out.write(' ');
      out.write(digits[i]);
    }
    return out.toString();
  }

  /// Whole minutes left; a partial minute is not promised.
  static int minutesLeft(int seconds) => seconds <= 0 ? 0 : seconds ~/ 60;

  /// Minutes a file will reserve; a started minute counts.
  static int minutesNeeded(Duration d) =>
      d.inSeconds <= 0 ? 0 : (d.inSeconds + 59) ~/ 60;

  /// `3,1` — one decimal, comma, as Uzbek writes numbers.
  static String megabytes(int bytes) =>
      (bytes / (1024 * 1024)).toStringAsFixed(1).replaceAll('.', ',');

  static String _two(int n) => n.toString().padLeft(2, '0');
}
