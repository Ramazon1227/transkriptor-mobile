import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/example/domain/entities/post.dart';
import 'package:transkriptor_uz/features/example/domain/i_example_facade.dart';
import 'package:transkriptor_uz/features/example/infrastructure/repositories/example_repository.dart';

@LazySingleton(as: IExampleFacade)
class ExampleFacade implements IExampleFacade {
  ExampleFacade(this._repository);

  final ExampleRepository _repository;

  @override
  Future<Either<Failure, List<Post>>> getPosts({int? userId}) async {
    final result = await _repository.getPosts(userId: userId);
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }
}
