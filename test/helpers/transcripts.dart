import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Sentences that read like a meeting: long enough for the demo summary
/// and learn sources, mixed Uzbek with one Russian line.
const List<String> meetingLines = [
  'Bugungi yigʻilishda byudjet loyihasini muhokama qilamiz. Boshladik.',
  'Oʻtgan oyda xizmatlar soni yigirma foizga oshdi, shikoyatlar kamaydi.',
  'Raqamlashtirish platformasi sinovda, lekin serverlar quvvati kam.',
  'Мы подготовили предложения по закупке оборудования до конца года.',
  'Keyingi haftagacha moliya boʻlimi smetasini tayyorlashi kerak.',
  'Xodimlarni oʻqitish dasturi dekabrda boshlanadi va uch oy davom etadi.',
  'Hududiy filiallar hisobotlarini juma kuni markazga topshirish lozim.',
  'Yigʻilish yakunida barcha qarorlar bayonnomaga kiritiladi, tamom.',
];

Transcript meetingTranscript({String id = 't1', int segments = 8}) {
  final speakers = [
    const Speaker(id: 's1', label: 'Maʼruzachi 1', ordinal: 1),
    const Speaker(id: 's2', label: 'Maʼruzachi 2', ordinal: 2),
  ];
  return Transcript(
    id: id,
    title: 'Yigʻilish 28-oktabr',
    speakers: speakers,
    segments: [
      for (var i = 0; i < segments; i++)
        Segment(
          id: 'seg$i',
          start: Duration(seconds: i * 30),
          end: Duration(seconds: i * 30 + 25),
          speakerId: speakers[i % 2].id,
          text: meetingLines[i % meetingLines.length],
        ),
    ],
  );
}

/// Two segments: below every AI tab's minimum.
Transcript shortTranscript() => meetingTranscript(id: 'short', segments: 2);
