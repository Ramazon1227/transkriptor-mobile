import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_options.freezed.dart';

/// TXT, SRT and VTT — the web export's text and subtitle formats.
enum ExportFormat {
  txt('txt', 'text/plain'),
  srt('srt', 'application/x-subrip'),
  vtt('vtt', 'text/vtt');

  ExportFormat(this.extension, this.mimeType);

  final String extension;
  final String mimeType;

  /// Subtitles always carry times; the timecode switch is TXT's only.
  bool get isSubtitle => this != txt;
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
