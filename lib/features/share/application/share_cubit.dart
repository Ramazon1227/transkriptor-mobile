import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/share/domain/entities/share_link.dart';
import 'package:transkriptor_uz/features/share/domain/i_share_facade.dart';

part 'share_cubit.freezed.dart';

enum ShareListStatus { initial, loading, success, empty, failure }

/// Create or revoke; one at a time.
enum ShareActionStatus { idle, busy, failure }

/// Expiry choices, the web dialog's: 7 days, 30 days, a year, none (0).
const List<int> shareExpiryDays = [7, 30, 365, 0];

@freezed
abstract class ShareState with _$ShareState {
  const factory ShareState({
    @Default(ShareListStatus.initial) ShareListStatus listStatus,
    @Default(<ShareLink>[]) List<ShareLink> links,
    Failure? listFailure,
    @Default(ShareActionStatus.idle) ShareActionStatus actionStatus,
    Failure? actionFailure,

    /// The link just created, with its URL. Shown once: closing the sheet
    /// loses it, and the server cannot show it again.
    ShareLink? created,
    @Default(true) bool includeMedia,
    @Default(30) int expiresDays,
  }) = _ShareState;
}

/// The share sheet of one transcript. Independent loads: a failed create
/// keeps the list, a failed list keeps the form.
@injectable
class ShareCubit extends Cubit<ShareState> {
  ShareCubit(this._facade) : super(const ShareState());

  final IShareFacade _facade;
  String? _transcriptId;

  /// Bumped on every list request; an older answer is dropped.
  int _listGeneration = 0;

  /// [transcriptId] comes from the transcript page.
  Future<void> load(String transcriptId) {
    _transcriptId = transcriptId;
    emit(
      state.copyWith(listStatus: ShareListStatus.loading, listFailure: null),
    );
    return _reloadList();
  }

  void setIncludeMedia({required bool value}) =>
      emit(state.copyWith(includeMedia: value));

  void setExpiresDays(int days) {
    if (!shareExpiryDays.contains(days)) return;
    emit(state.copyWith(expiresDays: days));
  }

  Future<void> create() async {
    final id = _transcriptId;
    if (id == null || state.actionStatus == ShareActionStatus.busy) return;
    emit(
      state.copyWith(actionStatus: ShareActionStatus.busy, actionFailure: null),
    );
    final result = await _facade.createLink(
      transcriptId: id,
      includeMedia: state.includeMedia,
      expiresDays: state.expiresDays,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          actionStatus: ShareActionStatus.failure,
          actionFailure: failure,
        ),
      ),
      (link) => emit(
        state.copyWith(actionStatus: ShareActionStatus.idle, created: link),
      ),
    );
    // Also after a failure: an unreadable answer may still have made one.
    await _reloadList();
  }

  Future<void> revoke(String linkId) async {
    if (state.actionStatus == ShareActionStatus.busy) return;
    emit(
      state.copyWith(actionStatus: ShareActionStatus.busy, actionFailure: null),
    );
    final result = await _facade.revokeLink(linkId);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          actionStatus: ShareActionStatus.failure,
          actionFailure: failure,
        ),
      ),
      (_) {
        final links = state.links.where((l) => l.id != linkId).toList();
        emit(
          state.copyWith(
            actionStatus: ShareActionStatus.idle,
            links: links,
            listStatus: links.isEmpty
                ? ShareListStatus.empty
                : ShareListStatus.success,
            created: state.created?.id == linkId ? null : state.created,
          ),
        );
      },
    );
  }

  Future<void> _reloadList() async {
    final id = _transcriptId;
    if (id == null) return;
    final generation = ++_listGeneration;
    final result = await _facade.listLinks(id);
    if (isClosed || generation != _listGeneration) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          listStatus: ShareListStatus.failure,
          listFailure: failure,
        ),
      ),
      (links) => emit(
        state.copyWith(
          listStatus: links.isEmpty
              ? ShareListStatus.empty
              : ShareListStatus.success,
          links: links,
          listFailure: null,
        ),
      ),
    );
  }
}
