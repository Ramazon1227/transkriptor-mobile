import 'dart:typed_data';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:flutter/services.dart' show AssetBundle;
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/export/domain/i_export_facade.dart';
import 'package:transkriptor_uz/features/export/domain/pdf_export.dart';
import 'package:transkriptor_uz/features/export/domain/transcript_export.dart';

@LazySingleton(as: IExportFacade)
class ExportFacade implements IExportFacade {
  ExportFacade(this._share, this._assets);

  // Noto Sans: Cyrillic and U+02BB / U+02BC, which the PDF's own fonts
  // lack. OFL, licence beside the files.
  static const regularFont = 'assets/fonts/NotoSans-Regular.ttf';
  static const boldFont = 'assets/fonts/NotoSans-Bold.ttf';

  final SharePlus _share;
  final AssetBundle _assets;

  @override
  Future<Either<Failure, Uint8List>> pdf(
    String title,
    List<ExportBlock> blocks,
  ) async {
    try {
      final regular = await _assets.load(regularFont);
      final bold = await _assets.load(boldFont);
      return Right(
        await PdfExport.build(title, blocks, regular: regular, bold: bold),
      );
    } on Object {
      return const Left(Failure.unknown());
    }
  }

  @override
  Future<Either<Failure, Unit>> shareFile({
    required String fileName,
    required String mimeType,
    required Uint8List bytes,
  }) async {
    try {
      // In memory: share_plus writes it to its own temp folder, and the
      // override is what gives that file its name.
      await _share.share(
        ShareParams(
          files: [XFile.fromData(bytes, mimeType: mimeType)],
          fileNameOverrides: [fileName],
        ),
      );
      return const Right(unit);
    } on Object {
      return const Left(Failure.storage());
    }
  }
}
