import 'dart:math';

import 'package:transkriptor_uz/core/error/failure.dart';

/// 128 random bits as hex. Sent with every request that starts paid work,
/// so a retried tap cannot start the same job twice.
String newIdempotencyKey() {
  final random = Random.secure();
  return List.generate(
    16,
    (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join();
}

/// The idempotency keys of one screen's paid actions, by what each acts on
/// (a media id, a link). A key belongs to one action of the person: made on
/// the first tap and sent again while that action is retried, so a request
/// whose answer was lost — the job may exist — gets the same job back
/// instead of a second one and a second charge. A definite answer ends the
/// action; the next tap is a new one with a new key.
class IdempotencyKeys {
  final Map<Object, String> _keys = {};

  /// The key a failed try left for [subject], or a new one.
  String keyFor(Object subject) => _keys[subject] ??= newIdempotencyKey();

  /// Records how the action on [subject] ended. [key] is the one sent when
  /// it was not taken from [keyFor] (the subject became known only after
  /// the request, as an upload's media id).
  void settle(Object subject, Failure? failure, {String? key}) {
    if (failure != null && mayHaveReachedServer(failure)) {
      if (key != null) _keys[subject] = key;
    } else {
      _keys.remove(subject);
    }
  }

  /// No answer, or one that does not say the job was refused: the server
  /// may have created it, so a retry must carry the same key.
  static bool mayHaveReachedServer(Failure failure) => switch (failure) {
    NetworkFailure() ||
    TimeoutFailure() ||
    ParsingFailure() ||
    CancelledFailure() ||
    UnknownFailure() => true,
    ServerFailure(:final statusCode) => statusCode == null || statusCode >= 500,
    _ => false,
  };
}
