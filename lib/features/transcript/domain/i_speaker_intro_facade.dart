/// What this phone remembers about the first-open speaker sheet. Nothing
/// here fails: an unreadable store only means the sheet is offered again.
abstract interface class ISpeakerIntroFacade {
  /// The sheet was closed for this transcript, or switched off everywhere.
  Future<bool> isDue(String transcriptId);

  Future<void> markSeen(String transcriptId);

  Future<bool> isOff();

  Future<void> setOff({required bool off});
}
