import 'dart:typed_data';

import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/export/domain/transcript_export.dart';

abstract interface class IExportFacade {
  /// The PDF of [blocks] under [title]. It needs the bundled fonts, which
  /// is why it lives here and not beside the other formats.
  Future<Either<Failure, Uint8List>> pdf(
    String title,
    List<ExportBlock> blocks,
  );

  /// Hands one file to the system share sheet, where the person saves it
  /// to Files or sends it to another app. Closing the sheet without
  /// choosing is not a failure.
  Future<Either<Failure, Unit>> shareFile({
    required String fileName,
    required String mimeType,
    required Uint8List bytes,
  });
}
