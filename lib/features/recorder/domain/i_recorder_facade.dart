import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';

abstract interface class IRecorderFacade {
  /// Asks for the microphone when needed, then starts writing a new file.
  /// A refusal is `Failure.permissionDenied()`.
  Future<Either<Failure, Unit>> start();

  Future<Either<Failure, Unit>> pause();

  Future<Either<Failure, Unit>> resume();

  /// Closes the file. [duration] is measured by the caller, which knows
  /// about pauses.
  Future<Either<Failure, Recording>> stop({required Duration duration});

  /// Stops without keeping anything.
  Future<void> discard();

  /// Input level, 0 (silence) to 1 (loud), for the level meter.
  Stream<double> levels();
}
