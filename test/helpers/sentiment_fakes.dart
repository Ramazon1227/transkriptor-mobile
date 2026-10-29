import 'dart:async';
import 'dart:collection';

import 'package:dartz/dartz.dart' show Either, Right;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';
import 'package:transkriptor_uz/features/sentiment/domain/i_sentiment_facade.dart';

/// Answers from queues, each GET optionally held on a completer, so a
/// test decides when (and in which order) answers arrive. With an empty
/// GET queue it repeats [fallback].
class FakeSentimentFacade implements ISentimentFacade {
  final Queue<Completer<Either<Failure, SentimentAnalysis?>>> gets = Queue();
  final Queue<Either<Failure, SentimentAnalysis>> analyzes = Queue();
  Either<Failure, SentimentAnalysis?> fallback = const Right(null);
  int getCalls = 0;
  int analyzeCalls = 0;

  void answer(Either<Failure, SentimentAnalysis?> r) =>
      gets.add(Completer()..complete(r));

  Completer<Either<Failure, SentimentAnalysis?>> held() {
    final c = Completer<Either<Failure, SentimentAnalysis?>>();
    gets.add(c);
    return c;
  }

  @override
  Future<Either<Failure, SentimentAnalysis?>> get(String transcriptId) {
    getCalls++;
    if (gets.isEmpty) return Future.value(fallback);
    return gets.removeFirst().future;
  }

  @override
  Future<Either<Failure, SentimentAnalysis>> analyze(
    String transcriptId,
  ) async {
    analyzeCalls++;
    return analyzes.removeFirst();
  }
}

const pendingAnalysis = SentimentAnalysis(
  status: SentimentStatus.pending,
  attempt: 1,
);

const doneAnalysis = SentimentAnalysis(
  status: SentimentStatus.done,
  attempt: 1,
  note: 'Mijoz avval norozi, operator uzr soʻragach mamnun boʻldi.',
  overall: SentimentShare(
    positive: .25,
    neutral: .375,
    negative: .375,
    score: -.125,
  ),
  speakers: [
    SpeakerSentiment(
      speakerId: 's1',
      label: 'Dilnoza',
      talk: Duration(seconds: 8),
      share: SentimentShare(positive: .5, neutral: .5, score: .5),
    ),
    SpeakerSentiment(
      talk: Duration(seconds: 2),
      share: SentimentShare(negative: 1, score: -1),
    ),
  ],
  labels: {'g1': SentimentLabel.positive, 'g2': SentimentLabel.negative},
);
