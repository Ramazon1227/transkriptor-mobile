import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// The editor's «Xulosa». The template library and notes are real API;
/// generation is a demo until the summary endpoint exists.
abstract interface class ISummaryFacade {
  Future<Either<Failure, SummaryTemplateLibrary>> templates();

  /// Stars or unstars a template for the caller; the answer is the
  /// stored state.
  Future<Either<Failure, bool>> setFavorite(
    String templateId, {
    required bool favorite,
  });

  /// [template] null: the default template.
  Future<Either<Failure, Summary>> generate(
    Transcript transcript, {
    SummaryTemplate? template,
  });

  /// Saves [sections] (titles resolved) as a note copied from the
  /// transcript. Returns the note's id.
  Future<Either<Failure, String>> saveAsNote({
    required String transcriptId,
    required String title,
    required List<SummarySection> sections,
  });
}
