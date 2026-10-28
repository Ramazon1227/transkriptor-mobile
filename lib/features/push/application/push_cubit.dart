import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/push/domain/i_push_facade.dart';
import 'package:transkriptor_uz/features/push/domain/push_message.dart';

part 'push_cubit.freezed.dart';

@freezed
abstract class PushState with _$PushState {
  const factory PushState({
    /// The last notification tapped; the app opens its page.
    PushMessage? opened,

    /// Bumped per tap, so the same message tapped twice opens twice.
    @Default(0) int tapCount,
  }) = _PushState;
}

/// App-wide push. [start] runs once an account is in hand; logout
/// unregisters through the account cubit, while the session still works.
@injectable
class PushCubit extends Cubit<PushState> {
  PushCubit(this._facade, this._changes) : super(const PushState());

  final IPushFacade _facade;
  final LibraryChanges _changes;
  StreamSubscription<PushMessage>? _opened;
  StreamSubscription<PushMessage>? _received;

  /// Registers this phone for the signed-in account. Safe to call again
  /// after another sign-in; a refused permission just means no push.
  Future<void> start() async {
    if (!_facade.isAvailable) return;
    _opened ??= _facade.opened.listen(
      (m) => emit(PushState(opened: m, tapCount: state.tapCount + 1)),
    );
    // A job finished while the app is open: the lists catch up.
    _received ??= _facade.received.listen((_) => _changes.notify());
    await _facade.register();
  }

  @override
  Future<void> close() async {
    await _opened?.cancel();
    await _received?.cancel();
    await super.close();
  }
}
