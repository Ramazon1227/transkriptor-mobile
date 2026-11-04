import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/links/domain/i_links_facade.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';
import 'package:transkriptor_uz/features/player/domain/i_player_facade.dart';
import 'package:transkriptor_uz/features/player/infrastructure/repositories/player_repository.dart';
import 'package:transkriptor_uz/features/player/infrastructure/storage/player_speed_storage.dart';

@LazySingleton(as: IPlayerFacade)
class PlayerFacade implements IPlayerFacade {
  PlayerFacade(this._repository, this._links, this._speed);

  final PlayerRepository _repository;
  final ILinksFacade _links;
  final PlayerSpeedStorage _speed;

  @override
  Future<Either<Failure, PlayableMedia>> mediaSource(String mediaId) async {
    final result = await _repository.mediaUrl(mediaId);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> openLink(String url) => _links.open(url);

  @override
  Future<double?> savedSpeed() async {
    try {
      final raw = await _speed.read();
      return raw == null ? null : double.tryParse(raw);
    } on Object {
      // An unreadable keychain only means the default speed.
      return null;
    }
  }

  @override
  Future<void> saveSpeed(double speed) async {
    try {
      await _speed.write(speed.toString());
    } on Object {
      // The speed still applies to the open file.
    }
  }

  @override
  Future<({double volume, bool muted})?> savedVolume() async {
    try {
      final volume = double.tryParse(await _speed.readVolume() ?? '');
      if (volume == null || volume < 0 || volume > 1) return null;
      return (volume: volume, muted: await _speed.readMuted() == '1');
    } on Object {
      // An unreadable keychain only means full volume.
      return null;
    }
  }

  @override
  Future<void> saveVolume(double volume, {required bool muted}) async {
    try {
      await _speed.writeVolume(volume.toString(), muted: muted);
    } on Object {
      // The volume still applies to the open file.
    }
  }
}
