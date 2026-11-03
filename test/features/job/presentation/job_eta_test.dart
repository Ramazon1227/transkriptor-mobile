import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/infrastructure/models/job_model.dart';
import 'package:transkriptor_uz/features/job/presentation/widgets/job_eta.dart';

void main() {
  final l10n = AppLocalizationsUz();
  Job running({int? eta, bool slow = false}) =>
      Job(id: 'j', status: JobStatus.running, etaSeconds: eta, slow: slow);

  test('rounds up to whole minutes and never says zero', () {
    expect(jobEtaText(l10n, running(eta: 0)), '1 daqiqadan kam qoldi');
    expect(jobEtaText(l10n, running(eta: 61)), 'taxminan 2 daqiqa qoldi');
    expect(jobEtaText(l10n, running(eta: 720)), 'taxminan 12 daqiqa qoldi');
    expect(jobEtaText(l10n, running(eta: 3600)), 'taxminan 1 soat qoldi');
    expect(
      jobEtaText(l10n, running(eta: 3900)),
      'taxminan 1 soat 5 daqiqa qoldi',
    );
  });

  test('says slow instead of a time, and nothing without an estimate', () {
    expect(jobEtaText(l10n, running(slow: true)), l10n.jobSlow);
    expect(jobEtaText(l10n, running()), isNull);
  });

  test('only a running job has a time left', () {
    const queued = Job(id: 'j', status: JobStatus.queued, etaSeconds: 600);
    expect(jobEtaText(l10n, queued), isNull);
  });

  test('reads eta_seconds and slow, tolerating a server without them', () {
    final full = JobModel.fromJson({
      'id': 'j',
      'status': 'RUNNING',
      'progress': 53,
      'eta_seconds': 720,
      'slow': false,
    }).toEntity();
    expect(full.etaSeconds, 720);
    expect(full.slow, isFalse);

    final old = JobModel.fromJson({
      'id': 'j',
      'status': 'RUNNING',
      'progress': 40,
    }).toEntity();
    expect(old.etaSeconds, isNull);
    expect(old.slow, isFalse);

    final negative = JobModel.fromJson({
      'id': 'j',
      'status': 'RUNNING',
      'eta_seconds': -5,
      'slow': true,
    }).toEntity();
    expect(negative.etaSeconds, isNull);
    expect(negative.slow, isTrue);
  });
}
