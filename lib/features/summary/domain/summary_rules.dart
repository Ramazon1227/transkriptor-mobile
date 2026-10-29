import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Fewer segments than this and a summary would only repeat the text.
const int summaryMinSegments = 3;

bool canSummarize(Transcript transcript) =>
    transcript.segments.where((s) => s.text.trim().isNotEmpty).length >=
    summaryMinSegments;
