import 'package:freezed_annotation/freezed_annotation.dart';

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

/// One transcript's summary, written with one template.
@freezed
abstract class Summary with _$Summary {
  const factory Summary({
    /// Null: the default template.
    String? templateId,
    String? templateName,
    @Default(<SummarySection>[]) List<SummarySection> sections,
    DateTime? createdAt,
  }) = _Summary;
}

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
