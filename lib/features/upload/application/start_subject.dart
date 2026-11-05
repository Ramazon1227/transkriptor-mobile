import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_service.dart';

/// What a job start on a stored file is, for its idempotency key: the
/// file and every setting sent with it. A retry with other settings is a
/// new action with a new key — the server refuses a key reused with other
/// settings (422 IDEMPOTENCY_MISMATCH).
Object startSubject(
  String mediaId,
  int? numSpeakers,
  JobService? service,
  JobOptions options,
) => (mediaId, numSpeakers, service, options);
