import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';

abstract interface class IPlayerFacade {
  /// A fresh link for [mediaId]. 404 — no such file for this person,
  /// 410 — the audio was removed by retention, 422 — not uploaded yet.
  Future<Either<Failure, PlayableMedia>> mediaSource(String mediaId);

  /// Hands a link to the system share sheet (YouTube media: the person
  /// opens it in the YouTube app from there).
  Future<Either<Failure, Unit>> shareLink(String url);
}
