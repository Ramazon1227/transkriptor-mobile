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
      // DOCX and PDF read as TXT does, as the web's preview and copy do.
      ExportFormat.txt ||
      ExportFormat.docx ||
      ExportFormat.pdf => _txt(rows, options),
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

  /// The paragraphs DOCX and PDF are made of — the web's `blocks`.
  static List<ExportBlock> blocks(Transcript t, ExportOptions o) =>
      _blocks(_rows(t, o), o);

  /// The document heading: the title, with plain apostrophes if chosen.
  static String title(Transcript t, ExportOptions o) =>
      o.plainApostrophe ? plain(t.title) : t.title;

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
    String line(ExportBlock b) {
      final time = b.time != null ? '[${b.time}] ' : '';
      final who = b.speaker.isNotEmpty ? '${b.speaker}: ' : '';
      return '$time$who${b.text}';
    }

    return '${_blocks(rows, o).map(line).join('\n\n')}\n';
  }

  /// The web's `blocks`: TXT's paragraphs by [ExportOptions.layout]. A
  /// block's time is null and its speaker empty when the switch is off.
  static List<ExportBlock> _blocks(List<_Row> rows, ExportOptions o) {
    ExportBlock block(int start, String speaker, String text) => ExportBlock(
      time: o.timecodes ? _short(start) : null,
      speaker: o.speakers ? speaker : '',
      text: text,
    );
    String joined(List<_Row> list) =>
        list.map((r) => r.text.trim()).where((t) => t.isNotEmpty).join(' ');

    switch (o.layout) {
      case ExportLayout.single:
        return [ExportBlock(time: null, speaker: '', text: joined(rows))];
      case ExportLayout.speaker:
        return [
          for (final t in _turns(rows))
            block(t.first.start, t.first.speaker, joined(t)),
        ];
      case ExportLayout.paragraphs:
        final size = math.max(1, o.sentences);
        final out = <ExportBlock>[];
        for (final t in _turns(rows)) {
          final list = _sentences(t);
          for (var i = 0; i < list.length; i += size) {
            final group = list.sublist(i, math.min(i + size, list.length));
            out.add(
              block(
                group.first.start,
                i == 0 ? t.first.speaker : '',
                group.map((g) => g.text).join(' '),
              ),
            );
          }
        }
        return out;
      case ExportLayout.segments:
        return [for (final r in rows) block(r.start, r.speaker, r.text)];
    }
  }

  /// Consecutive segments of one speaker — one turn. Grouped by the name,
  /// as the web does.
  static List<List<_Row>> _turns(List<_Row> rows) {
    final out = <List<_Row>>[];
    for (final r in rows) {
      if (out.isNotEmpty && out.last.last.speaker == r.speaker) {
        out.last.add(r);
      } else {
        out.add([r]);
      }
    }
    return out;
  }

  static final _sentenceBreak = RegExp(r'(?<=[.!?…])\s+');
  static final _sentenceEnd = RegExp('[.!?…]["»”\')]*\$');

  /// A turn cut into sentences. A sentence may cross a segment boundary;
  /// its time is the start of the segment it began in — there is no
  /// word-level timing.
  static List<_Sentence> _sentences(List<_Row> turn) {
    final out = <_Sentence>[];
    _Sentence? open;
    for (final r in turn) {
      final pieces = r.text
          .trim()
          .split(_sentenceBreak)
          .where((p) => p.isNotEmpty);
      for (final piece in pieces) {
        final current = open;
        open = current == null
            ? _Sentence(start: r.start, text: piece)
            : _Sentence(start: current.start, text: '${current.text} $piece');
        if (_sentenceEnd.hasMatch(piece)) {
          out.add(open);
          open = null;
        }
      }
    }
    final last = open;
    if (last != null) out.add(last);
    return out;
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

/// One paragraph of the prose formats. [time] is null and [speaker] empty
/// when the switch is off or the layout leaves them out.
class ExportBlock {
  const ExportBlock({
    required this.time,
    required this.speaker,
    required this.text,
  });

  final String? time;
  final String speaker;
  final String text;
}

class _Sentence {
  const _Sentence({required this.start, required this.text});

  final int start;
  final String text;
}
