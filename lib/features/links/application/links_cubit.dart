import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/links/domain/i_links_facade.dart';

part 'links_cubit.freezed.dart';

@freezed
abstract class LinksState with _$LinksState {
  const factory LinksState({
    /// iOS: pages that ask for a permission show «Sozlamalarni ochish».
    @Default(false) bool canOpenAppSettings,
  }) = _LinksState;
}

/// App-wide: opens links outside the app. The answers are one-shot, so
/// they are returned rather than kept in the state — false means nothing
/// opened, and the caller offers the link to copy instead.
@injectable
class LinksCubit extends Cubit<LinksState> {
  LinksCubit(this._facade)
    : super(LinksState(canOpenAppSettings: _facade.canOpenAppSettings));

  final ILinksFacade _facade;

  Future<bool> open(String url) async => (await _facade.open(url)).isRight();

  Future<bool> openAppSettings() async =>
      (await _facade.openAppSettings()).isRight();
}
