/// Every API path lives here. No feature writes a path inline.
abstract final class Endpoints {
  // Auth — transkriptor backend.
  static const String authLogin = '/api/v1/auth/login';
  static const String authRegister = '/api/v1/auth/register';
  static const String authRefresh = '/api/v1/auth/refresh';
  static const String authLogout = '/api/v1/auth/logout';
  static const String authPasswordForgot = '/api/v1/auth/password/forgot';
  static const String me = '/api/v1/me';

  // Files.
  static const String library = '/api/v1/library';
  static const String media = '/api/v1/media';
  static String mediaById(String id) => '/api/v1/media/$id';
  static String workspaceFolders(String workspaceId) =>
      '/api/v1/workspaces/$workspaceId/folders';
  static String workspaceFolder(String workspaceId, String folderId) =>
      '/api/v1/workspaces/$workspaceId/folders/$folderId';
  static String mediaConfirm(String id) => '/api/v1/media/$id/confirm';
  static const String mediaYoutube = '/api/v1/media/youtube';
  static const String mediaCloud = '/api/v1/media/cloud';

  // Transcription.
  static const String job = '/api/v1/job';
  static String jobById(String id) => '/api/v1/job/$id';
  static String jobCancel(String id) => '/api/v1/job/$id/cancel';
  static String transcript(String id) => '/api/v1/transcript/$id';
  static String transcriptSegment(String id, String segmentId) =>
      '/api/v1/transcript/$id/segments/$segmentId';
  static String transcriptSegmentSplit(String id, String segmentId) =>
      '/api/v1/transcript/$id/segments/$segmentId/split';
  static String transcriptSegmentMergeNext(String id, String segmentId) =>
      '/api/v1/transcript/$id/segments/$segmentId/merge-next';
  static String transcriptSpeaker(String id, String speakerId) =>
      '/api/v1/transcript/$id/speakers/$speakerId';

  // Share links.
  static String transcriptShares(String id) => '/api/v1/transcript/$id/share';
  static String share(String id) => '/api/v1/share/$id';
}
