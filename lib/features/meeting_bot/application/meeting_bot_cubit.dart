import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/entities/meeting_bot.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/i_meeting_bot_facade.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/meet_link.dart';

part 'meeting_bot_cubit.freezed.dart';

enum MeetingListStatus { initial, loading, success, empty, failure }

@freezed
abstract class MeetingBotState with _$MeetingBotState {
  const factory MeetingBotState({
    String? workspaceId,

    /// The recent-bots list under the form; its own status, so a failed
    /// list never hides the form or a bot being watched.
    @Default(MeetingListStatus.initial) MeetingListStatus listStatus,
    @Default(<MeetingBot>[]) List<MeetingBot> items,
    Failure? listFailure,

    /// The server has the bot routes but it is switched off there.
    @Default(true) bool available,
    @Default('') String defaultBotName,

    /// The server answered 404 for the route itself: it has no meeting
    /// bot yet (backend branch not deployed).
    @Default(false) bool routeMissing,

    /// The form's URL is not a Google Meet link; nothing was sent.
    @Default(false) bool urlInvalid,
    @Default(false) bool submitting,

    /// Of the last send or cancel.
    Failure? actionFailure,

    /// The bot whose status view is open; null shows the form.
    MeetingBot? active,
    @Default(false) bool cancelling,

    /// The last poll failed; the bot is still shown and polling goes on
    /// when the failure is transient.
    Failure? pollFailure,
  }) = _MeetingBotState;
}

/// Sends the Google Meet bot and follows it until it is done. Polling:
/// the backend has no push.
@injectable
class MeetingBotCubit extends Cubit<MeetingBotState> {
  MeetingBotCubit(this._facade, this._policy, this._changes)
    : super(const MeetingBotState());

  final IMeetingBotFacade _facade;
  final JobPollPolicy _policy;

  /// Told when a watched bot finishes: its file and job are now in the
  /// library and the balance moved.
  final LibraryChanges _changes;

  Timer? _timer;
  late Duration _interval = _policy.first;

  /// Bumped whenever the watched bot changes or watching stops; an answer
  /// for an older one is dropped.
  int _generation = 0;

  Future<void> load(String workspaceId) async {
    emit(
      state.copyWith(
        workspaceId: workspaceId,
        listStatus: MeetingListStatus.loading,
        listFailure: null,
      ),
    );
    final result = await _facade.list(workspaceId: workspaceId);
    if (isClosed || state.workspaceId != workspaceId) return;
    result.fold(
      (failure) => emit(
        _isRouteMissing(failure)
            ? state.copyWith(
                listStatus: MeetingListStatus.failure,
                routeMissing: true,
              )
            : state.copyWith(
                listStatus: MeetingListStatus.failure,
                listFailure: failure,
              ),
      ),
      (list) => emit(
        state.copyWith(
          listStatus: list.items.isEmpty
              ? MeetingListStatus.empty
              : MeetingListStatus.success,
          items: list.items,
          available: list.available,
          defaultBotName: list.defaultBotName,
          routeMissing: false,
        ),
      ),
    );
  }

  /// Clears the "not a Meet link" error while the person types.
  void urlEdited() {
    if (state.urlInvalid) emit(state.copyWith(urlInvalid: false));
  }

  Future<void> submit({
    required String url,
    required bool keepVideo,
    int? numSpeakers,
  }) async {
    final workspaceId = state.workspaceId;
    if (workspaceId == null || state.submitting) return;
    final meetUrl = canonicalMeetUrl(url);
    if (meetUrl == null) {
      emit(state.copyWith(urlInvalid: true, actionFailure: null));
      return;
    }
    emit(
      state.copyWith(submitting: true, urlInvalid: false, actionFailure: null),
    );
    final result = await _facade.create(
      workspaceId: workspaceId,
      meetUrl: meetUrl,
      keepVideo: keepVideo,
      numSpeakers: numSpeakers,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        _isRouteMissing(failure)
            ? state.copyWith(submitting: false, routeMissing: true)
            : state.copyWith(submitting: false, actionFailure: failure),
      ),
      (bot) {
        emit(
          state.copyWith(
            submitting: false,
            items: [bot, ...state.items.where((b) => b.id != bot.id)],
            listStatus: MeetingListStatus.success,
          ),
        );
        watch(bot);
      },
    );
  }

  /// Opens [bot]'s status view and polls it until it is terminal.
  void watch(MeetingBot bot) {
    _timer?.cancel();
    final generation = ++_generation;
    _interval = _policy.first;
    emit(
      state.copyWith(
        active: bot,
        cancelling: false,
        pollFailure: null,
        actionFailure: null,
      ),
    );
    if (!bot.status.isTerminal) _schedule(generation, bot.id);
  }

  /// Back to the form; the bot goes on without being watched.
  void dismiss() {
    _timer?.cancel();
    _generation++;
    emit(
      state.copyWith(
        active: null,
        cancelling: false,
        pollFailure: null,
        actionFailure: null,
      ),
    );
  }

  Future<void> cancel() async {
    final bot = state.active;
    if (bot == null || state.cancelling || !bot.status.isCancellable) return;
    emit(state.copyWith(cancelling: true, actionFailure: null));
    final generation = _generation;
    final result = await _facade.cancel(bot.id);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(cancelling: false, actionFailure: failure)),
      (updated) {
        emit(state.copyWith(cancelling: false));
        _apply(updated);
        if (!updated.status.isTerminal) {
          _timer?.cancel();
          _interval = _policy.first;
          _schedule(generation, updated.id);
        }
      },
    );
  }

  void _schedule(int generation, String id) {
    _timer = Timer(_interval, () => unawaited(_poll(generation, id)));
  }

  Future<void> _poll(int generation, String id) async {
    final result = await _facade.get(id);
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) {
        emit(state.copyWith(pollFailure: failure));
        // A meeting runs for an hour; one dropped connection must not
        // freeze the view. Anything else (404: deleted, 401) stops.
        if (_isTransient(failure)) {
          _interval = _policy.max;
          _schedule(generation, id);
        }
      },
      (bot) {
        final previous = state.active;
        final changed = previous == null || previous.status != bot.status;
        emit(state.copyWith(pollFailure: null));
        _apply(bot);
        if (bot.status.isTerminal) {
          if (bot.status == MeetingBotStatus.done) _changes.notify();
          return;
        }
        _interval = _policy.next(_interval, changed: changed);
        _schedule(generation, id);
      },
    );
  }

  /// Puts [bot] on screen and into the list.
  void _apply(MeetingBot bot) {
    emit(
      state.copyWith(
        active: state.active?.id == bot.id ? bot : state.active,
        items: state.items.map((b) => b.id == bot.id ? bot : b).toList(),
      ),
    );
  }

  static bool _isRouteMissing(Failure f) =>
      f is ServerFailure && f.statusCode == 404;

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
