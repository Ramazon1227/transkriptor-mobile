import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

/// `handler.JobResponse` in the backend.
@freezed
abstract class JobModel with _$JobModel {
  const factory JobModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'media_id') @Default('') String mediaId,
    @JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown)
    @Default(JobStatus.unknown)
    JobStatus status,
    @JsonKey(name: 'progress') @Default(0) int progress,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'transcript_id') String? transcriptId,
  }) = _JobModel;

  const JobModel._();

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Job toEntity() => Job(
    id: id,
    mediaId: mediaId,
    status: status,
    progress: progress.clamp(0, 100),
    errorMessage: (errorMessage?.isEmpty ?? true) ? null : errorMessage,
    transcriptId: (transcriptId?.isEmpty ?? true) ? null : transcriptId,
  );
}
