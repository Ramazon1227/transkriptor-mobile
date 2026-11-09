import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

/// What the recorder did without being asked.
enum RecorderInterruption {
  /// A call or another app took the microphone: the recorder paused, what
  /// was recorded is kept, and [IRecorderFacade.resume] appends to the
  /// same file.
  paused,

  /// The capture itself ended (the phone stopped the microphone).
  stopped,
}

abstract interface class IRecorderFacade {
  /// Asks for the microphone when needed, then starts writing a new file.
  /// A refusal is `Failure.permissionDenied()`. Recording goes on with the
  /// screen off and the app in the background (Android foreground
  /// service with an ongoing notification).
  Future<Either<Failure, Unit>> start();

  Future<Either<Failure, Unit>> pause();

  Future<Either<Failure, Unit>> resume();

  /// Closes the file. [duration] is measured by the caller, which knows
  /// about pauses.
  Future<Either<Failure, Recording>> stop({required Duration duration});

  /// Stops without keeping anything.
  Future<void> discard();

  /// Pauses and stops the user did not ask for (MB-10). On Android the
  /// ongoing notification says it too.
  Stream<RecorderInterruption> interruptions();

  /// Input level, 0 (silence) to 1 (loud), for the level meter.
  Stream<double> levels();

  /// Microphone and screen recordings left from earlier sessions (killed,
  /// crashed, or finished but never sent), newest first. Empty is not an
  /// error.
  Future<Either<Failure, List<RecoverableRecording>>> recoverable();

  /// Deletes a leftover recording.
  Future<Either<Failure, Unit>> discardRecoverable(RecoverableRecording item);

  /// Makes a leftover recording ready for the normal send flow; an
  /// interrupted one is first turned into an .m4a. [title] becomes the
  /// file name (the extension is added). The upload deletes the file once
  /// the server has it.
  Future<Either<Failure, PendingFile>> recover(
    RecoverableRecording item, {
    required String title,
  });
}
