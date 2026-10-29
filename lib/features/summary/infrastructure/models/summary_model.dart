import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';

part 'summary_model.freezed.dart';
part 'summary_model.g.dart';

enum SummaryStatusModel {
  @JsonValue('PENDING')
  pending,
  @JsonValue('DONE')
  done,
  @JsonValue('FAILED')
  failed,
  unknown,
}

/// `models.TranscriptSummary` in the backend (`feat/meeting-ai`,
/// `models/summary.go`). `body` is Tiptap JSON in the Notes schema; it
/// may be null while the first version is PENDING.
@freezed
abstract class SummaryModel with _$SummaryModel {
  const factory SummaryModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'transcript_id') @Default('') String transcriptId,
    @JsonKey(name: 'template_id') String? templateId,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'status', unknownEnumValue: SummaryStatusModel.unknown)
    @Default(SummaryStatusModel.unknown)
    SummaryStatusModel status,
    @JsonKey(name: 'body') Object? body,
    @JsonKey(name: 'error') @Default('') String error,
    @JsonKey(name: 'revision') @Default(0) int revision,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _SummaryModel;

  const SummaryModel._();

  factory SummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryModelFromJson(json);

  Summary toEntity() {
    final doc = body is Map<String, dynamic>
        ? body! as Map<String, dynamic>
        : null;
    return Summary(
      id: id,
      templateId: templateId,
      templateName: title.isEmpty ? null : title,
      progress: switch (status) {
        SummaryStatusModel.pending => SummaryProgress.pending,
        SummaryStatusModel.done => SummaryProgress.done,
        SummaryStatusModel.failed => SummaryProgress.failed,
        SummaryStatusModel.unknown => SummaryProgress.unknown,
      },
      error: error.isEmpty ? null : error,
      revision: revision,
      body: doc,
      blocks: NoteDocument.parse(doc),
      createdAt: updatedAt,
    );
  }
}
