import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/api_config.dart';

/// How often a running job is asked about. A class, not two constants, so
/// tests can poll without waiting.
@lazySingleton
class JobPollPolicy {
  JobPollPolicy()
    : first = ApiConfig.jobPollInterval,
      max = ApiConfig.jobPollMaxInterval;

  JobPollPolicy.custom({required this.first, required this.max});

  final Duration first;
  final Duration max;

  /// Slower while nothing changes; back to [first] on any change.
  Duration next(Duration current, {required bool changed}) {
    if (changed) return first;
    final grown = current * 1.5;
    return grown > max ? max : grown;
  }
}
