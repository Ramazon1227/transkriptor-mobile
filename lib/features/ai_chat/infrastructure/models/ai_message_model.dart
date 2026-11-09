import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';

part 'ai_message_model.freezed.dart';
part 'ai_message_model.g.dart';

enum AiRoleModel {
  @JsonValue('USER')
  user,
  @JsonValue('ASSISTANT')
  assistant,
  unknown,
}

enum AiStatusModel {
  @JsonValue('PENDING')
  pending,
  @JsonValue('DONE')
  done,
  @JsonValue('FAILED')
  failed,
  unknown,
}

/// `models.AIMessage` in the backend.
@freezed
abstract class AiMessageModel with _$AiMessageModel {
  const factory AiMessageModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'role', unknownEnumValue: AiRoleModel.unknown)
    @Default(AiRoleModel.unknown)
    AiRoleModel role,
    @JsonKey(name: 'status', unknownEnumValue: AiStatusModel.unknown)
    @Default(AiStatusModel.unknown)
    AiStatusModel status,
    @JsonKey(name: 'content') @Default('') String content,
    @JsonKey(name: 'error') String? error,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'outdated') @Default(false) bool outdated,
    @JsonKey(name: 'follow_ups', fromJson: _readFollowUps)
    @Default(<String>[])
    List<String> followUps,
  }) = _AiMessageModel;

  const AiMessageModel._();

  factory AiMessageModel.fromJson(Map<String, dynamic> json) =>
      _$AiMessageModelFromJson(json);

  AiMessage toEntity() => AiMessage(
    id: id,
    role: switch (role) {
      AiRoleModel.user => AiRole.user,
      AiRoleModel.assistant => AiRole.assistant,
      AiRoleModel.unknown => AiRole.unknown,
    },
    status: switch (status) {
      AiStatusModel.pending => AiMessageStatus.pending,
      AiStatusModel.done => AiMessageStatus.done,
      AiStatusModel.failed => AiMessageStatus.failed,
      AiStatusModel.unknown => AiMessageStatus.unknown,
    },
    content: content,
    error: (error?.isEmpty ?? true) ? null : error,
    createdAt: createdAt,
    outdated: outdated,
    followUps: followUps,
  );
}

/// Tolerant: anything but non-empty strings is dropped, at most three.
List<String> _readFollowUps(Object? json) => json is List
    ? [
        for (final q in json)
          if (q is String && q.trim().isNotEmpty) q.trim(),
      ].take(3).toList()
    : const <String>[];
