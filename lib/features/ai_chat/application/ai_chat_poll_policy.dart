import 'package:injectable/injectable.dart';

/// How often a pending answer is asked about. A class so tests can poll
/// without waiting. A long transcript can take the model a minute, so
/// the pace slows down while nothing arrives.
@lazySingleton
class AiChatPollPolicy {
  AiChatPollPolicy()
    : first = const Duration(seconds: 2),
      max = const Duration(seconds: 10);

  AiChatPollPolicy.custom({required this.first, required this.max});

  final Duration first;
  final Duration max;

  Duration next(Duration current) {
    final grown = current * 1.5;
    return grown > max ? max : grown;
  }
}
