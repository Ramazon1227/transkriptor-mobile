import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/dictation_event.dart';
import 'package:transkriptor_uz/features/capture/domain/i_dictation_facade.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/demo/demo_dictation_repository.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/repositories/note_repository.dart';

@LazySingleton(as: IDictationFacade)
class DictationFacade implements IDictationFacade {
  DictationFacade(this._source, this._notes);

  final DemoDictationRepository _source;
  final NoteRepository _notes;

  @override
  Stream<DictationEvent> listen({required List<String> samples}) =>
      _source.listen(samples);

  @override
  Future<Either<Failure, Unit>> saveAsNote({
    required String workspaceId,
    required String title,
    required String text,
  }) => _notes.create(
    workspaceId: workspaceId,
    title: title.trim(),
    paragraphs: [
      for (final line in text.split('\n'))
        if (line.trim().isNotEmpty) line.trim(),
    ],
  );
}
