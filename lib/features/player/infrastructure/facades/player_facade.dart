import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';
import 'package:transkriptor_uz/features/player/domain/i_player_facade.dart';
import 'package:transkriptor_uz/features/player/infrastructure/repositories/player_repository.dart';

@LazySingleton(as: IPlayerFacade)
class PlayerFacade implements IPlayerFacade {
  PlayerFacade(this._repository, this._share);

  final PlayerRepository _repository;
  final SharePlus _share;

  @override
  Future<Either<Failure, PlayableMedia>> mediaSource(String mediaId) async {
    final result = await _repository.mediaUrl(mediaId);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> shareLink(String url) async {
    try {
      await _share.share(ShareParams(text: url));
      return const Right(unit);
    } on Object {
      return const Left(Failure.unknown());
    }
  }
}
