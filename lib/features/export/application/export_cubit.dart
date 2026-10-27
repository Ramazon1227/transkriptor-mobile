import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/export/domain/export_options.dart';
import 'package:transkriptor_uz/features/export/domain/i_export_facade.dart';
import 'package:transkriptor_uz/features/export/domain/transcript_export.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

part 'export_cubit.freezed.dart';

enum ExportStatus { idle, sharing, failure }

@freezed
abstract class ExportState with _$ExportState {
  const factory ExportState({
    @Default(ExportFormat.txt) ExportFormat format,
    @Default(ExportOptions()) ExportOptions options,
    @Default(ExportStatus.idle) ExportStatus status,
    Failure? failure,
  }) = _ExportState;
}

/// The export sheet. The file is built on the phone from the transcript
/// already on screen; nothing is fetched.
@injectable
class ExportCubit extends Cubit<ExportState> {
  ExportCubit(this._facade) : super(const ExportState());

  final IExportFacade _facade;

  void setFormat(ExportFormat format) => emit(state.copyWith(format: format));

  void setOptions(ExportOptions options) =>
      emit(state.copyWith(options: options));

  Future<void> share(Transcript transcript) async {
    if (state.status == ExportStatus.sharing) return;
    emit(state.copyWith(status: ExportStatus.sharing, failure: null));
    final result = await _facade.shareFile(
      fileName: TranscriptExport.fileName(transcript.title, state.format),
      mimeType: state.format.mimeType,
      body: TranscriptExport.render(state.format, transcript, state.options),
    );
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ExportStatus.failure, failure: failure)),
      (_) => emit(state.copyWith(status: ExportStatus.idle)),
    );
  }
}
