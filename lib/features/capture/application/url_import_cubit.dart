import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/url_import_result.dart';
import 'package:transkriptor_uz/features/capture/domain/i_url_import_facade.dart';
import 'package:transkriptor_uz/features/capture/domain/url_check.dart';

part 'url_import_cubit.freezed.dart';

enum UrlImportStatus {
  initial,
  loading,

  /// The server started a job: [UrlImportState.jobId].
  success,

  /// The server cannot import a direct URL yet.
  notAvailable,
  failure,
}

@freezed
abstract class UrlImportState with _$UrlImportState {
  const factory UrlImportState({
    @Default(UrlImportStatus.initial) UrlImportStatus status,
    @Default(false) bool urlInvalid,

    /// A YouTube/Drive/Dropbox link: the page hands it to the link flow
    /// and calls [UrlImportCubit.consumed].
    String? platformUrl,
    String? jobId,
    Failure? failure,
  }) = _UrlImportState;
}

@injectable
class UrlImportCubit extends Cubit<UrlImportState> {
  UrlImportCubit(this._facade) : super(const UrlImportState());

  final IUrlImportFacade _facade;

  Future<void> submit({
    required String url,
    required String workspaceId,
  }) async {
    if (state.status == UrlImportStatus.loading) return;
    switch (classifyUrl(url)) {
      case UrlKind.invalid:
        emit(const UrlImportState(urlInvalid: true));
      case UrlKind.platform:
        emit(UrlImportState(platformUrl: url.trim()));
      case UrlKind.direct:
        emit(const UrlImportState(status: UrlImportStatus.loading));
        final result = await _facade.importUrl(
          url: url,
          workspaceId: workspaceId,
        );
        if (isClosed) return;
        result.fold(
          (f) =>
              emit(UrlImportState(status: UrlImportStatus.failure, failure: f)),
          (r) => emit(switch (r) {
            UrlImportStarted(:final jobId) => UrlImportState(
              status: UrlImportStatus.success,
              jobId: jobId,
            ),
            UrlImportNotAvailable() => const UrlImportState(
              status: UrlImportStatus.notAvailable,
            ),
          }),
        );
    }
  }

  /// The page took [UrlImportState.platformUrl] or the job.
  void consumed() => emit(const UrlImportState());

  /// The person edits the URL: old errors go.
  void edited() {
    if (state != const UrlImportState()) emit(const UrlImportState());
  }
}
