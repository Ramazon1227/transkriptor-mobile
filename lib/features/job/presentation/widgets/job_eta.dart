import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';

/// The time-left line under the progress bar, or null when there is
/// nothing honest to say. Rounded up to whole minutes, never «0 daqiqa».
String? jobEtaText(AppLocalizations l10n, Job job) {
  if (job.status != JobStatus.running) return null;
  final eta = job.etaSeconds;
  if (eta == null) return job.slow ? l10n.jobSlow : null;
  if (eta < 60) return l10n.jobEtaUnderMinute;
  final minutes = (eta / 60).ceil();
  if (minutes < 60) return l10n.jobEtaMinutes(minutes);
  final rest = minutes % 60;
  return rest == 0
      ? l10n.jobEtaHours(minutes ~/ 60)
      : l10n.jobEtaHoursMinutes(minutes ~/ 60, rest);
}
