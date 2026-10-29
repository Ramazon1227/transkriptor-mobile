import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/dictation_event.dart';

/// Live dictation: text appears while the person speaks.
abstract interface class IDictationFacade {
  /// Starts listening. Cancelling the subscription stops it. [samples] are
  /// the localised demo sentences — used only while the source is the
  /// demo one; a streaming endpoint ignores them.
  Stream<DictationEvent> listen({required List<String> samples});

  /// Saves [text] as a note (`POST /notes`), one paragraph per line.
  Future<Either<Failure, Unit>> saveAsNote({
    required String workspaceId,
    required String title,
    required String text,
  });
}
