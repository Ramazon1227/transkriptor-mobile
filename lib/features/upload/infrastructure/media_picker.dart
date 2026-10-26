import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

/// The system file picker, behind a class so the facade can be tested
/// without a platform channel.
@lazySingleton
class MediaPicker {
  /// Null when the person closed the picker, or the file has no local path.
  Future<PendingFile?> pick() async {
    final picked = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: supportedExtensions,
    );
    final path = picked?.path;
    if (picked == null || path == null) return null;
    final size = await picked.length();
    if (size == null || size <= 0) return null;
    return PendingFile(
      path: path,
      fileName: picked.name,
      sizeBytes: size,
      source: UploadSource.upload,
    );
  }
}
