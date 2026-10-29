import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_bot.freezed.dart';

/// `meeting_bot.status` in the backend (`feat/meet-bot`).
enum MeetingBotStatus {
  @JsonValue('SCHEDULED')
  scheduled,
  @JsonValue('JOINING')
  joining,
  @JsonValue('WAITING')
  waiting,
  @JsonValue('RECORDING')
  recording,
  @JsonValue('UPLOADING')
  uploading,
  @JsonValue('DONE')
  done,
  @JsonValue('FAILED')
  failed,
  @JsonValue('DENIED')
  denied,
  @JsonValue('CANCELLED')
  cancelled,
  unknown;

  /// No further change will come; polling stops here.
  bool get isTerminal =>
      this == done || this == failed || this == denied || this == cancelled;

  /// The bot can still be called back (`DELETE`).
  bool get isCancellable =>
      this == scheduled ||
      this == joining ||
      this == waiting ||
      this == recording;
}

/// A bot sent into one Google Meet meeting.
@freezed
abstract class MeetingBot with _$MeetingBot {
  const factory MeetingBot({
    required String id,
    required MeetingBotStatus status,
    @Default('') String meetUrl,

    /// The name the meeting sees; ends with « (yozib olmoqda)».
    @Default('') String botName,

    /// A ready sentence for the person (the server's), or null.
    String? errorMessage,
    String? errorCode,
    @Default(false) bool cancelRequested,
    @Default(false) bool keepVideo,
    String? mediaId,

    /// Set once the recording is handed to transcription.
    String? jobId,
    String? meetingTitle,
    DateTime? createdAt,
  }) = _MeetingBot;
}

/// `GET /meeting-bots`: the recent bots, and whether the server can send
/// a new one at all.
@freezed
abstract class MeetingBotList with _$MeetingBotList {
  const factory MeetingBotList({
    @Default(true) bool available,
    @Default('') String defaultBotName,
    @Default(<MeetingBot>[]) List<MeetingBot> items,
  }) = _MeetingBotList;
}
