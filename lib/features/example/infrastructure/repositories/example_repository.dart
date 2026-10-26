import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/example/infrastructure/models/post_model.dart';

@lazySingleton
class ExampleRepository {
  ExampleRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, List<PostModel>>> getPosts({int? userId}) {
    return runRequest(() async {
      final response = await _dio.get<List<dynamic>>(
        Endpoints.posts,
        queryParameters: {'userId': ?userId},
      );
      return (response.data ?? const [])
          .cast<Map<String, dynamic>>()
          .map(PostModel.fromJson)
          .toList();
    });
  }
}
