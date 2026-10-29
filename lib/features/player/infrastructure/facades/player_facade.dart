import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/links/domain/i_links_facade.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';
import 'package:transkriptor_uz/features/player/domain/i_player_facade.dart';
import 'package:transkriptor_uz/features/player/infrastructure/repositories/player_repository.dart';

@LazySingleton(as: IPlayerFacade)
class PlayerFacade implements IPlayerFacade {
  PlayerFacade(this._repository, this._links);

  final PlayerRepository _repository;
  final ILinksFacade _links;

  @override
  Future<Either<Failure, PlayableMedia>> mediaSource(String mediaId) async {
    final result = await _repository.mediaUrl(mediaId);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> openLink(String url) => _links.open(url);
}
