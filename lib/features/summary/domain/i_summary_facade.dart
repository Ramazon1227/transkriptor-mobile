import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// The editor's «Xulosa». On a server with the summary API
/// (`/transcript/:id/summary`) everything is real; on one without it the
/// facade falls back to the demo sample, says so through
/// `SummaryLoad.sample` / [Summary.sample], and the UI does not change.
abstract interface class ISummaryFacade {
  Future<Either<Failure, SummaryTemplateLibrary>> templates();

  /// Stars or unstars a template for the caller; the answer is the
  /// stored state.
  Future<Either<Failure, bool>> setFavorite(
    String templateId, {
    required bool favorite,
  });

  /// The stored summary, if any. Only reads: nothing is generated here.
  Future<Either<Failure, SummaryLoad>> load(String transcriptId);

  /// Starts a (new) summary with [template] (null: the default). From the
  /// server it comes back PENDING — poll with [refresh]; the demo answers
  /// DONE straight away.
  Future<Either<Failure, Summary>> generate(
    Transcript transcript, {
    SummaryTemplate? template,
  });

  /// The summary as it is now (null: gone). For polling a PENDING one.
  Future<Either<Failure, Summary?>> refresh(String transcriptId);

  /// Deletes the summary; the transcript stays.
  Future<Either<Failure, Unit>> delete(String transcriptId);

  /// Saves the summary as a note copied from the transcript: [body] (the
  /// server's Tiptap document) as it is, else [sections] (titles
  /// resolved). Returns the note's id.
  Future<Either<Failure, String>> saveAsNote({
    required String transcriptId,
    required String title,
    required List<SummarySection> sections,
    Map<String, dynamic>? body,
  });
}
