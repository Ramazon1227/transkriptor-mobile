import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

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

  /// The answer arrived but did not have the expected shape.
  const factory Failure.parsing() = ParsingFailure;

  /// The request was cancelled on purpose.
  const factory Failure.cancelled() = CancelledFailure;

  /// The person refused a device permission (microphone).
  const factory Failure.permissionDenied() = PermissionDeniedFailure;

  /// Reading or writing a local file failed.
  const factory Failure.storage() = StorageFailure;

  const factory Failure.unknown() = UnknownFailure;
}
