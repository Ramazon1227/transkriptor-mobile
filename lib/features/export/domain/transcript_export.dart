import 'dart:math' as math;

import 'package:transkriptor_uz/features/export/domain/export_options.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Builds export files from a transcript, on the phone. A port of
/// `tr-frontend/src/lib/export.ts` with its defaults, so a file made here
/// is byte-for-byte the one the web makes; the tests pin outputs taken
/// from the web code itself.
abstract final class TranscriptExport {
  // Subtitle cue limits, the web dialog's defaults.
  static const int lineLength = 42;
  static const int maxSeconds = 6;
  static const int lines = 2;

  static String render(
    ExportFormat format,
    Transcript transcript,
    ExportOptions options,
  ) {
    final rows = _rows(transcript, options);
    return switch (format) {
      ExportFormat.txt => _txt(rows, options),
      ExportFormat.srt => _srt(rows, options),
      ExportFormat.vtt => _vtt(rows, options),
      ExportFormat.csv => _csv(rows),
    };
  }

  /// The bytes the web's `download` saves: [render], plus the BOM for
  /// CSV.
  static String fileBody(
    ExportFormat format,
    Transcript transcript,
    ExportOptions options,
  ) =>
      '${format.hasBom ? '\uFEFF' : ''}'
      '${render(format, transcript, options)}';

  /// The web's `saveFile` name: characters no file system takes become `_`.
  static String fileName(String title, ExportFormat format) {
    final base = title.replaceAll(RegExp(r'[\\/:*?"<>|]+'), '_');
    return '${base.isEmpty ? 'transkript' : base}.${format.extension}';
  }

  /// `pkg/uz.Plain`: U+02BB and U+02BC back to `'`.
  static String plain(String s) => s.replaceAll(RegExp('[ʻʼ]'), "'");

  static List<_Row> _rows(Transcript t, ExportOptions o) {
    final labels = {for (final s in t.speakers) s.id: s.label};
    String fix(String s) => o.plainApostrophe ? plain(s) : s;
    return [
      for (final s in t.segments)
        _Row(
          start: s.start.inMilliseconds,
          end: s.end.inMilliseconds,
          text: fix(s.text),
          speaker: fix(labels[s.speakerId] ?? ''),
        ),
    ];
  }

  static String _txt(List<_Row> rows, ExportOptions o) {
    String line(_Row r) {
      final time = o.timecodes ? '[${_short(r.start)}] ' : '';
      final who = o.speakers && r.speaker.isNotEmpty ? '${r.speaker}: ' : '';
      return '$time$who${r.text}';
    }

    return '${rows.map(line).join('\n\n')}\n';
  }

  static String _srt(List<_Row> rows, ExportOptions o) {
    var n = 0;
    final out = <String>[];
    for (final r in rows) {
      final who = o.speakers && r.speaker.isNotEmpty ? '${r.speaker}: ' : '';
      final list = _cues(r);
      for (var i = 0; i < list.length; i++) {
        final c = list[i];
        n++;
        out.add(
          '$n\n${_stamp(c.start, ',')} --> ${_stamp(c.end, ',')}\n'
          '${i == 0 ? who : ''}${c.text}\n',
        );
      }
    }
    return out.join('\n');
  }

  static String _vtt(List<_Row> rows, ExportOptions o) {
    final out = <String>[];
    for (final r in rows) {
      final voice = o.speakers && r.speaker.isNotEmpty
          ? '<v ${r.speaker}>'
          : '';
      for (final c in _cues(r)) {
        out.add(
          '${_stamp(c.start, '.')} --> ${_stamp(c.end, '.')}\n'
          '$voice${c.text}\n',
        );
      }
    }
    return 'WEBVTT\n\n${out.join('\n')}';
  }

  /// One row per segment: times as `HH:MM:SS`, the speaker's name (empty
  /// without one) and the text. Neither switch applies, as on the web.
  static String _csv(List<_Row> rows) {
    final lines = [
      'start,end,speaker,text',
      for (final r in rows)
        [
          _short(r.start),
          _short(r.end),
          r.speaker,
          r.text,
        ].map(_csvCell).join(','),
    ];
    return '${lines.join('\n')}\n';
  }

  static String _csvCell(String value) => RegExp('[",\n]').hasMatch(value)
      ? '"${value.replaceAll('"', '""')}"'
      : value;

  /// One segment as subtitle cues: line length × lines and a longest
  /// duration. Time is split in proportion to characters — there is no
  /// word-level timing (`segment.words` is empty).
  static List<_Cue> _cues(_Row r) {
    final words = r.text
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return const [];
    final span = math.max(1, r.end - r.start);
    final capacity = math.max(8, lineLength * lines);
    final byTime = (span / (math.max(1, maxSeconds) * 1000)).ceil();
    final byChars = (r.text.length / capacity).ceil();
    final count = math.max(1, math.max(byTime, byChars));
    final target = (r.text.length / count).ceil();

    final chunks = <List<String>>[<String>[]];
    var size = 0;
    for (final w in words) {
      final last = chunks.last;
      if (last.isNotEmpty &&
          size + w.length + 1 > target &&
          chunks.length < count) {
        chunks.add([w]);
        size = w.length;
      } else {
        last.add(w);
        size += w.length + 1;
      }
    }

    final total = chunks.fold<int>(0, (n, c) => n + c.join(' ').length);
    num cursor = r.start;
    final out = <_Cue>[];
    for (var i = 0; i < chunks.length; i++) {
      final text = chunks[i].join(' ');
      final end = i == chunks.length - 1
          ? r.end
          : cursor + (span * text.length) / total;
      out.add(_Cue(start: cursor, end: end, text: _wrap(text)));
      cursor = end;
    }
    return out;
  }

  static String _wrap(String text) {
    final out = <String>[];
    var line = '';
    for (final w in text.split(' ')) {
      if (line.isNotEmpty &&
          '$line $w'.length > lineLength &&
          out.length < lines - 1) {
        out.add(line);
        line = w;
      } else {
        line = line.isEmpty ? w : '$line $w';
      }
    }
    out.add(line);
    return out.join('\n');
  }

  static String _stamp(num ms, String sep) {
    final t = math.max(0, ms.round());
    final h = t ~/ 3600000;
    final m = (t % 3600000) ~/ 60000;
    final s = (t % 60000) ~/ 1000;
    return '${_pad(h)}:${_pad(m)}:${_pad(s)}$sep${_pad(t % 1000, 3)}';
  }

  static String _short(num ms) => _stamp(ms, '.').substring(0, 8);

  static String _pad(int n, [int width = 2]) =>
      n.toString().padLeft(width, '0');
}

class _Row {
  const _Row({
    required this.start,
    required this.end,
    required this.text,
    required this.speaker,
  });

  final int start;
  final int end;
  final String text;
  final String speaker;
}

class _Cue {
  const _Cue({required this.start, required this.end, required this.text});

  final num start;
  final num end;
  final String text;
}
