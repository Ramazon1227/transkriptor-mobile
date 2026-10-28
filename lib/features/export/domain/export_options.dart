import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_options.freezed.dart';

/// The web export's formats, in the web dialog's order: Word and PDF,
/// then text, subtitles and the table.
enum ExportFormat {
  docx(
    'docx',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  ),
  pdf('pdf', 'application/pdf'),
  txt('txt', 'text/plain'),
  srt('srt', 'application/x-subrip'),
  vtt('vtt', 'text/vtt'),
  csv('csv', 'text/csv');

  ExportFormat(this.extension, this.mimeType);

  final String extension;
  final String mimeType;

  /// TXT, DOCX and PDF: paragraphs of prose, built from the same blocks.
  bool get isProse => this == txt || this == docx || this == pdf;

  /// Subtitles and CSV always carry times; the timecode switch is the
  /// prose formats' only.
  bool get usesTimecodeSwitch => isProse;

  /// CSV always has its speaker column: the web's `render("csv")` reads
  /// neither switch.
  bool get usesSpeakerSwitch => this != csv;

  /// The text layout is the prose formats' only; subtitles and CSV split
  /// by time.
  bool get usesLayout => isProse;

  /// The web prepends U+FEFF to a CSV download so Excel reads Uzbek and
  /// Cyrillic letters as UTF-8; the phone's file carries it too.
  bool get hasBom => this == csv;
}

/// How TXT is cut into paragraphs — the web dialog's «Matn tuzilishi».
enum ExportLayout {
  /// One paragraph per segment, the web's default.
  segments,

  /// One paragraph per turn: consecutive segments of one speaker joined.
  speaker,

  /// Each turn cut every [ExportOptions.sentences] sentences.
  paragraphs,

  /// The whole text as one paragraph, without times or names.
  single,
}

/// The web dialog's «Paragrafda gap» choices.
const List<int> sentenceCounts = [1, 2, 4, 8];

/// The web export dialog's defaults.
@freezed
abstract class ExportOptions with _$ExportOptions {
  const factory ExportOptions({
    @Default(true) bool timecodes,
    @Default(true) bool speakers,

    /// oʻ/gʻ and the tutuq as a plain `'` — many people search and type
    /// with it. The stored text keeps U+02BB / U+02BC.
    @Default(false) bool plainApostrophe,
    @Default(ExportLayout.segments) ExportLayout layout,

    /// Sentences per paragraph in [ExportLayout.paragraphs].
    @Default(2) int sentences,
  }) = _ExportOptions;
}
