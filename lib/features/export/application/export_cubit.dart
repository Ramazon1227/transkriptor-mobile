import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/export/domain/docx_export.dart';
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
/// already on screen; nothing is fetched. DOCX and PDF use the TXT
/// layout's blocks.
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
    final format = state.format;
    final built = await _build(format, transcript, state.options);
    if (isClosed) return;
    final result = await built.fold(
      (failure) async => Left<Failure, Unit>(failure),
      (bytes) => _facade.shareFile(
        fileName: TranscriptExport.fileName(transcript.title, format),
        mimeType: format.mimeType,
        bytes: bytes,
      ),
    );
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: ExportStatus.failure, failure: failure)),
      (_) => emit(state.copyWith(status: ExportStatus.idle)),
    );
  }

  Future<Either<Failure, Uint8List>> _build(
    ExportFormat format,
    Transcript transcript,
    ExportOptions options,
  ) async {
    final title = TranscriptExport.title(transcript, options);
    return switch (format) {
      ExportFormat.docx => Right(
        DocxExport.build(title, TranscriptExport.blocks(transcript, options)),
      ),
      ExportFormat.pdf => await _facade.pdf(
        title,
        TranscriptExport.blocks(transcript, options),
      ),
      _ => Right(
        utf8.encode(TranscriptExport.fileBody(format, transcript, options)),
      ),
    };
  }
}
