import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/transcript/domain/i_speaker_intro_facade.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/storage/speaker_intro_storage.dart';

@LazySingleton(as: ISpeakerIntroFacade)
class SpeakerIntroFacade implements ISpeakerIntroFacade {
  SpeakerIntroFacade(this._storage);

  final SpeakerIntroStorage _storage;

  @override
  Future<bool> isDue(String transcriptId) async {
    try {
      return !await _storage.isOff() && !await _storage.isSeen(transcriptId);
    } on Object {
      // An unreadable keychain only means the sheet is offered once more.
      return true;
    }
  }

  @override
  Future<void> markSeen(String transcriptId) async {
    try {
      await _storage.markSeen(transcriptId);
    } on Object {
      // The sheet is closed all the same.
    }
  }

  @override
  Future<bool> isOff() async {
    try {
      return await _storage.isOff();
    } on Object {
      return false;
    }
  }

  @override
  Future<void> setOff({required bool off}) async {
    try {
      await _storage.setOff(off: off);
    } on Object {
      // The switch still shows the choice for this visit.
    }
  }
}
