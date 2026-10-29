import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/entities/meeting_bot.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/meet_link.dart';
import 'package:transkriptor_uz/features/meeting_bot/infrastructure/repositories/meeting_bot_repository.dart';

import '../../helpers/fake_http_adapter.dart';

/// `handler.MeetingBotResponse` / `MeetingBotList` on backend
/// `feat/meet-bot` (2026-10-29).
Map<String, Object?> _bot({String status = 'WAITING'}) => {
  'id': 'b1',
  'workspace_id': 'w1',
  'meet_url': 'https://meet.google.com/abc-defg-hij',
  'status': status,
  'error_code': '',
  'error_message': '',
  'cancel_requested': false,
  'bot_name': 'Transkriptor (yozib olmoqda)',
  'media_id': null,
  'job_id': null,
  'meeting_title': 'Haftalik yigʻilish',
  'keep_video': true,
  'auto_joined': false,
  'scheduled_for': null,
  'created_at': '2026-10-29T09:30:00Z',
  'started_at': null,
  'ended_at': null,
};

void main() {
  group('MeetingBotRepository', () {
    test('create posts the backend keys and reads the bot', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/meeting-bots': (202, ok(_bot())),
      });
      final result = await MeetingBotRepository(fakeDio(http)).create(
        workspaceId: 'w1',
        meetUrl: 'https://meet.google.com/abc-defg-hij',
        keepVideo: true,
        numSpeakers: 3,
      );
      final bot = result.getOrElse(() => throw StateError('left')).toEntity();
      expect(bot.status, MeetingBotStatus.waiting);
      expect(bot.botName, 'Transkriptor (yozib olmoqda)');
      expect(bot.keepVideo, isTrue);
      expect(bot.meetingTitle, 'Haftalik yigʻilish');
      // Empty strings from Go become null, not "".
      expect(bot.errorMessage, isNull);
      expect(bot.errorCode, isNull);
      expect(bot.createdAt, DateTime.utc(2026, 10, 29, 9, 30));
      expect(http.sent.single.body, {
        'meet_url': 'https://meet.google.com/abc-defg-hij',
        'workspace_id': 'w1',
        'keep_video': true,
        'num_speakers': 3,
      });
    });

    test('create leaves num_speakers out for Auto; no language', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/meeting-bots': (202, ok(_bot())),
      });
      await MeetingBotRepository(fakeDio(http)).create(
        workspaceId: 'w1',
        meetUrl: 'https://meet.google.com/abc-defg-hij',
        keepVideo: false,
      );
      final body = http.sent.single.body! as Map<String, Object?>;
      expect(body.containsKey('num_speakers'), isFalse);
      expect(body.containsKey('language'), isFalse);
    });

    test('list reads available, the default name and the items', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/meeting-bots': (
          200,
          ok({
            'available': false,
            'default_bot_name': 'Bot (yozib olmoqda)',
            'items': [
              _bot(status: 'DONE')..['job_id'] = 'j1',
              _bot(status: 'SOMETHING_NEW'),
            ],
          }),
        ),
      });
      final list = (await MeetingBotRepository(
        fakeDio(http),
      ).list(workspaceId: 'w1')).getOrElse(() => throw StateError('left'));
      final entity = list.toEntity();
      expect(entity.available, isFalse);
      expect(entity.defaultBotName, 'Bot (yozib olmoqda)');
      expect(entity.items.first.status, MeetingBotStatus.done);
      expect(entity.items.first.jobId, 'j1');
      // An unknown status never crashes parsing.
      expect(entity.items.last.status, MeetingBotStatus.unknown);
      expect(http.sent.single.options.queryParameters, {'workspace_id': 'w1'});
    });

    test('a server without the route answers 404', () async {
      final http = FakeHttpAdapter({});
      final result = await MeetingBotRepository(fakeDio(http))
          .list(workspaceId: 'w1');
      expect(
        result.fold((f) => f, (_) => null),
        const Failure.server(statusCode: 404),
      );
    });

    test('get and cancel use /meeting-bots/:id', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/meeting-bots/b1': (200, ok(_bot(status: 'RECORDING'))),
        'DELETE /api/v1/meeting-bots/b1': (
          200,
          ok(_bot(status: 'RECORDING')..['cancel_requested'] = true),
        ),
      });
      final repo = MeetingBotRepository(fakeDio(http));
      final got = (await repo.get('b1')).getOrElse(() => throw StateError(''));
      expect(got.status, MeetingBotStatus.recording);
      final cancelled = (await repo.cancel('b1'))
          .getOrElse(() => throw StateError(''));
      expect(cancelled.cancelRequested, isTrue);
    });
  });

  group('canonicalMeetUrl', () {
    test('accepts what the backend accepts, canonical', () {
      expect(
        canonicalMeetUrl(' https://meet.google.com/abc-defg-hij '),
        'https://meet.google.com/abc-defg-hij',
      );
      expect(
        canonicalMeetUrl('http://MEET.google.com/abc-defg-hij/?authuser=1'),
        'https://meet.google.com/abc-defg-hij',
      );
    });

    test('rejects everything else', () {
      for (final bad in [
        '',
        'meet.google.com/abc-defg-hij',
        'ftp://meet.google.com/abc-defg-hij',
        'https://meet.google.com/ABC-DEFG-HIJ',
        'https://meet.google.com/abc-defg-hi',
        'https://meet.google.com/lookup/abc',
        'https://zoom.us/j/123456789',
        'https://evil.com/abc-defg-hij',
      ]) {
        expect(canonicalMeetUrl(bad), isNull, reason: bad);
      }
    });
  });
}
