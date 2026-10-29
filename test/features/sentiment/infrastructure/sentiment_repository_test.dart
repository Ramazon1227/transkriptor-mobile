import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';
import 'package:transkriptor_uz/features/sentiment/infrastructure/facades/sentiment_facade.dart';
import 'package:transkriptor_uz/features/sentiment/infrastructure/repositories/sentiment_repository.dart';

import '../../../helpers/fake_http_adapter.dart';

void main() {
  const path = '/api/v1/transcript/t1/sentiment';

  SentimentFacade facade(FakeHttpAdapter adapter) =>
      SentimentFacade(SentimentRepository(fakeDio(adapter)));

  test('never requested: sentiment null → null', () async {
    final f = facade(
      FakeHttpAdapter({
        'GET $path': (200, ok({'sentiment': null})),
      }),
    );
    final r = await f.get('t1');
    expect(r.isRight(), isTrue);
    expect(r.getOrElse(() => throw StateError('')), isNull);
  });

  test('DONE parses overall, speakers (flat shares) and labels', () async {
    final f = facade(
      FakeHttpAdapter({
        'GET $path': (
          200,
          ok({
            'sentiment': {
              'status': 'DONE',
              'note': ' Mijoz avval norozi. ',
              'attempt': 2,
              'model': 'gemma4:12b',
              'outdated': true,
              'unlabeled': 1,
              'overall': {
                'positive': 0.25,
                'neutral': 0.375,
                'negative': 0.375,
                'score': -0.125,
              },
              'speakers': [
                {
                  'speaker_id': 'sp1',
                  'label': 'Operator',
                  'talk_ms': 8000,
                  'positive': 0.5,
                  'neutral': 0.5,
                  'negative': 0,
                  'score': 0.5,
                },
                {
                  'speaker_id': null,
                  'label': '',
                  'talk_ms': 2000,
                  'positive': 0,
                  'neutral': 0,
                  'negative': 1,
                  'score': -1,
                },
              ],
              'segments': [
                {'segment_id': 'g1', 'label': 'POSITIVE'},
                {'segment_id': 'g2', 'label': 'NEUTRAL'},
                {'segment_id': 'g3', 'label': 'NEGATIVE'},
                {'segment_id': 'g4', 'label': 'ANGRY'},
              ],
              'created_at': '2026-10-29T10:00:00Z',
              'updated_at': '2026-10-29T10:01:00Z',
            },
          }),
        ),
      }),
    );
    final s = (await f.get('t1')).getOrElse(() => throw StateError(''))!;
    expect(s.status, SentimentStatus.done);
    expect(s.note, 'Mijoz avval norozi.');
    expect(s.error, isNull);
    expect(s.attempt, 2);
    expect(s.outdated, isTrue);
    expect(s.unlabeled, 1);
    expect(s.overall.negative, .375);
    expect(s.overall.score, -.125);
    expect(s.speakers, hasLength(2));
    expect(s.speakers[0].speakerId, 'sp1');
    expect(s.speakers[0].talk, const Duration(seconds: 8));
    expect(s.speakers[0].share.positive, .5);
    expect(s.speakers[1].speakerId, isNull);
    expect(s.speakers[1].share.negative, 1);
    expect(s.labels.keys, ['g1', 'g2', 'g3', 'g4']);
    expect(s.labels['g1'], SentimentLabel.positive);
    expect(s.labels['g3'], SentimentLabel.negative);
    expect(s.labels['g4'], SentimentLabel.unknown);
    expect(s.updatedAt, DateTime.utc(2026, 10, 29, 10, 1));
  });

  test('FAILED carries the server sentence; unknown status survives', () async {
    final failed = facade(
      FakeHttpAdapter({
        'GET $path': (
          200,
          ok({
            'sentiment': {
              'status': 'FAILED',
              'error': 'AI hozir javob bermayapti.',
              'speakers': <Object>[],
              'segments': <Object>[],
            },
          }),
        ),
      }),
    );
    final s = (await failed.get('t1')).getOrElse(() => throw StateError(''))!;
    expect(s.status, SentimentStatus.failed);
    expect(s.error, 'AI hozir javob bermayapti.');
    expect(s.overall.isEmpty, isTrue);

    final odd = facade(
      FakeHttpAdapter({
        'GET $path': (
          200,
          ok({
            'sentiment': {'status': 'QUEUED'},
          }),
        ),
      }),
    );
    final o = (await odd.get('t1')).getOrElse(() => throw StateError(''))!;
    expect(o.status, SentimentStatus.unknown);
    expect(o.labels, isEmpty);
  });

  test('analyze posts with no body and reads the PENDING row', () async {
    final adapter = FakeHttpAdapter({
      'POST $path': (
        202,
        ok({
          'sentiment': {
            'status': 'PENDING',
            'attempt': 3,
            'speakers': <Object>[],
            'segments': <Object>[],
          },
        }),
      ),
    });
    final s = (await facade(adapter).analyze('t1'))
        .getOrElse(() => throw StateError(''));
    expect(s.status, SentimentStatus.pending);
    expect(s.attempt, 3);
    expect(adapter.sent.single.options.method, 'POST');
    expect(adapter.sent.single.body, isNull);
  });

  // The real envelope: `description` is generic, the reason is in
  // `data.error` (apihttp.Conflict / apihttp.Unavailable).
  test('analyze: 503 shows the reason from data.error', () async {
    final f = facade(
      FakeHttpAdapter({
        'POST $path': (
          503,
          {
            'status': 'UNAVAILABLE',
            'description': 'xizmat vaqtincha mavjud emas',
            'data': {'error': 'AI band — birozdan keyin qayta urinib koʻring'},
          },
        ),
      }),
    );
    final r = await f.analyze('t1');
    expect(
      r.fold((l) => l, (_) => null),
      const Failure.server(
        statusCode: 503,
        message: 'AI band — birozdan keyin qayta urinib koʻring',
      ),
    );
  });

  const workspaceBusy =
      'ish maydonida bir vaqtda 3 tadan ortiq tahlil ketmaydi — '
      'birortasi tugashini kuting';

  test('analyze: each 409 keeps its own reason', () async {
    for (final reason in [
      'tahlil hozir ketmoqda — kuting',
      'transkriptda matn yoʻq',
      workspaceBusy,
    ]) {
      final f = facade(
        FakeHttpAdapter({
          'POST $path': (
            409,
            {
              'status': 'CONFLICT',
              'description': 'ziddiyat',
              'data': {'error': reason},
            },
          ),
        }),
      );
      expect(
        (await f.analyze('t1')).fold((l) => l, (_) => null),
        Failure.server(statusCode: 409, message: reason),
      );
    }
  });

  test('a refusal without data.error keeps the description', () async {
    final f = facade(
      FakeHttpAdapter({
        'POST $path': (
          403,
          {'status': 'FORBIDDEN', 'description': 'ruxsat yoʻq', 'data': null},
        ),
      }),
    );
    expect(
      (await f.analyze('t1')).fold((l) => l, (_) => null),
      const Failure.server(statusCode: 403, message: 'ruxsat yoʻq'),
    );
  });

  test(
    'analyze: 202 with sentiment null, or a mis-shaped body → parsing',
    () async {
      final empty = facade(
        FakeHttpAdapter({
          'POST $path': (202, ok({'sentiment': null})),
        }),
      );
      expect(
        (await empty.analyze('t1')).fold((l) => l, (_) => null),
        const Failure.parsing(),
      );
      final bad = facade(
        FakeHttpAdapter({
          'GET $path': (200, ok({'sentiment': 'DONE'})),
        }),
      );
      expect(
        (await bad.get('t1')).fold((l) => l, (_) => null),
        const Failure.parsing(),
      );
    },
  );
}
