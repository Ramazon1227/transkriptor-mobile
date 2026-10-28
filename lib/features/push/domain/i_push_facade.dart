import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/push/domain/push_message.dart';

abstract interface class IPushFacade {
  /// False when the build carries no Firebase settings; then every other
  /// member does nothing.
  bool get isAvailable;

  /// Asks for permission, then registers this phone's token for the
  /// signed-in account, and again whenever FCM rotates it. A refused
  /// permission is `Failure.permissionDenied()`.
  Future<Either<Failure, Unit>> register();

  /// Removes this phone's token on the server and on the phone. Called on
  /// logout while the session still works; best effort.
  Future<void> unregister();

  /// A notification the person tapped, including the one that launched
  /// the app.
  Stream<PushMessage> get opened;

  /// A notification that arrived while the app was open.
  Stream<PushMessage> get received;
}
