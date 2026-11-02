import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

/// The system file picker, behind a class so the facade can be tested
/// without a platform channel.
@lazySingleton
class MediaPicker {
  /// Empty when the person closed the picker. A file without a local path
  /// or without bytes is left out.
  Future<List<PendingFile>> pick() async {
    final picked = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: supportedExtensions,
    );
    final files = <PendingFile>[];
    for (final file in picked) {
      final path = file.path;
      final size = await file.length();
      if (path == null || size == null || size <= 0) continue;
      files.add(
        PendingFile(
          path: path,
          fileName: file.name,
          sizeBytes: size,
          source: UploadSource.upload,
        ),
      );
    }
    return files;
  }
}
