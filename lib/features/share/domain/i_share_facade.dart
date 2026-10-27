import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/share/domain/entities/share_link.dart';

abstract interface class IShareFacade {
  /// The transcript's live links, without tokens. A VIEWER gets
  /// `Failure.server(statusCode: 403)`.
  Future<Either<Failure, List<ShareLink>>> listLinks(String transcriptId);

  /// [expiresDays] 0 is a link without expiry. The result carries
  /// [ShareLink.url].
  Future<Either<Failure, ShareLink>> createLink({
    required String transcriptId,
    required bool includeMedia,
    required int expiresDays,
  });

  /// Irreversible: a revoked token never works again.
  Future<Either<Failure, Unit>> revokeLink(String linkId);
}
