/// What a job makes (ClickUp S-1). [subtitle]: the server cuts the result
/// into subtitle frames (2 lines × 42 characters, 6 s), so one segment is
/// one frame in the editor and in SRT.
enum JobService {
  transcription('TRANSCRIPTION'),
  subtitle('SUBTITLE');

  JobService(this.apiValue);

  final String apiValue;
}
