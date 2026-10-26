import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:dio/dio.dart';
import 'package:transkriptor_uz/core/error/dio_error_mapper.dart';
import 'package:transkriptor_uz/core/error/failure.dart';

/// Runs one repository call and converts every error into a [Failure],
/// so repositories return `Either` instead of throwing.
Future<Either<Failure, T>> runRequest<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } on DioException catch (e) {
    return Left(mapDioException(e));
  } on FormatException {
    return const Left(Failure.parsing());
    // fromJson on a mis-shaped body throws a TypeError, and parsing must
    // never crash the app (CLAUDE.md §3).
    // ignore: avoid_catching_errors
  } on TypeError {
    return const Left(Failure.parsing());
  }
}
