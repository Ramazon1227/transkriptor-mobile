/// Stops one upload (U-2). The bytes stop at once; the media row is made
/// and confirmed to the end and only then deleted, because a delete sent
/// while the confirm still runs could be overtaken by it. A cancelled
/// upload ends as `Failure.cancelled()` and never starts a job.
///
/// Right before the job request the facade seals it: from then on the
/// job may already exist and be charged, so a cancel does nothing.
class UploadCancel {
  final List<void Function()> _onCancel = [];
  final List<void Function()> _onSeal = [];
  bool _cancelled = false;
  bool _sealed = false;

  bool get isCancelled => _cancelled;

  /// False when it came too late: the job request is already on its way.
  bool cancel() {
    if (_sealed) return false;
    if (_cancelled) return true;
    _cancelled = true;
    _run(_onCancel);
    return true;
  }

  void seal() {
    if (_cancelled || _sealed) return;
    _sealed = true;
    _run(_onSeal);
  }

  /// [listener] runs once, on cancel — at once if that already happened.
  void onCancel(void Function() listener) =>
      _cancelled ? listener() : _onCancel.add(listener);

  /// [listener] runs once, when it is sealed.
  void onSeal(void Function() listener) =>
      _sealed ? listener() : _onSeal.add(listener);

  void _run(List<void Function()> listeners) {
    final now = [...listeners];
    _onCancel.clear();
    _onSeal.clear();
    for (final listener in now) {
      listener();
    }
  }
}
