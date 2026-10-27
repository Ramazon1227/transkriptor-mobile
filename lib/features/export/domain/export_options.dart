import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_options.freezed.dart';

/// TXT, SRT, VTT and CSV — the web export's text, subtitle and table
/// formats.
enum ExportFormat {
  txt('txt', 'text/plain'),
  srt('srt', 'application/x-subrip'),
  vtt('vtt', 'text/vtt'),
  csv('csv', 'text/csv');

  ExportFormat(this.extension, this.mimeType);

  final String extension;
  final String mimeType;

  /// Subtitles and CSV always carry times; the timecode switch is TXT's
  /// only.
  bool get usesTimecodeSwitch => this == txt;

  /// CSV always has its speaker column: the web's `render("csv")` reads
  /// neither switch.
  bool get usesSpeakerSwitch => this != csv;

  /// The web prepends U+FEFF to a CSV download so Excel reads Uzbek and
  /// Cyrillic letters as UTF-8; the phone's file carries it too.
  bool get hasBom => this == csv;
}

/// The web export dialog's defaults, minus the layouts the phone does not
/// offer: one TXT block per segment, as the web's default "segments".
@freezed
abstract class ExportOptions with _$ExportOptions {
  const factory ExportOptions({
    @Default(true) bool timecodes,
    @Default(true) bool speakers,

    /// oʻ/gʻ and the tutuq as a plain `'` — many people search and type
    /// with it. The stored text keeps U+02BB / U+02BC.
    @Default(false) bool plainApostrophe,
  }) = _ExportOptions;
}
