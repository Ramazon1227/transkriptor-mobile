import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';

part 'delete_account_cubit.freezed.dart';

enum DeleteAccountStatus { initial, loading, success, failure }

@freezed
abstract class DeleteAccountState with _$DeleteAccountState {
  const factory DeleteAccountState({
    @Default(DeleteAccountStatus.initial) DeleteAccountStatus status,

    /// The confirmation field was left empty; nothing was sent.
    @Default(false) bool confirmationMissing,
    Failure? failure,
  }) = _DeleteAccountState;
}

/// Deletes the account. On success the facade ends the session, and the
/// router takes the person to login like after a logout.
@injectable
class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this._facade) : super(const DeleteAccountState());

  final IAuthFacade _facade;

  /// [confirmation] is the password when [hasPassword], else the
  /// account's own email. A second call while one runs is ignored.
  Future<void> submit({
    required String confirmation,
    required bool hasPassword,
  }) async {
    if (state.status == DeleteAccountStatus.loading) return;
    final value = hasPassword ? confirmation : confirmation.trim();
    if (value.isEmpty) {
      emit(const DeleteAccountState(confirmationMissing: true));
      return;
    }
    emit(const DeleteAccountState(status: DeleteAccountStatus.loading));
    final result = await _facade.deleteAccount(
      password: hasPassword ? value : null,
      email: hasPassword ? null : value,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        DeleteAccountState(
          status: DeleteAccountStatus.failure,
          failure: failure,
        ),
      ),
      // The server drops this phone's push token with the account
      // (`DeleteAccount` clears `device_token`), so push needs no call.
      (_) =>
          emit(const DeleteAccountState(status: DeleteAccountStatus.success)),
    );
  }
}
