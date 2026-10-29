import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';

abstract interface class IPlayerFacade {
  /// A fresh link for [mediaId]. 404 — no such file for this person,
  /// 410 — the audio was removed by retention, 422 — not uploaded yet.
  Future<Either<Failure, PlayableMedia>> mediaSource(String mediaId);

  /// Opens a YouTube media's link outside the app: the YouTube app when it
  /// is installed, the browser otherwise. Left when nothing opened it.
  Future<Either<Failure, Unit>> openLink(String url);
}
