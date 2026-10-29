import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';

part 'summary.freezed.dart';

/// What a section is about. The UI names the known kinds; [custom] uses
/// [SummarySection.title] as given (a real summary API will send titles).
enum SummarySectionKind { overview, keyPoints, speakers, nextSteps, custom }

@freezed
abstract class SummarySection with _$SummarySection {
  const factory SummarySection({
    required SummarySectionKind kind,

    /// Null for a known [kind]: the UI supplies the heading.
    String? title,
    String? paragraph,
    @Default(<String>[]) List<String> bullets,
  }) = _SummarySection;
}

/// Where a summary is: the server writes it in the background.
enum SummaryProgress { pending, done, failed, unknown }

/// One transcript's summary, written with one template. A summary from
/// the server carries a Tiptap [body] (shown as [blocks]); the demo
/// sample carries [sections] instead and is marked [sample].
@freezed
abstract class Summary with _$Summary {
  const factory Summary({
    /// Null for the demo sample.
    String? id,

    /// Null: the default template.
    String? templateId,
    String? templateName,
    @Default(SummaryProgress.done) SummaryProgress progress,

    /// The server's ready-made sentence for a failed summary.
    String? error,

    /// Optimistic lock for edits (`transcript_summary.revision`).
    @Default(0) int revision,

    /// Tiptap JSON as stored; null for the sample.
    Map<String, dynamic>? body,

    /// [body] as read-only blocks.
    @Default(<NoteBlock>[]) List<NoteBlock> blocks,
    @Default(<SummarySection>[]) List<SummarySection> sections,

    /// Built on the phone from the transcript's own sentences: no model
    /// wrote it.
    @Default(false) bool sample,
    DateTime? createdAt,
  }) = _Summary;
}

/// What the tab finds on open: the stored summary (null: none yet) and
/// whether this server has the summary API at all (`sample`: it has not,
/// so generation is the demo).
typedef SummaryLoad = ({Summary? summary, bool sample});

/// The summary as plain text, for the clipboard. [sections] must already
/// carry their titles (the UI resolves the known kinds).
String summaryPlainText(String heading, List<SummarySection> sections) {
  final out = StringBuffer(heading);
  for (final s in sections) {
    out
      ..writeln()
      ..writeln();
    if (s.title != null) out.writeln(s.title);
    if (s.paragraph != null) out.writeln(s.paragraph);
    for (final b in s.bullets) {
      out.writeln('• $b');
    }
  }
  return out.toString().trimRight();
}

/// A server summary as plain text, for the clipboard: [heading], a blank
/// line, then the note's own plain-text form.
String summaryBlocksPlainText(String heading, List<NoteBlock> blocks) {
  final body = NoteDocument.plainText(blocks);
  return body.isEmpty ? heading : '$heading\n\n$body';
}
