import 'package:injectable/injectable.dart';
import 'package:record/record.dart';

@module
abstract class RecorderModule {
  /// One native recorder for the app's lifetime; it is reused across
  /// recordings, so it is never disposed.
  @lazySingleton
  AudioRecorder get audioRecorder => AudioRecorder();
}
