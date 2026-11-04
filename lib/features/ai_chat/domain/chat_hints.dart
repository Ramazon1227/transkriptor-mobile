import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// The ready questions of an empty AI chat, picked from what the recording
/// itself tells (meeting, attendees, speakers, length) — no AI call, since
/// AI work runs only on request.
///
/// The web has the same rule and texts (tr-frontend/src/lib/chat-hints.ts);
/// both run test/fixtures/chat_hints_cases.json, a copy of the web's
/// chat-hints.fixtures.json — copy it again when the rule changes, do not
/// edit it by hand. The enum names are the shared keys.
enum ChatHint {
  whatSaid,
  whoSaid,
  decisions,
  openIssues,
  proposals,
  disagreements,
  mainPoints,
  examples,
  terms,
  whoTalked,
  agreements,
  chapters,
}

class HintFacts {
  const HintFacts({
    required this.meeting,
    required this.attendees,
    required this.speakers,
    required this.duration,
  });

  /// [Transcript.duration] unknown: the last segment's end stands in.
  factory HintFacts.of(Transcript t) {
    final speakers = <String>{};
    var lastEnd = Duration.zero;
    for (final s in t.segments) {
      final id = s.speakerId;
      if (id != null && s.text.trim().isNotEmpty) speakers.add(id);
      if (s.end > lastEnd) lastEnd = s.end;
    }
    return HintFacts(
      meeting: t.meeting != null,
      attendees: t.meeting?.attendeeCount ?? 0,
      speakers: speakers.length,
      duration: t.duration ?? lastEnd,
    );
  }

  final bool meeting;
  final int attendees;

  /// Distinct speakers of segments with text; 0 without diarization.
  final int speakers;
  final Duration duration;
}

class ChatHints {
  const ChatHints({required this.questions, required this.tabs});

  static const none = ChatHints(questions: [], tabs: false);

  final List<ChatHint> questions;

  /// Whether the buttons that open the summary (web: and tasks) tab show.
  final bool tabs;
}

const _short = Duration(seconds: 30);
const _long = Duration(minutes: 20);

ChatHints chatHints(HintFacts f) {
  if (f.duration < _short) {
    return ChatHints(
      questions: f.speakers >= 2
          ? const [ChatHint.whatSaid, ChatHint.whoSaid]
          : const [ChatHint.whatSaid],
      tabs: false,
    );
  }
  final q = f.meeting
      ? [
          ChatHint.decisions,
          ChatHint.openIssues,
          if (f.attendees > 0) ChatHint.proposals else ChatHint.disagreements,
        ]
      : f.speakers <= 1
      ? [ChatHint.mainPoints, ChatHint.examples, ChatHint.terms]
      : [ChatHint.whoTalked, ChatHint.disagreements, ChatHint.agreements];
  if (f.duration > _long) q[2] = ChatHint.chapters;
  return ChatHints(questions: q, tabs: true);
}
