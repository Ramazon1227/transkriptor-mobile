import 'package:injectable/injectable.dart';

/// How often a pending answer is asked about. A class so tests can poll
/// without waiting. A long transcript can take the model a minute, so
/// the pace slows down while nothing arrives; once the server writes
/// the answer's text as it goes, it is asked about every [streaming].
@lazySingleton
class AiChatPollPolicy {
  AiChatPollPolicy()
    : first = const Duration(seconds: 2),
      max = const Duration(seconds: 10),
      streaming = const Duration(seconds: 1);

  AiChatPollPolicy.custom({
    required this.first,
    required this.max,
    this.streaming = const Duration(seconds: 1),
  });

  final Duration first;
  final Duration max;

  /// The pace while a pending answer already has text.
  final Duration streaming;

  Duration next(Duration current) {
    final grown = current * 1.5;
    return grown > max ? max : grown;
  }
}
