import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/comments/domain/entities/comment.dart';
import 'package:transkriptor_uz/features/comments/domain/i_comments_facade.dart';

part 'comments_cubit.freezed.dart';

enum CommentsStatus { initial, loading, success, empty, failure }

/// Add, edit or delete; one at a time.
enum CommentActionStatus { idle, busy, done, failure }

@freezed
abstract class CommentsState with _$CommentsState {
  const factory CommentsState({
    @Default(CommentsStatus.initial) CommentsStatus status,
    @Default(<Comment>[]) List<Comment> comments,
    Failure? failure,
    @Default(CommentActionStatus.idle) CommentActionStatus actionStatus,
    Failure? actionFailure,
  }) = _CommentsState;

  const CommentsState._();

  /// Comments by segment, each group in the server's order; groups in
  /// the order of [segmentOrder] (the transcript's), unknown ones last.
  List<(String, List<Comment>)> grouped(List<String> segmentOrder) {
    final bySegment = <String, List<Comment>>{};
    for (final c in comments) {
      (bySegment[c.segmentId] ??= []).add(c);
    }
    final rank = {
      for (var i = 0; i < segmentOrder.length; i++) segmentOrder[i]: i,
    };
    final keys = bySegment.keys.toList()
      ..sort(
        (a, b) => (rank[a] ?? segmentOrder.length).compareTo(
          rank[b] ?? segmentOrder.length,
        ),
      );
    return [for (final k in keys) (k, bySegment[k]!)];
  }
}

/// The comments of one transcript. Not optimistic: a row appears,
/// changes or goes once the server has answered.
@injectable
class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit(this._facade) : super(const CommentsState());

  final ICommentsFacade _facade;
  String? _transcriptId;

  /// [transcriptId] comes from the transcript page.
  Future<void> load(String transcriptId) async {
    _transcriptId = transcriptId;
    emit(state.copyWith(status: CommentsStatus.loading, failure: null));
    final result = await _facade.list(transcriptId);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(status: CommentsStatus.failure, failure: failure),
      ),
      (items) =>
          emit(state.copyWith(status: _statusOf(items), comments: items)),
    );
  }

  Future<void> add(String segmentId, String body) async {
    final id = _transcriptId;
    final clean = CommentRules.clean(body);
    if (id == null || clean.isEmpty || CommentRules.tooLong(clean)) return;
    if (!_begin()) return;
    final result = await _facade.create(
      transcriptId: id,
      segmentId: segmentId,
      body: clean,
    );
    if (isClosed) return;
    result.fold(_fail, (c) => _done([...state.comments, c]));
  }

  Future<void> edit(String commentId, String body) async {
    final id = _transcriptId;
    final clean = CommentRules.clean(body);
    if (id == null || clean.isEmpty || CommentRules.tooLong(clean)) return;
    final current = state.comments.where((c) => c.id == commentId);
    if (current.isEmpty) return;
    if (current.first.body == clean) {
      emit(state.copyWith(actionStatus: CommentActionStatus.done));
      return;
    }
    if (!_begin()) return;
    final result = await _facade.update(
      transcriptId: id,
      commentId: commentId,
      body: clean,
    );
    if (isClosed) return;
    result.fold(
      _fail,
      (c) => _done([
        for (final x in state.comments)
          if (x.id == c.id) c else x,
      ]),
    );
  }

  Future<void> delete(String commentId) async {
    final id = _transcriptId;
    if (id == null || !_begin()) return;
    final result = await _facade.delete(transcriptId: id, commentId: commentId);
    if (isClosed) return;
    result.fold(
      _fail,
      (_) => _done(state.comments.where((c) => c.id != commentId).toList()),
    );
  }

  /// A composer opened: the previous action's result must not mark it.
  void resetAction() {
    if (state.actionStatus == CommentActionStatus.busy) return;
    emit(
      state.copyWith(
        actionStatus: CommentActionStatus.idle,
        actionFailure: null,
      ),
    );
  }

  bool _begin() {
    if (state.actionStatus == CommentActionStatus.busy) return false;
    emit(
      state.copyWith(
        actionStatus: CommentActionStatus.busy,
        actionFailure: null,
      ),
    );
    return true;
  }

  void _fail(Failure failure) => emit(
    state.copyWith(
      actionStatus: CommentActionStatus.failure,
      actionFailure: failure,
    ),
  );

  void _done(List<Comment> comments) => emit(
    state.copyWith(
      actionStatus: CommentActionStatus.done,
      comments: comments,
      status: _statusOf(comments),
    ),
  );

  static CommentsStatus _statusOf(List<Comment> items) =>
      items.isEmpty ? CommentsStatus.empty : CommentsStatus.success;
}
