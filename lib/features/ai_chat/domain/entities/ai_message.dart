import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_message.freezed.dart';

enum AiRole { user, assistant, unknown }

/// `PENDING` until the backend's queue writes the answer; a question is
/// always `DONE`.
enum AiMessageStatus { pending, done, failed, unknown }

/// One line of a private chat about one transcript.
@freezed
abstract class AiMessage with _$AiMessage {
  const factory AiMessage({
    required String id,
    required AiRole role,
    required AiMessageStatus status,
    @Default('') String content,

    /// A fixed sentence from the server when the answer did not come.
    String? error,
    DateTime? createdAt,

    /// Shown before the server confirmed it (optimistic bubble).
    @Default(false) bool local,
  }) = _AiMessage;

  const AiMessage._();

  bool get isPendingAnswer =>
      role == AiRole.assistant && status == AiMessageStatus.pending;
}

/// `GET /transcript/:id/chat`: the history, oldest first, and whether an
/// answer is still being written.
@freezed
abstract class AiChat with _$AiChat {
  const factory AiChat({
    @Default(<AiMessage>[]) List<AiMessage> items,
    @Default(false) bool pending,
  }) = _AiChat;
}

/// `POST /transcript/:id/chat` (202): the stored question and the
/// `PENDING` answer row.
@freezed
abstract class AiExchange with _$AiExchange {
  const factory AiExchange({
    required AiMessage question,
    required AiMessage answer,
  }) = _AiExchange;
}
