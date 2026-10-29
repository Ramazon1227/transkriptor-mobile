import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/summary/domain/i_summary_facade.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/demo/demo_summary_repository.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/note_doc.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/repositories/note_repository.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/repositories/summary_repository.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/repositories/summary_template_repository.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Holds the real summary repository and the demo one. Which one answers
/// is decided by the server: a NoRoute 404 on `/transcript/:id/summary`
/// means the API is not deployed there, and from then on generation is
/// the demo. Every [load] asks again, so a server that gets the API is
/// noticed the next time a tab opens.
@LazySingleton(as: ISummaryFacade)
class SummaryFacade implements ISummaryFacade {
  SummaryFacade(this._templates, this._notes, this._summaries, this._demo);

  final SummaryTemplateRepository _templates;
  final NoteRepository _notes;
  final SummaryRepository _summaries;
  final DemoSummaryRepository _demo;

  /// The last answer said the route is missing.
  bool _routeMissing = false;

  @override
  Future<Either<Failure, SummaryTemplateLibrary>> templates() async {
    final result = await _templates.list();
    return result.map((r) {
      final categories = r.$1.map((m) => m.toEntity()).toList()
        ..sort((a, b) => a.position.compareTo(b.position));
      return SummaryTemplateLibrary(
        categories: categories,
        templates: r.$2
            .map((m) => m.toEntity())
            .where((t) => t.id.isNotEmpty)
            .toList(),
      );
    });
  }

  @override
  Future<Either<Failure, bool>> setFavorite(
    String templateId, {
    required bool favorite,
  }) => _templates.setFavorite(templateId, favorite: favorite);

  @override
  Future<Either<Failure, SummaryLoad>> load(String transcriptId) async {
    final result = await _summaries.get(transcriptId);
    return result.map((a) {
      _routeMissing = a.routeMissing;
      return (summary: a.summary?.toEntity(), sample: a.routeMissing);
    });
  }

  @override
  Future<Either<Failure, Summary>> generate(
    Transcript transcript, {
    SummaryTemplate? template,
  }) async {
    if (_routeMissing) return Right(await _sample(transcript, template));
    final result = await _summaries.generate(
      transcript.id,
      templateId: template?.id,
    );
    return await result.fold((failure) async => Left(failure), (a) async {
      if (a.routeMissing) {
        _routeMissing = true;
        return Right(await _sample(transcript, template));
      }
      final summary = a.summary;
      return summary == null
          ? const Left(Failure.parsing())
          : Right(summary.toEntity());
    });
  }

  @override
  Future<Either<Failure, Summary?>> refresh(String transcriptId) async {
    final result = await _summaries.get(transcriptId);
    return result.map((a) => a.summary?.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> delete(String transcriptId) async {
    // The sample lives in the tab's memory only.
    if (_routeMissing) return const Right(unit);
    return await _summaries.delete(transcriptId);
  }

  @override
  Future<Either<Failure, String>> saveAsNote({
    required String transcriptId,
    required String title,
    required List<SummarySection> sections,
    Map<String, dynamic>? body,
  }) => _notes.create(
    title: clampNoteTitle(title),
    body: body ?? summaryNoteDoc(sections),
    sourceTranscriptId: transcriptId,
  );

  Future<Summary> _sample(
    Transcript transcript,
    SummaryTemplate? template,
  ) async => (await _demo.generate(
    transcript,
    template: template,
  )).copyWith(sample: true);
}
