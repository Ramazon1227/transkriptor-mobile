import 'package:injectable/injectable.dart';

/// How often a `PENDING` analysis is asked about. A class so tests can
/// poll without waiting.
@lazySingleton
class SentimentPollPolicy {
  SentimentPollPolicy() : interval = const Duration(seconds: 3);

  SentimentPollPolicy.custom({required this.interval});

  final Duration interval;
}
