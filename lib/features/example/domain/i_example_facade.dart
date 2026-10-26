import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/example/domain/entities/post.dart';

abstract interface class IExampleFacade {
  /// All posts, or only [userId]'s. Order is the API's.
  Future<Either<Failure, List<Post>>> getPosts({int? userId});
}
