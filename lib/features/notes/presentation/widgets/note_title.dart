import 'package:transkriptor_uz/core/l10n/l10n.dart';

/// What a note is called on screen: its title, else the start of its
/// text, else «Nomsiz eslatma».
String noteDisplayTitle(AppLocalizations l10n, String title, String text) {
  final t = title.trim();
  if (t.isNotEmpty) return t;
  final first = text.trim().split('\n').first.trim();
  return first.isNotEmpty ? first : l10n.noteUntitled;
}
