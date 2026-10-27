import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';

abstract interface class IExportFacade {
  /// Hands one text file to the system share sheet, where the person
  /// saves it to Files or sends it to another app. Closing the sheet
  /// without choosing is not a failure.
  Future<Either<Failure, Unit>> shareFile({
    required String fileName,
    required String mimeType,
    required String body,
  });
}
