import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/speaker_intro.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/models/transcript_model.dart';

Segment _seg(String id, int startS, int endS, String? speaker) => Segment(
  id: id,
  start: Duration(seconds: startS),
  end: Duration(seconds: endS),
  text: id,
  speakerId: speaker,
);

Transcript _two({
  String first = "Ma'ruzachi 1",
  String second = 'Maʼruzachi 2',
  WorkspaceRole role = WorkspaceRole.owner,
}) => Transcript(
  id: 't1',
  title: 'x',
  role: role,
  speakers: [
    Speaker(id: 'a', label: first),
    Speaker(id: 'b', label: second),
  ],
  segments: [_seg('1', 0, 2, 'a'), _seg('2', 2, 3, 'b')],
);

void main() {
  test('the role comes from the server; anything else is least privileged', () {
    WorkspaceRole read(Map<String, dynamic> json) =>
        TranscriptModel.fromJson(json).toEntity().role;
    expect(read({'role': 'MEMBER'}), WorkspaceRole.member);
    expect(read({'role': 'VIEWER'}), WorkspaceRole.viewer);
    expect(read({'role': 'NEW_ROLE'}), WorkspaceRole.unknown);
    expect(read({}), WorkspaceRole.unknown);
  });

  test('default names: both spellings the server has used', () {
    expect(SpeakerIntro.isDefaultLabel("Ma'ruzachi 1"), isTrue);
    expect(SpeakerIntro.isDefaultLabel('Maʼruzachi 12'), isTrue);
    expect(SpeakerIntro.isDefaultLabel('Aziz'), isFalse);
  });

  test('rows: first appearance, no silent speaker, the longest line', () {
    final rows = SpeakerIntro.rows(
      Transcript(
        id: 't',
        title: 'x',
        speakers: const [
          Speaker(id: 'a', label: 'A'),
          Speaker(id: 'b', label: 'B'),
          Speaker(id: 'silent', label: 'C'),
        ],
        segments: [
          _seg('1', 0, 1, 'b'),
          _seg('2', 1, 3, 'a'),
          _seg('3', 3, 7, 'b'),
          _seg('4', 7, 8, null),
        ],
      ),
    );
    expect(rows.map((r) => r.speaker.id), ['b', 'a']);
    expect(rows.first.start, const Duration(seconds: 3));
    expect(rows.first.end, const Duration(seconds: 7));
  });

  test('a sample is capped at eight seconds', () {
    final rows = SpeakerIntro.rows(
      Transcript(
        id: 't',
        title: 'x',
        speakers: const [Speaker(id: 'a', label: 'A')],
        segments: [_seg('1', 5, 65, 'a')],
      ),
    );
    expect(rows.single.end, const Duration(seconds: 13));
  });

  test('applies with two speakers and one default name', () {
    expect(SpeakerIntro.applies(_two()), isTrue);
    expect(SpeakerIntro.applies(_two(first: 'Aziz')), isTrue);
    expect(
      SpeakerIntro.applies(_two(first: 'Aziz', second: 'Dilnoza')),
      isFalse,
    );
  });

  test('not for one speaker, a viewer or an unknown role', () {
    expect(
      SpeakerIntro.applies(
        _two().copyWith(segments: [_seg('1', 0, 2, 'a')]),
      ),
      isFalse,
    );
    expect(SpeakerIntro.applies(_two(role: WorkspaceRole.viewer)), isFalse);
    expect(SpeakerIntro.applies(_two(role: WorkspaceRole.unknown)), isFalse);
  });
}
