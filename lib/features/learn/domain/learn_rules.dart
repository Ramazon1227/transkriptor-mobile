import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// Fewer segments than this and the cards would be nonsense.
const int learnMinSegments = 3;

bool canLearn(Transcript transcript) =>
    transcript.segments.where((s) => s.text.trim().isNotEmpty).length >=
    learnMinSegments;
