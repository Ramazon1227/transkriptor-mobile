import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/ai_chat/application/ai_chat_poll_policy.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/i_ai_chat_facade.dart';

part 'ai_chat_cubit.freezed.dart';

enum AiChatStatus { initial, loading, success, failure }

/// The backend's limit on one question (`models.AIQuestionMaxRunes`).
const int aiQuestionMaxLength = 2000;

@freezed
abstract class AiChatState with _$AiChatState {
  const factory AiChatState({
    @Default(AiChatStatus.initial) AiChatStatus status,
    @Default(<AiMessage>[]) List<AiMessage> items,

    /// The first load failed: nothing to show but a retry.
    Failure? failure,

    /// A question is on its way to the server.
    @Default(false) bool sending,
    @Default(false) bool clearing,

    /// A send or clear failed; the chat stays as it was.
    Failure? actionFailure,

    /// Asking about the pending answer failed; still retried when it is
    /// transient.
    Failure? pollFailure,
  }) = _AiChatState;

  const AiChatState._();

  /// An answer is being written: no new question until it arrives (the
  /// server would answer 409).
  bool get pending => items.any((m) => m.isPendingAnswer);

  bool get busy => sending || clearing || pending;
}

/// One transcript's private AI chat. The answer comes from a queue on
/// the server, so after a question the cubit polls the history until no
/// answer is `PENDING`.
@injectable
class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit(this._facade, this._policy) : super(const AiChatState());

  final IAiChatFacade _facade;
  final AiChatPollPolicy _policy;

  String? _transcriptId;
  Timer? _timer;
  late Duration _interval = _policy.first;

  /// Bumped by every load, send and clear: an answer that belongs to an
  /// older one is dropped, so a late poll never overwrites newer state.
  int _generation = 0;

  static const _localQuestionId = 'local-question';
  static const _localAnswerId = 'local-answer';

  /// [transcriptId] comes from the editor.
  Future<void> load(String transcriptId) {
    _transcriptId = transcriptId;
    _timer?.cancel();
    final generation = ++_generation;
    emit(const AiChatState(status: AiChatStatus.loading));
    return _fetch(generation, initial: true);
  }

  /// Retry after the first load failed.
  Future<void> reload() {
    final id = _transcriptId;
    return id == null ? Future.value() : load(id);
  }

  /// Shows the question at once with a pending answer under it. Returns
  /// false when it was not accepted, so the composer can keep the text.
  Future<bool> send(String text) async {
    final id = _transcriptId;
    final content = text.trim();
    if (id == null ||
        content.isEmpty ||
        content.length > aiQuestionMaxLength ||
        state.status != AiChatStatus.success ||
        state.busy) {
      return false;
    }
    _timer?.cancel();
    final generation = ++_generation;
    final before = state.items;
    emit(
      state.copyWith(
        sending: true,
        actionFailure: null,
        pollFailure: null,
        items: [
          ...before,
          AiMessage(
            id: _localQuestionId,
            role: AiRole.user,
            status: AiMessageStatus.done,
            content: content,
            local: true,
          ),
          const AiMessage(
            id: _localAnswerId,
            role: AiRole.assistant,
            status: AiMessageStatus.pending,
            local: true,
          ),
        ],
      ),
    );
    final result = await _facade.ask(id, content);
    if (isClosed || generation != _generation) return result.isRight();
    final accepted = result.fold(
      (failure) {
        emit(
          state.copyWith(sending: false, items: before, actionFailure: failure),
        );
        // 409: an answer is already being written somewhere (another
        // device); show it instead of leaving the chat stale.
        if (failure is ServerFailure && failure.statusCode == 409) {
          unawaited(_fetch(generation));
        }
        return false;
      },
      (exchange) {
        emit(
          state.copyWith(
            sending: false,
            items: [...before, exchange.question, exchange.answer],
          ),
        );
        _interval = _policy.first;
        _schedule(generation);
        return true;
      },
    );
    return accepted;
  }

  /// A `FAILED` answer: ask its question again.
  Future<bool> retry(String answerId) async {
    final i = state.items.indexWhere((m) => m.id == answerId);
    if (i <= 0) return false;
    final question = state.items[i - 1];
    if (question.role != AiRole.user) return false;
    return await send(question.content);
  }

  Future<void> clear() async {
    final id = _transcriptId;
    if (id == null || state.sending || state.clearing) return;
    _timer?.cancel();
    final generation = ++_generation;
    emit(state.copyWith(clearing: true, actionFailure: null));
    final result = await _facade.clear(id);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) {
        emit(state.copyWith(clearing: false, actionFailure: failure));
        if (state.pending) _schedule(generation);
      },
      (_) => emit(
        state.copyWith(clearing: false, items: const [], pollFailure: null),
      ),
    );
  }

  void dismissActionFailure() => emit(state.copyWith(actionFailure: null));

  void _schedule(int generation) {
    _timer?.cancel();
    _timer = Timer(_interval, () => _fetch(generation));
  }

  Future<void> _fetch(int generation, {bool initial = false}) async {
    final id = _transcriptId;
    if (id == null) return;
    final result = await _facade.history(id);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) {
        if (initial) {
          emit(state.copyWith(status: AiChatStatus.failure, failure: failure));
          return;
        }
        emit(state.copyWith(pollFailure: failure));
        if (_isTransient(failure) && state.pending) {
          _interval = _policy.max;
          _schedule(generation);
        }
      },
      (chat) {
        emit(
          state.copyWith(
            status: AiChatStatus.success,
            items: chat.items,
            failure: null,
            pollFailure: null,
          ),
        );
        if (state.pending || chat.pending) {
          _interval = initial ? _policy.first : _policy.next(_interval);
          _schedule(generation);
        }
      },
    );
  }

  static bool _isTransient(Failure f) => switch (f) {
    NetworkFailure() || TimeoutFailure() => true,
    ServerFailure(:final statusCode) => statusCode == null || statusCode >= 500,
    _ => false,
  };

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
