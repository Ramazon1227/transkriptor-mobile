import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/comments/domain/entities/comment.dart';

abstract interface class ICommentsFacade {
  /// In the server's order.
  Future<Either<Failure, List<Comment>>> list(String transcriptId);

  Future<Either<Failure, Comment>> create({
    required String transcriptId,
    required String segmentId,
    required String body,
  });

  /// Only the author may change the text; anyone else gets 403.
  Future<Either<Failure, Comment>> update({
    required String transcriptId,
    required String commentId,
    required String body,
  });

  Future<Either<Failure, Unit>> delete({
    required String transcriptId,
    required String commentId,
  });
}
