import 'dart:convert';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/export/domain/i_export_facade.dart';

@LazySingleton(as: IExportFacade)
class ExportFacade implements IExportFacade {
  ExportFacade(this._share);

  final SharePlus _share;

  @override
  Future<Either<Failure, Unit>> shareFile({
    required String fileName,
    required String mimeType,
    required String body,
  }) async {
    try {
      // In memory: share_plus writes it to its own temp folder, and the
      // override is what gives that file its name.
      await _share.share(
        ShareParams(
          files: [XFile.fromData(utf8.encode(body), mimeType: mimeType)],
          fileNameOverrides: [fileName],
        ),
      );
      return const Right(unit);
    } on Object {
      return const Left(Failure.storage());
    }
  }
}
