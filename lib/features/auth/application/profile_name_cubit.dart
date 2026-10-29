import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';
import 'package:transkriptor_uz/features/auth/domain/name_rules.dart';

part 'profile_name_cubit.freezed.dart';

enum ProfileNameStatus { initial, saving, success, failure }

@freezed
abstract class ProfileNameState with _$ProfileNameState {
  const factory ProfileNameState({
    @Default(ProfileNameStatus.initial) ProfileNameStatus status,

    /// The name did not pass [NameRules]; nothing was sent.
    NameError? invalid,
    Failure? failure,

    /// The account as the server stored it, after a success.
    AppUser? user,
  }) = _ProfileNameState;
}

/// Profil › name. Validates like the backend, sends `PATCH /me`; the
/// sheet hands the stored user to `AccountCubit` on success.
@injectable
class ProfileNameCubit extends Cubit<ProfileNameState> {
  ProfileNameCubit(this._facade) : super(const ProfileNameState());

  final IAuthFacade _facade;

  /// A second call while one runs is ignored.
  Future<void> save(String raw) async {
    if (state.status == ProfileNameStatus.saving) return;
    final name = NameRules.clean(raw);
    final invalid = NameRules.validate(name);
    if (invalid != null) {
      emit(ProfileNameState(invalid: invalid));
      return;
    }
    emit(const ProfileNameState(status: ProfileNameStatus.saving));
    final result = await _facade.updateName(name);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        ProfileNameState(status: ProfileNameStatus.failure, failure: failure),
      ),
      (user) =>
          emit(ProfileNameState(status: ProfileNameStatus.success, user: user)),
    );
  }
}
