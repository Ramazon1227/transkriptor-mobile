import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/core/network/session_manager.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';

part 'account_cubit.freezed.dart';

enum AccountStatus { initial, loading, success, failure }

@freezed
abstract class AccountState with _$AccountState {
  const factory AccountState({
    @Default(AccountStatus.initial) AccountStatus status,
    Account? account,
    Failure? failure,
  }) = _AccountState;
}

/// Who is signed in, app-wide. Screens read the workspace id from here and
/// pass it into their own blocs.
@injectable
class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._facade, LibraryChanges changes, this._session)
    : super(const AccountState()) {
    // Sending, cancelling and finishing all move the balance.
    _changes = changes.stream.listen((_) {
      if (state.account != null) unawaited(load());
    });
    // An expired session (refresh failed, logout) must not leave the last
    // person's account behind for whoever signs in next.
    _session.addListener(_onSession);
  }

  final IAuthFacade _facade;
  final SessionManager _session;
  late final StreamSubscription<void> _changes;

  /// Bumped on every load and on sign-out; a `GET /me` answer from an
  /// older generation is dropped, so a late response never overwrites a
  /// newer one or brings back a signed-out account.
  int _generation = 0;

  void _onSession() {
    if (!_session.isExpired || isClosed) return;
    _generation++;
    emit(const AccountState());
  }

  /// Reloads `GET /me`. Keeps the last account while loading, so the
  /// balance does not blink away on a refresh.
  Future<void> load() async {
    final generation = ++_generation;
    emit(state.copyWith(status: AccountStatus.loading, failure: null));
    final result = await _facade.loadAccount();
    if (isClosed || generation != _generation) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: AccountStatus.failure, failure: failure)),
      (account) =>
          emit(state.copyWith(status: AccountStatus.success, account: account)),
    );
  }

  /// Login already fetched the account; no second request.
  void signedIn(Account account) {
    _generation++;
    emit(AccountState(status: AccountStatus.success, account: account));
  }

  Future<void> logout() async {
    _generation++;
    await _facade.logout();
    if (isClosed) return;
    emit(const AccountState());
  }

  @override
  Future<void> close() async {
    _session.removeListener(_onSession);
    await _changes.cancel();
    await super.close();
  }
}
