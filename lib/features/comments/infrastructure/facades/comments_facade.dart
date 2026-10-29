import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/comments/domain/entities/comment.dart';
import 'package:transkriptor_uz/features/comments/domain/i_comments_facade.dart';
import 'package:transkriptor_uz/features/comments/infrastructure/repositories/comments_repository.dart';

@LazySingleton(as: ICommentsFacade)
class CommentsFacade implements ICommentsFacade {
  CommentsFacade(this._repository);

  final CommentsRepository _repository;

  @override
  Future<Either<Failure, List<Comment>>> list(String transcriptId) async {
    final result = await _repository.list(transcriptId);
    return result.map((items) => items.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, Comment>> create({
    required String transcriptId,
    required String segmentId,
    required String body,
  }) async {
    final result = await _repository.create(
      transcriptId: transcriptId,
      segmentId: segmentId,
      body: body,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Comment>> update({
    required String transcriptId,
    required String commentId,
    required String body,
  }) async {
    final result = await _repository.update(
      transcriptId: transcriptId,
      commentId: commentId,
      body: body,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> delete({
    required String transcriptId,
    required String commentId,
  }) => _repository.delete(transcriptId: transcriptId, commentId: commentId);
}
