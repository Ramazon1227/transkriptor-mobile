// DEMO SOURCE — replaced when a learn endpoint exists.
//
// Builds study items from the transcript's own sentences with simple,
// deterministic rules (no model): a cloze card blanks one word; a
// multiple-choice question blanks one word and offers words from other
// sentences as distractors; a false true/false statement swaps one word
// for a word from another sentence. Same transcript and settings, same
// items. The tab labels the result «Namuna».

import 'dart:math';

import 'package:transkriptor_uz/core/utils/sentences.dart';
import 'package:transkriptor_uz/features/learn/domain/entities/learn.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// The blank on a card or in a question.
const String learnBlank = '_____';

class LearnGenerator {
  const LearnGenerator();

  /// A sentence shorter than this says too little to ask about.
  static const int minSentenceWords = 5;

  List<Flashcard> flashcards(
    Transcript transcript, {
    required int count,
    required LearnDifficulty difficulty,
  }) {
    final picks = _picks(transcript, 'cards', count, difficulty);
    return [
      for (final p in picks)
        Flashcard(
          front: _blankOut(p.sentence, p.word),
          back: p.word,
          source: p.sentence,
        ),
    ];
  }

  List<QuizQuestion> quiz(
    Transcript transcript, {
    required int count,
    required LearnDifficulty difficulty,
    required Set<QuizQuestionType> types,
  }) {
    if (types.isEmpty) return const [];
    final ordered = QuizQuestionType.values.where(types.contains).toList();
    final random = Random(
      _seed('${transcript.id}|quiz|$count|${difficulty.name}|$ordered'),
    );
    final pool = _words(_sentences(transcript), difficulty);
    final out = <QuizQuestion>[];
    for (final p in _picks(transcript, 'quiz', count * 2, difficulty)) {
      if (out.length >= count) break;
      final type = ordered[out.length % ordered.length];
      final distractors = _distractors(p, pool, difficulty, random);
      final question = switch (type) {
        QuizQuestionType.multipleChoice => _multipleChoice(
          p,
          distractors,
          difficulty,
          random,
        ),
        QuizQuestionType.trueFalse => _trueFalse(p, distractors, random),
      };
      if (question != null) out.add(question);
    }
    return out;
  }

  QuizQuestion? _multipleChoice(
    _Pick p,
    List<String> distractors,
    LearnDifficulty difficulty,
    Random random,
  ) {
    final wanted = difficulty == LearnDifficulty.easy ? 2 : 3;
    if (distractors.isEmpty) return null;
    final options = [p.word, ...distractors.take(wanted)]..shuffle(random);
    return QuizQuestion(
      type: QuizQuestionType.multipleChoice,
      prompt: _blankOut(p.sentence, p.word),
      options: options,
      correctIndex: options.indexOf(p.word),
      source: p.sentence,
    );
  }

  QuizQuestion _trueFalse(
    _Pick p,
    List<String> distractors,
    Random random,
  ) {
    final makeFalse = distractors.isNotEmpty && random.nextBool();
    return QuizQuestion(
      type: QuizQuestionType.trueFalse,
      prompt: makeFalse
          ? _replaceFirst(p.sentence, p.word, distractors.first)
          : p.sentence,
      correctIndex: makeFalse ? 1 : 0,
      source: p.sentence,
    );
  }

  /// Up to [count] (sentence, word) pairs. A sentence is used again with
  /// a different word only when there are fewer sentences than [count].
  List<_Pick> _picks(
    Transcript transcript,
    String salt,
    int count,
    LearnDifficulty difficulty,
  ) {
    final sentences = _sentences(transcript)
      ..shuffle(
        Random(_seed('${transcript.id}|$salt|$count|${difficulty.name}')),
      );
    final candidates = {
      for (final s in sentences) s: _candidates(s, difficulty),
    };
    final out = <_Pick>[];
    for (var pass = 0; out.length < count; pass++) {
      var added = false;
      for (final s in sentences) {
        if (out.length >= count) break;
        final words = candidates[s]!;
        if (pass < words.length) {
          out.add(_Pick(s, words[pass]));
          added = true;
        }
      }
      if (!added) break;
    }
    return out;
  }

  /// Unique sentences long enough to ask about, in transcript order.
  List<String> _sentences(Transcript transcript) {
    final seen = <String>{};
    return [
      for (final segment in transcript.segments)
        for (final s in splitSentences(segment.text))
          if (sentenceWords(s).length >= minSentenceWords && seen.add(s)) s,
    ];
  }

  /// The words of [sentence] worth blanking, best first: easy prefers
  /// long, distinctive words; hard also takes shorter ones.
  List<String> _candidates(String sentence, LearnDifficulty difficulty) {
    final min = _minLength(difficulty);
    final seen = <String>{};
    final words = [
      for (final w in sentenceWords(sentence))
        if (w.runes.length >= min &&
            !_isNumber(w) &&
            seen.add(w.toLowerCase()))
          w,
    ];
    return switch (difficulty) {
      LearnDifficulty.easy =>
        words..sort((a, b) => b.runes.length.compareTo(a.runes.length)),
      LearnDifficulty.medium || LearnDifficulty.hard => words,
    };
  }

  List<String> _words(List<String> sentences, LearnDifficulty difficulty) {
    final seen = <String>{};
    return [
      for (final s in sentences)
        for (final w in _candidates(s, difficulty))
          if (seen.add(w.toLowerCase())) w,
    ];
  }

  /// Words from other sentences. Hard: the closest in length (harder to
  /// tell apart); otherwise in random order.
  List<String> _distractors(
    _Pick p,
    List<String> pool,
    LearnDifficulty difficulty,
    Random random,
  ) {
    final own = sentenceWords(p.sentence).map((w) => w.toLowerCase()).toSet();
    final out = pool.where((w) => !own.contains(w.toLowerCase())).toList();
    if (difficulty == LearnDifficulty.hard) {
      final len = p.word.runes.length;
      out.sort(
        (a, b) => (a.runes.length - len).abs().compareTo(
          (b.runes.length - len).abs(),
        ),
      );
    } else {
      out.shuffle(random);
    }
    return out;
  }

  static int _minLength(LearnDifficulty d) => switch (d) {
    LearnDifficulty.easy => 6,
    LearnDifficulty.medium => 5,
    LearnDifficulty.hard => 4,
  };

  static bool _isNumber(String w) => RegExp(r'^\d+$').hasMatch(w);

  static String _blankOut(String sentence, String word) =>
      _replaceFirst(sentence, word, learnBlank);

  static String _replaceFirst(String sentence, String word, String by) =>
      sentence.replaceFirst(
        RegExp('(?<![\\p{L}\\p{N}])${RegExp.escape(word)}(?![\\p{L}\\p{N}])',
            unicode: true),
        by,
      );

  /// FNV-1a: stable across runs, unlike `String.hashCode`.
  static int _seed(String s) {
    var h = 0x811c9dc5;
    for (final c in s.codeUnits) {
      h = ((h ^ c) * 0x01000193) & 0x7fffffff;
    }
    return h;
  }
}

class _Pick {
  const _Pick(this.sentence, this.word);
  final String sentence;
  final String word;
}
