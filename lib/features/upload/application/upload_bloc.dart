import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

part 'upload_bloc.freezed.dart';
part 'upload_event.dart';
part 'upload_state.dart';

@injectable
class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc(this._facade) : super(const UploadState()) {
    // Sending is paid work: a second tap while one runs is ignored.
    on<UploadEvent>(_onEvent, transformer: droppable());
  }

  final IUploadFacade _facade;

  Future<void> _onEvent(UploadEvent event, Emitter<UploadState> emit) =>
      switch (event) {
        UploadFileSubmitted() => _onFile(event, emit),
        UploadLinkSubmitted() => _onLink(event, emit),
        UploadStartRetried() => _onStartRetried(event, emit),
      };

  Future<void> _onFile(
    UploadFileSubmitted event,
    Emitter<UploadState> emit,
  ) async {
    emit(const UploadState(status: UploadStatus.uploading));

    final result = await _facade.upload(
      file: event.file,
      workspaceId: event.workspaceId,
      title: event.title,
      startTranscription: event.startTranscription,
      numSpeakers: event.numSpeakers,
      onProgress: (p) {
        // Dio reports every chunk; one rebuild per percent is enough.
        if (emit.isDone || ((p - state.progress) < 0.01 && p < 1)) return;
        emit(state.copyWith(progress: p));
      },
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(status: UploadStatus.failure, failure: failure)),
      (done) => emit(
        state.copyWith(
          // Stored but not started: the page offers a start-only retry.
          status: done.startFailure == null
              ? UploadStatus.success
              : UploadStatus.stored,
          progress: 1,
          mediaId: done.mediaId,
          job: done.job,
          failure: done.startFailure,
        ),
      ),
    );
  }

  /// The file is already on the server; only the job is started.
  Future<void> _onStartRetried(
    UploadStartRetried event,
    Emitter<UploadState> emit,
  ) async {
    emit(state.copyWith(status: UploadStatus.starting, failure: null));
    final result = await _facade.startTranscription(
      mediaId: event.mediaId,
      numSpeakers: event.numSpeakers,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: UploadStatus.stored, failure: failure)),
      (job) => emit(state.copyWith(status: UploadStatus.success, job: job)),
    );
  }

  Future<void> _onLink(
    UploadLinkSubmitted event,
    Emitter<UploadState> emit,
  ) async {
    final url = event.url.trim();
    if (!isSupportedLink(url)) {
      emit(const UploadState(linkInvalid: true));
      return;
    }
    emit(const UploadState(status: UploadStatus.uploading));

    final result = await _facade.startLink(
      url: url,
      workspaceId: event.workspaceId,
      numSpeakers: event.numSpeakers,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(status: UploadStatus.failure, failure: failure)),
      (job) => emit(
        state.copyWith(
          status: UploadStatus.success,
          mediaId: job.mediaId,
          job: job,
        ),
      ),
    );
  }
}

/// YouTube, Google Drive and Dropbox: the hosts the backend can fetch.
bool isSupportedLink(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null || !(uri.scheme == 'https' || uri.scheme == 'http')) {
    return false;
  }
  final host = uri.host.toLowerCase();
  return host.endsWith('youtube.com') ||
      host == 'youtu.be' ||
      host == 'drive.google.com' ||
      host.endsWith('dropbox.com');
}
