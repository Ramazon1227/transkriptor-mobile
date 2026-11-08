import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/core/error/held_file.dart';

part 'failure.freezed.dart';

/// Why a screen-audio capture could not run (`Failure.capture`).
enum CaptureError {
  /// Playback capture needs Android 10 (API 29); iOS has none.
  unsupported,

  /// The person did not allow screen capture in the system dialog.
  consentDenied,

  /// The system refused to start the capture or it broke midway.
  captureFailed,

  /// A capture is already running.
  busy,
}

/// Every error that leaves the data layer. Facades return
/// `Either<Failure, T>`; exceptions never reach a bloc.
@freezed
sealed class Failure with _$Failure {
  /// No connection, DNS failure, bad certificate.
  const factory Failure.network() = NetworkFailure;

  /// Connect, send or receive timed out.
  const factory Failure.timeout() = TimeoutFailure;

  /// 401 that a token refresh could not fix.
  const factory Failure.unauthorized() = UnauthorizedFailure;

  /// Any other non-2xx answer. [message] is the backend's `description`
  /// when the body carries one.
  const factory Failure.server({int? statusCode, String? message}) =
      ServerFailure;

  /// 409 PENDING_LIMIT: too many files not yet transcribed. [held] names
  /// them, so the person can free a place.
  const factory Failure.pendingLimit({
    @Default(<HeldFile>[]) List<HeldFile> held,
  }) = PendingLimitFailure;

  /// 409 JOB_ACTIVE: the file already has a queued or running job. A file
  /// has one job at a time, so its minutes are never reserved twice.
  const factory Failure.jobActive() = JobActiveFailure;

  /// IDEMPOTENCY_MISMATCH: the action's key was already used with other
  /// parameters. The key is dropped, so the next tap is a new action.
  const factory Failure.idempotencyMismatch() = IdempotencyMismatchFailure;

  /// 409 SOLE_OWNER on account deletion (W-3): the person is the only owner
  /// of these workspaces, which still have other members. Only a server
  /// that sends the code and the names produces it; an older server's 409
  /// stays a [ServerFailure].
  const factory Failure.soleOwner(List<String> workspaces) = SoleOwnerFailure;

  /// 413 NOTE_TOO_LARGE (N-11): the note is over the server's size limit.
  /// Older servers never send the code; their 413 stays a [ServerFailure].
  const factory Failure.noteTooLarge() = NoteTooLargeFailure;

  /// The answer arrived but did not have the expected shape.
  const factory Failure.parsing() = ParsingFailure;

  /// The request was cancelled on purpose.
  const factory Failure.cancelled() = CancelledFailure;

  /// The person refused a device permission (microphone).
  const factory Failure.permissionDenied() = PermissionDeniedFailure;

  /// Reading or writing a local file failed.
  const factory Failure.storage() = StorageFailure;

  /// Screen-audio capture did not start or broke; see [CaptureError].
  const factory Failure.capture(CaptureError reason) = CaptureFailure;

  const factory Failure.unknown() = UnknownFailure;
}
