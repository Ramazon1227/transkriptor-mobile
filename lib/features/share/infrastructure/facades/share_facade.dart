import 'package:dartz/dartz.dart' show Either, Left, Right, Unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/share/domain/entities/share_link.dart';
import 'package:transkriptor_uz/features/share/domain/i_share_facade.dart';
import 'package:transkriptor_uz/features/share/infrastructure/repositories/share_repository.dart';

@LazySingleton(as: IShareFacade)
class ShareFacade implements IShareFacade {
  ShareFacade(this._repository);

  final ShareRepository _repository;

  @override
  Future<Either<Failure, List<ShareLink>>> listLinks(
    String transcriptId,
  ) async {
    final result = await _repository.listLinks(transcriptId);
    return result.map((items) => items.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, ShareLink>> createLink({
    required String transcriptId,
    required bool includeMedia,
    required int expiresDays,
  }) async {
    final result = await _repository.createLink(
      transcriptId: transcriptId,
      includeMedia: includeMedia,
      expiresDays: expiresDays,
    );
    return result.flatMap((m) {
      final link = m.toEntity();
      // A server older than the `url` field: the link exists, but there
      // is nothing to hand out. Saying so beats copying a broken link.
      if (link.url == null) return const Left(Failure.parsing());
      return Right(link);
    });
  }

  @override
  Future<Either<Failure, Unit>> revokeLink(String linkId) =>
      _repository.revokeLink(linkId);
}
