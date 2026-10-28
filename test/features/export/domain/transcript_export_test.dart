// The expected files are pasted verbatim from the web's output; wrapping
// them would hide a byte difference.
// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/export/domain/export_options.dart';
import 'package:transkriptor_uz/features/export/domain/transcript_export.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

// Expected outputs were produced by running tr-frontend/src/lib/export.ts
// (render, default options) on the same four segments in Node, 2026-10-27
// (`node:22-alpine`, `--experimental-strip-types`).
// A mismatch means the phone and the web would export different files.
const _txt =
    '[00:00:00] Ali: Salom. Bugun reja bor.\n\n[00:00:04] Ali: Birinchi masala byudjet, ikkinchisi\n\n[00:00:09] muddat. Uchinchisi jamoa.\n\n[00:01:05] Vali: Roziman! Davom etamiz? Keyingi yigʻilishda moliyaviy hisobotni koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin.\n';
const _txtBare =
    'Salom. Bugun reja bor.\n\nBirinchi masala byudjet, ikkinchisi\n\nmuddat. Uchinchisi jamoa.\n\nRoziman! Davom etamiz? Keyingi yigʻilishda moliyaviy hisobotni koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin.\n';
const _srt =
    '1\n00:00:00,000 --> 00:00:04,000\nAli: Salom. Bugun reja bor.\n\n2\n00:00:04,000 --> 00:00:09,000\nAli: Birinchi masala byudjet, ikkinchisi\n\n3\n00:00:09,000 --> 00:00:12,000\nmuddat. Uchinchisi jamoa.\n\n4\n00:01:05,000 --> 00:01:09,872\nVali: Roziman! Davom etamiz? Keyingi yigʻilishda\n\n5\n00:01:09,872 --> 00:01:14,280\nmoliyaviy hisobotni koʻrib chiqamiz va\n\n6\n00:01:14,280 --> 00:01:19,500\nqarorni ovozga qoʻyamiz, chunki muddat\nyaqin.\n';
const _vtt =
    'WEBVTT\n\n00:00:00.000 --> 00:00:04.000\n<v Ali>Salom. Bugun reja bor.\n\n00:00:04.000 --> 00:00:09.000\n<v Ali>Birinchi masala byudjet, ikkinchisi\n\n00:00:09.000 --> 00:00:12.000\nmuddat. Uchinchisi jamoa.\n\n00:01:05.000 --> 00:01:09.872\n<v Vali>Roziman! Davom etamiz? Keyingi yigʻilishda\n\n00:01:09.872 --> 00:01:14.280\n<v Vali>moliyaviy hisobotni koʻrib chiqamiz va\n\n00:01:14.280 --> 00:01:19.500\n<v Vali>qarorni ovozga qoʻyamiz, chunki muddat\nyaqin.\n';
const _vttBare =
    'WEBVTT\n\n00:00:00.000 --> 00:00:04.000\nSalom. Bugun reja bor.\n\n00:00:04.000 --> 00:00:09.000\nBirinchi masala byudjet, ikkinchisi\n\n00:00:09.000 --> 00:00:12.000\nmuddat. Uchinchisi jamoa.\n\n00:01:05.000 --> 00:01:09.872\nRoziman! Davom etamiz? Keyingi yigʻilishda\n\n00:01:09.872 --> 00:01:14.280\nmoliyaviy hisobotni koʻrib chiqamiz va\n\n00:01:14.280 --> 00:01:19.500\nqarorni ovozga qoʻyamiz, chunki muddat\nyaqin.\n';

// CSV: same run, plus `quoted` below; the web's `render("csv")` reads
// neither the timecode nor the speaker switch (checked: identical output
// with both off), and `plainSegments` applies before it.
const _csv =
    'start,end,speaker,text\n00:00:00,00:00:04,Ali,Salom. Bugun reja bor.\n00:00:04,00:00:09,Ali,"Birinchi masala byudjet, ikkinchisi"\n00:00:09,00:00:12,,muddat. Uchinchisi jamoa.\n00:01:05,00:01:19,Vali,"Roziman! Davom etamiz? Keyingi yigʻilishda moliyaviy hisobotni koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin."\n';
const _csvQuoted =
    'start,end,speaker,text\n01:02:03,01:02:05,"Ali, Vali","U ""ha"" dedi"\n00:00:00,00:00:01,Gʻani,taʼlim oʻzbek\n';
const _csvPlain =
    'start,end,speaker,text\n01:02:03,01:02:05,"Ali, Vali","U ""ha"" dedi"\n00:00:00,00:00:01,G\'ani,ta\'lim o\'zbek\n';

// Layouts: tr-frontend/src/lib/export.ts `render("txt")` run in Node,
// 2026-10-28, on [_layoutTranscript] below. One turn of Ali crosses three
// segments with a sentence split across two of them; a speakerless
// segment ends in `.»` (not a break, as on the web); the last one has
// trailing spaces.
const _layoutSpeaker =
    '[00:00:00] Ali: Salom. Bugun reja bor. Birinchi masala byudjet, ikkinchisi muddat. Uchinchisi jamoa.\n\n[00:01:05] Vali: Roziman! Davom etamiz? Keyingi yigʻilishda moliyaviy hisobotni koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin.\n\n[00:01:20] U dedi: «Ha.» Keyin ketdi\n\n[00:01:23] Vali: Tamom…\n';
const _layoutSpeakerBare =
    'Salom. Bugun reja bor. Birinchi masala byudjet, ikkinchisi muddat. Uchinchisi jamoa.\n\nRoziman! Davom etamiz? Keyingi yigʻilishda moliyaviy hisobotni koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin.\n\nU dedi: «Ha.» Keyin ketdi\n\nTamom…\n';
const _layoutPara1 =
    '[00:00:00] Ali: Salom.\n\n[00:00:00] Bugun reja bor.\n\n[00:00:04] Birinchi masala byudjet, ikkinchisi muddat.\n\n[00:00:09] Uchinchisi jamoa.\n\n[00:01:05] Vali: Roziman!\n\n[00:01:05] Davom etamiz?\n\n[00:01:05] Keyingi yigʻilishda moliyaviy hisobotni koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin.\n\n[00:01:20] U dedi: «Ha.» Keyin ketdi\n\n[00:01:23] Vali: Tamom…\n';
const _layoutPara2 =
    '[00:00:00] Ali: Salom. Bugun reja bor.\n\n[00:00:04] Birinchi masala byudjet, ikkinchisi muddat. Uchinchisi jamoa.\n\n[00:01:05] Vali: Roziman! Davom etamiz?\n\n[00:01:05] Keyingi yigʻilishda moliyaviy hisobotni koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin.\n\n[00:01:20] U dedi: «Ha.» Keyin ketdi\n\n[00:01:23] Vali: Tamom…\n';
const _layoutPara8NoTime =
    'Ali: Salom. Bugun reja bor. Birinchi masala byudjet, ikkinchisi muddat. Uchinchisi jamoa.\n\nVali: Roziman! Davom etamiz? Keyingi yigʻilishda moliyaviy hisobotni koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin.\n\nU dedi: «Ha.» Keyin ketdi\n\nVali: Tamom…\n';
const _layoutSingle =
    'Salom. Bugun reja bor. Birinchi masala byudjet, ikkinchisi muddat. Uchinchisi jamoa. Roziman! Davom etamiz? Keyingi yigʻilishda moliyaviy hisobotni koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin. U dedi: «Ha.» Keyin ketdi Tamom…\n';

Segment _seg(String id, String? speaker, int start, int end, String text) =>
    Segment(
      id: id,
      start: Duration(milliseconds: start),
      end: Duration(milliseconds: end),
      text: text,
      speakerId: speaker,
    );

final _transcript = Transcript(
  id: 't1',
  title: 'Kengash: 27/10',
  speakers: const [
    Speaker(id: 'a', label: 'Ali', ordinal: 1),
    Speaker(id: 'v', label: 'Vali', ordinal: 2),
  ],
  segments: [
    _seg('1', 'a', 0, 4000, 'Salom. Bugun reja bor.'),
    _seg('2', 'a', 4000, 9000, 'Birinchi masala byudjet, ikkinchisi'),
    // No speaker: no prefix and no voice tag.
    _seg('3', null, 9000, 12000, 'muddat. Uchinchisi jamoa.'),
    _seg(
      '4',
      'v',
      65000,
      79500,
      'Roziman! Davom etamiz? Keyingi yigʻilishda moliyaviy hisobotni '
          'koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin.',
    ),
  ],
);

final Transcript _layoutTranscript = _transcript.copyWith(
  segments: [
    _seg('1', 'a', 0, 4000, 'Salom. Bugun reja bor.'),
    _seg('2', 'a', 4000, 9000, 'Birinchi masala byudjet, ikkinchisi'),
    _seg('3', 'a', 9000, 12000, 'muddat. Uchinchisi jamoa.'),
    _seg(
      '4',
      'v',
      65000,
      79500,
      'Roziman! Davom etamiz? Keyingi yigʻilishda moliyaviy hisobotni '
          'koʻrib chiqamiz va qarorni ovozga qoʻyamiz, chunki muddat yaqin.',
    ),
    _seg('5', null, 80000, 82000, 'U dedi: «Ha.» Keyin ketdi'),
    _seg('6', 'v', 83000, 85000, 'Tamom…   '),
  ],
);

void main() {
  const base = ExportOptions();

  test('TXT matches the web', () {
    expect(TranscriptExport.render(ExportFormat.txt, _transcript, base), _txt);
    expect(
      TranscriptExport.render(
        ExportFormat.txt,
        _transcript,
        const ExportOptions(timecodes: false, speakers: false),
      ),
      _txtBare,
    );
  });

  test('SRT matches the web, long segments split into cues', () {
    expect(TranscriptExport.render(ExportFormat.srt, _transcript, base), _srt);
  });

  test('VTT matches the web, with and without voice tags', () {
    expect(TranscriptExport.render(ExportFormat.vtt, _transcript, base), _vtt);
    expect(
      TranscriptExport.render(
        ExportFormat.vtt,
        _transcript,
        const ExportOptions(speakers: false),
      ),
      _vttBare,
    );
  });

  test('subtitles ignore the timecode switch', () {
    expect(
      TranscriptExport.render(
        ExportFormat.srt,
        _transcript,
        const ExportOptions(timecodes: false),
      ),
      _srt,
    );
  });

  test('plain apostrophe replaces U+02BB and U+02BC, text and names', () {
    final t = _transcript.copyWith(
      speakers: const [Speaker(id: 'a', label: 'Gʻani', ordinal: 1)],
      segments: [_seg('1', 'a', 0, 1000, 'taʼlim oʻzbek')],
    );
    expect(
      TranscriptExport.render(
        ExportFormat.txt,
        t,
        const ExportOptions(plainApostrophe: true),
      ),
      "[00:00:00] G'ani: ta'lim o'zbek\n",
    );
  });

  test('CSV matches the web and ignores both switches', () {
    expect(TranscriptExport.render(ExportFormat.csv, _transcript, base), _csv);
    expect(
      TranscriptExport.render(
        ExportFormat.csv,
        _transcript,
        const ExportOptions(timecodes: false, speakers: false),
      ),
      _csv,
    );
  });

  test('CSV quotes commas and quotes; plain apostrophe applies', () {
    final quoted = _transcript.copyWith(
      speakers: const [
        Speaker(id: 'av', label: 'Ali, Vali', ordinal: 1),
        Speaker(id: 'g', label: 'Gʻani', ordinal: 2),
      ],
      segments: [
        _seg('1', 'av', 3723456, 3725000, 'U "ha" dedi'),
        _seg('2', 'g', 0, 1000, 'taʼlim oʻzbek'),
      ],
    );
    expect(TranscriptExport.render(ExportFormat.csv, quoted, base), _csvQuoted);
    expect(
      TranscriptExport.render(
        ExportFormat.csv,
        quoted,
        const ExportOptions(plainApostrophe: true),
      ),
      _csvPlain,
    );
  });

  test('the CSV file starts with a BOM, as the web download does', () {
    final body = TranscriptExport.fileBody(ExportFormat.csv, _transcript, base);
    expect(body, '\uFEFF$_csv');
    expect(
      TranscriptExport.fileBody(ExportFormat.txt, _transcript, base),
      _txt,
    );
    expect(
      TranscriptExport.fileName('Kengash', ExportFormat.csv),
      'Kengash.csv',
    );
  });

  group('TXT layouts match the web', () {
    String txt(ExportOptions o) =>
        TranscriptExport.render(ExportFormat.txt, _layoutTranscript, o);

    test("by speaker joins one speaker's consecutive segments", () {
      expect(
        txt(const ExportOptions(layout: ExportLayout.speaker)),
        _layoutSpeaker,
      );
      expect(
        txt(
          const ExportOptions(
            layout: ExportLayout.speaker,
            timecodes: false,
            speakers: false,
          ),
        ),
        _layoutSpeakerBare,
      );
    });

    test('paragraphs cut each turn every N sentences', () {
      expect(
        txt(const ExportOptions(layout: ExportLayout.paragraphs, sentences: 1)),
        _layoutPara1,
      );
      expect(
        txt(const ExportOptions(layout: ExportLayout.paragraphs)),
        _layoutPara2,
      );
      expect(
        txt(
          const ExportOptions(
            layout: ExportLayout.paragraphs,
            sentences: 8,
            timecodes: false,
          ),
        ),
        _layoutPara8NoTime,
      );
    });

    test('single ignores both switches', () {
      expect(
        txt(const ExportOptions(layout: ExportLayout.single)),
        _layoutSingle,
      );
    });

    test('subtitles and CSV ignore the layout', () {
      for (final f in [ExportFormat.srt, ExportFormat.csv]) {
        expect(
          TranscriptExport.render(
            f,
            _transcript,
            const ExportOptions(layout: ExportLayout.single),
          ),
          TranscriptExport.render(f, _transcript, base),
        );
      }
    });
  });

  test('file names drop characters a file system refuses', () {
    expect(
      TranscriptExport.fileName('Kengash: 27/10', ExportFormat.srt),
      'Kengash_ 27_10.srt',
    );
    expect(TranscriptExport.fileName('', ExportFormat.txt), 'transkript.txt');
  });
}
