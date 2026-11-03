import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/utils/idempotency_key.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_service.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/upload_cancel.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

part 'upload_queue_cubit.freezed.dart';

enum QueueItemStatus {
  waiting,
  uploading,
  starting,
  started,

  /// The file is on the server; the job did not start. Retry starts it.
  stored,

  /// The file did not reach the server. Retry uploads it.
  failed,
}

@freezed
abstract class QueueItem with _$QueueItem {
  const factory QueueItem({
    required PendingFile file,
    @Default(QueueItemStatus.waiting) QueueItemStatus status,

    /// 0–1, bytes sent of this file.
    @Default(0) double progress,
    String? mediaId,
    Failure? failure,
  }) = _QueueItem;
}

@freezed
abstract class UploadQueueState with _$UploadQueueState {
  const factory UploadQueueState({
    @Default(<QueueItem>[]) List<QueueItem> items,

    /// Uploading the list. Nothing is added while it runs; leaving the
    /// page asks first and cancels what is still uploading.
    @Default(false) bool running,
    Failure? pickFailure,
  }) = _UploadQueueState;

  const UploadQueueState._();

  int get waitingCount =>
      items.where((i) => i.status == QueueItemStatus.waiting).length;

  bool get allStarted =>
      items.isNotEmpty &&
      items.every((i) => i.status == QueueItemStatus.started);

  /// Bytes still on their way, or files waiting their turn: leaving would
  /// cancel them.
  bool get uploading =>
      running &&
      items.any(
        (i) =>
            i.status == QueueItemStatus.uploading ||
            i.status == QueueItemStatus.waiting,
      );
}

/// Several picked files, each with its own upload and job. One at a time:
/// a file with a job leaves the workspace's limit of files not yet
/// transcribed, so going in turn never reaches that limit by itself.
@injectable
class UploadQueueCubit extends Cubit<UploadQueueState> {
  UploadQueueCubit(this._facade) : super(const UploadQueueState());

  final IUploadFacade _facade;

  /// A start whose answer was lost is retried with the same key, so it
  /// gets that job back instead of a second one.
  final IdempotencyKeys _keys = IdempotencyKeys();

  /// The upload running now, by path (U-2).
  final Map<String, UploadCancel> _cancels = {};

  void open(List<PendingFile> files) => _append(files);

  /// The same path twice would be two transcripts and two charges.
  void _append(List<PendingFile> files) {
    final items = [...state.items];
    for (final file in files) {
      if (items.any((i) => i.file.path == file.path)) continue;
      items.add(QueueItem(file: file));
    }
    emit(state.copyWith(items: items, pickFailure: null));
  }

  Future<void> addMore() async {
    if (state.running) return;
    final result = await _facade.pickFiles();
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(pickFailure: failure)),
      _append,
    );
  }

  /// An uploading item is cancelled: its bytes stop and its half-made row
  /// is deleted. One whose job is being started stays: that request
  /// cannot be taken back. A stored one only leaves the list; the file
  /// stays in Files.
  void remove(String path) {
    // Too late once sealed: the item is already shown as starting.
    _cancels[path]?.cancel();
    bool busy(QueueItem i) => i.status == QueueItemStatus.starting;
    emit(
      state.copyWith(
        items: state.items
            .where((i) => i.file.path != path || busy(i))
            .toList(),
      ),
    );
  }

  /// Leaving the page: what is uploading stops, what waits never starts.
  /// A job already being started is not taken back.
  void cancelAll() {
    for (final cancel in _cancels.values) {
      cancel.cancel();
    }
    emit(
      state.copyWith(
        items: state.items
            .where(
              (i) =>
                  i.status != QueueItemStatus.uploading &&
                  !(state.running && i.status == QueueItemStatus.waiting),
            )
            .toList(),
      ),
    );
  }

  /// A closed page has nobody watching: no job starts after it.
  @override
  Future<void> close() {
    for (final cancel in _cancels.values) {
      cancel.cancel();
    }
    return super.close();
  }

  Future<void> start({
    required String workspaceId,
    int? numSpeakers,
    JobService? service,
  }) async {
    final paths = state.items
        .where((i) => i.status == QueueItemStatus.waiting)
        .map((i) => i.file.path)
        .toList();
    await _run(paths, workspaceId, numSpeakers, service);
  }

  Future<void> retry(
    String path, {
    required String workspaceId,
    int? numSpeakers,
    JobService? service,
  }) => _run([path], workspaceId, numSpeakers, service);

  /// A failed file does not stop the others: a shorter one may still fit
  /// the balance.
  Future<void> _run(
    List<String> paths,
    String workspaceId,
    int? numSpeakers,
    JobService? service,
  ) async {
    if (state.running || paths.isEmpty) return;
    emit(state.copyWith(running: true));
    for (final path in paths) {
      if (isClosed) return;
      final item = _find(path);
      if (item == null) continue; // removed while it waited
      final mediaId = item.mediaId;
      if (mediaId == null) {
        await _uploadAndStart(item, workspaceId, numSpeakers, service);
      } else {
        await _startOnly(item, mediaId, numSpeakers, service);
      }
    }
    if (!isClosed) emit(state.copyWith(running: false));
  }

  Future<void> _uploadAndStart(
    QueueItem item,
    String workspaceId,
    int? numSpeakers,
    JobService? service,
  ) async {
    final path = item.file.path;
    _update(
      path,
      (i) => i.copyWith(
        status: QueueItemStatus.uploading,
        progress: 0,
        failure: null,
      ),
    );
    // Every upload is a new media row, so its job is a new action.
    final jobKey = newIdempotencyKey();
    final cancel = UploadCancel()
      // The job request goes out: no × and no prompt on leaving any more.
      ..onSeal(
        () => _update(
          path,
          (i) => i.copyWith(status: QueueItemStatus.starting, progress: 1),
        ),
      );
    _cancels[path] = cancel;
    final result = await _facade.upload(
      file: item.file,
      workspaceId: workspaceId,
      title: item.file.baseName,
      startTranscription: true,
      jobKey: jobKey,
      numSpeakers: numSpeakers,
      service: service,
      onProgress: (p) {
        final current = _find(path);
        // Dio reports every chunk; one rebuild per percent is enough.
        if (current == null || ((p - current.progress) < 0.01 && p < 1)) return;
        _update(path, (i) => i.copyWith(progress: p));
      },
      cancel: cancel,
    );
    _cancels.remove(path);
    // Cancelled: the item already left the list.
    if (cancel.isCancelled) return;
    result.fold(
      (failure) => _update(
        path,
        (i) => i.copyWith(status: QueueItemStatus.failed, failure: failure),
      ),
      (done) {
        _keys.settle(done.mediaId, done.startFailure, key: jobKey);
        _update(
          path,
          (i) => i.copyWith(
            status: done.startFailure == null
                ? QueueItemStatus.started
                : QueueItemStatus.stored,
            progress: 1,
            mediaId: done.mediaId,
            failure: done.startFailure,
          ),
        );
      },
    );
  }

  Future<void> _startOnly(
    QueueItem item,
    String mediaId,
    int? numSpeakers,
    JobService? service,
  ) async {
    final path = item.file.path;
    _update(
      path,
      (i) => i.copyWith(status: QueueItemStatus.starting, failure: null),
    );
    final result = await _facade.startTranscription(
      mediaId: mediaId,
      idempotencyKey: _keys.keyFor(mediaId),
      numSpeakers: numSpeakers,
      service: service,
    );
    _keys.settle(mediaId, result.fold((f) => f, (_) => null));
    result.fold(
      (failure) => _update(
        path,
        (i) => i.copyWith(status: QueueItemStatus.stored, failure: failure),
      ),
      (_) => _update(path, (i) => i.copyWith(status: QueueItemStatus.started)),
    );
  }

  QueueItem? _find(String path) {
    for (final item in state.items) {
      if (item.file.path == path) return item;
    }
    return null;
  }

  void _update(String path, QueueItem Function(QueueItem) change) {
    if (isClosed) return;
    emit(
      state.copyWith(
        items: [
          for (final item in state.items)
            if (item.file.path == path) change(item) else item,
        ],
      ),
    );
  }
}
