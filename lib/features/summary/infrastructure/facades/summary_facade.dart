import 'package:dartz/dartz.dart' show Either, Right;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/summary/domain/i_summary_facade.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/demo/demo_summary_repository.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/note_doc.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/repositories/note_repository.dart';
import 'package:transkriptor_uz/features/summary/infrastructure/repositories/summary_template_repository.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

@LazySingleton(as: ISummaryFacade)
class SummaryFacade implements ISummaryFacade {
  SummaryFacade(this._templates, this._notes, this._demo);

  final SummaryTemplateRepository _templates;
  final NoteRepository _notes;

  /// Generation only; see the comment at the top of its file.
  final DemoSummaryRepository _demo;

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
  Future<Either<Failure, Summary>> generate(
    Transcript transcript, {
    SummaryTemplate? template,
  }) async => Right(await _demo.generate(transcript, template: template));

  @override
  Future<Either<Failure, String>> saveAsNote({
    required String transcriptId,
    required String title,
    required List<SummarySection> sections,
  }) => _notes.create(
    title: clampNoteTitle(title),
    body: summaryNoteDoc(sections),
    sourceTranscriptId: transcriptId,
  );
}
