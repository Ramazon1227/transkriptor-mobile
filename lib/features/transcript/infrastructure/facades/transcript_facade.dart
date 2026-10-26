import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_transcript_facade.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/repositories/transcript_repository.dart';

@LazySingleton(as: ITranscriptFacade)
class TranscriptFacade implements ITranscriptFacade {
  TranscriptFacade(this._repository);

  final TranscriptRepository _repository;

  @override
  Future<Either<Failure, Transcript>> getTranscript(String id) async {
    final result = await _repository.getTranscript(id);
    return result.map((m) => m.toEntity());
  }
}
