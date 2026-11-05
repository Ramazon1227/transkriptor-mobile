import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';

/// The request fields of [options]; an empty one is left out, so an old
/// server and a new one both read it as none.
Map<String, Object> jobOptionFields(JobOptions options) {
  final glossaryId = options.glossaryId;
  return {
    if (glossaryId != null && glossaryId.isNotEmpty) 'glossary_id': glossaryId,
    if (options.terms.isNotEmpty) 'terms': options.terms,
    if (options.speakerHints.isNotEmpty)
      'speaker_hints': [
        for (final h in options.speakerHints)
          {'label': h.label, 'start_ms': h.startMs, 'end_ms': h.endMs},
      ],
  };
}
