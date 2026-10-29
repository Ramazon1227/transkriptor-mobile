/// Every API path lives here. No feature writes a path inline.
abstract final class Endpoints {
  // Auth — transkriptor backend.
  static const String authLogin = '/api/v1/auth/login';
  static const String authRegister = '/api/v1/auth/register';
  static const String authRefresh = '/api/v1/auth/refresh';
  static const String authLogout = '/api/v1/auth/logout';
  static const String authPasswordForgot = '/api/v1/auth/password/forgot';
  static const String authOAuthProviders = '/api/v1/auth/oauth/providers';
  static const String authOAuthGoogle = '/api/v1/auth/oauth/google';
  static const String me = '/api/v1/me';
  static const String meDevices = '/api/v1/me/devices';

  // Workspaces and billing.
  static const String workspaces = '/api/v1/workspaces';
  static String workspaceBalance(String workspaceId) =>
      '/api/v1/workspaces/$workspaceId/balance';
  static const String plans = '/api/v1/plans';

  // Google Calendar (read-only; connected on the web).
  static const String calendar = '/api/v1/calendar';
  static const String calendarEvents = '/api/v1/calendar/events';

  // Files.
  static const String library = '/api/v1/library';
  static const String media = '/api/v1/media';
  static String mediaById(String id) => '/api/v1/media/$id';
  static String workspaceFolders(String workspaceId) =>
      '/api/v1/workspaces/$workspaceId/folders';
  static String workspaceFolder(String workspaceId, String folderId) =>
      '/api/v1/workspaces/$workspaceId/folders/$folderId';
  static String mediaConfirm(String id) => '/api/v1/media/$id/confirm';

  /// A fresh read link for the player; YouTube media answer with the
  /// video id instead.
  static String mediaUrl(String id) => '/api/v1/media/$id/url';
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
  static String transcriptComments(String id) =>
      '/api/v1/transcript/$id/comments';
  static String transcriptComment(String id, String commentId) =>
      '/api/v1/transcript/$id/comments/$commentId';
  static String transcriptRating(String id) => '/api/v1/transcript/$id/rating';

  // Notes (author-only).
  static const String notes = '/api/v1/notes';
  static String note(String id) => '/api/v1/notes/$id';

  // Share links.
  static String transcriptShares(String id) => '/api/v1/transcript/$id/share';
  static String share(String id) => '/api/v1/share/$id';

  // Capture sources (M-R6). Meeting bot: backend `feat/meet-bot`, answers
  // 404 until that branch is deployed. Notes: dictation saves into them.
  // A direct file URL has no endpoint yet (planned `POST /media/url`).
  static const String meetingBots = '/api/v1/meeting-bots';
  static String meetingBot(String id) => '/api/v1/meeting-bots/$id';
  // Editor AI tabs (M-R5): the per-transcript chat, the summary template
  // library (the summary's «save as note» uses [notes]).
  static String transcriptChat(String id) => '/api/v1/transcript/$id/chat';
  // Sentiment (kayfiyat tahlili): started by a button, polled while PENDING.
  static String transcriptSentiment(String id) =>
      '/api/v1/transcript/$id/sentiment';
  static const String summaryTemplates = '/api/v1/summary-templates';
  static String summaryTemplateFavorite(String id) =>
      '/api/v1/summary-templates/$id/favorite';
  // The summary itself: backend `feat/meeting-ai`; a server without it
  // answers with its NoRoute 404 (`core/network/route_missing.dart`).
  static String transcriptSummary(String id) =>
      '/api/v1/transcript/$id/summary';
}
