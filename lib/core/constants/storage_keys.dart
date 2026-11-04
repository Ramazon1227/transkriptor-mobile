/// Keys for persisted values. Mock-only keys start with `mock_`.
abstract final class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  /// The workspace the person last switched to. Falls back to the
  /// personal one when the id is no longer theirs.
  static const String selectedWorkspace = 'selected_workspace';

  /// The playback speed the person last chose, on this phone.
  static const String playbackSpeed = 'playback_speed';

  /// The player's volume (0..1) and whether it is muted, on this phone.
  static const String playbackVolume = 'playback_volume';
  static const String playbackMuted = 'playback_muted';

  /// The first-open speaker sheet: switched off on this phone, and the
  /// prefix of «already closed for this transcript» (followed by its id).
  static const String speakerIntroOff = 'speaker_intro_off';
  static const String speakerIntroSeen = 'speaker_intro_seen_';
}
