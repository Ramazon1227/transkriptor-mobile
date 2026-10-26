import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

abstract interface class ITranscriptFacade {
  Future<Either<Failure, Transcript>> getTranscript(String id);
}
