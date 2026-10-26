import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/infrastructure/repositories/job_repository.dart';
import 'package:transkriptor_uz/features/library/infrastructure/repositories/library_repository.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/repositories/transcript_repository.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/repositories/upload_repository.dart';

import '../helpers/fake_http_adapter.dart';

/// Paths, query parameters and JSON keys as `tr-backend`'s swagger
/// declares them (`api/docs/swagger.json`, 2026-10-26).
void main() {
  group('AuthRepository', () {
    test('login posts email and password and reads the token pair', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/auth/login': (
          200,
          ok({
            'access_token': 'a',
            'refresh_token': 'r',
            'expires_in': 900,
            'token_type': 'Bearer',
          }),
        ),
      });
      final result = await AuthRepository(fakeDio(http))
          .login(email: 'e@misol.uz', password: 'p');

      final pair = result.getOrElse(() => throw StateError('left'));
      expect(pair.accessToken, 'a');
      expect(pair.refreshToken, 'r');
      expect(http.sent.single.body, {'email': 'e@misol.uz', 'password': 'p'});
    });

    test('register sends RegisterRequest keys with locale uz', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/auth/register': (
          201,
          ok({
            'access_token': 'a',
            'refresh_token': 'r',
            'expires_in': 900,
            'token_type': 'Bearer',
            'user': {'id': 'u', 'email': 'e'},
            'workspace': {'id': 'w', 'name': 'Shaxsiy'},
          }),
        ),
      });
      final result = await AuthRepository(
        fakeDio(http),
      ).register(email: 'e@misol.uz', password: 'parol-12345', fullName: 'Ism');
      expect(
        result.getOrElse(() => throw StateError('left')).refreshToken,
        'r',
      );
      expect(http.sent.single.body, {
        'email': 'e@misol.uz',
        'password': 'parol-12345',
        'full_name': 'Ism',
        'locale': 'uz',
      });
    });

    test('a 401 from login is unauthorized', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/auth/login': (401, {'status': 'UNAUTHORIZED'}),
      });
      final result = await AuthRepository(fakeDio(http))
          .login(email: 'e', password: 'x');
      expect(result.fold((f) => f, (_) => null), const Failure.unauthorized());
    });

    test('me reads user and workspaces', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/me': (
          200,
          ok({
            'user': {'id': 'u', 'email': 'e', 'full_name': 'Ism'},
            'workspaces': [
              {
                'id': 'w',
                'name': 'Shaxsiy',
                'is_personal': true,
                'balance_seconds': 12900,
              },
            ],
          }),
        ),
      });
      final me = (await AuthRepository(
        fakeDio(http),
      ).me()).getOrElse(() => throw StateError('left'));
      expect(me.toEntity().currentWorkspace?.balanceSeconds, 12900);
    });

    test('logout sends the refresh token', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/auth/logout': (200, ok(<String, Object?>{})),
      });
      await AuthRepository(fakeDio(http)).logout(refreshToken: 'r');
      expect(http.sent.single.body, {'refresh_token': 'r'});
    });

    test('a body without data is a parsing failure', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/me': (200, {'status': 'OK'}),
      });
      final result = await AuthRepository(fakeDio(http)).me();
      expect(result.fold((f) => f, (_) => null), const Failure.parsing());
    });
  });

  test('LibraryRepository sends workspace_id and reads items', () async {
    final http = FakeHttpAdapter({
      'GET /api/v1/library': (
        200,
        ok({
          'items': [
            {'media_id': 'm', 'name': 'A', 'job_status': 'RUNNING'},
          ],
        }),
      ),
    });
    final items = (await LibraryRepository(
      fakeDio(http),
    ).getItems(workspaceId: 'w1')).getOrElse(() => throw StateError('left'));
    expect(items.single.toEntity().jobStatus, JobStatus.running);
    expect(http.sent.single.options.queryParameters, {'workspace_id': 'w1'});
  });

  group('JobRepository', () {
    test('create sends the key in header and body, no null fields', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/job': (
          202,
          ok({'id': 'j', 'media_id': 'm', 'status': 'QUEUED'}),
        ),
      });
      final job = (await JobRepository(fakeDio(http)).createJob(mediaId: 'm'))
          .getOrElse(() => throw StateError('left'));

      final sent = http.sent.single;
      final body = sent.body! as Map<String, Object?>;
      expect(job.status, JobStatus.queued);
      expect(body['media_id'], 'm');
      expect(body.containsKey('num_speakers'), isFalse);
      expect(sent.options.headers['Idempotency-Key'], body['idempotency_key']);
    });

    test('get and cancel use the job id in the path', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/job/j1': (200, ok({'id': 'j1', 'status': 'RUNNING'})),
        'POST /api/v1/job/j1/cancel': (
          200,
          ok({'id': 'j1', 'status': 'CANCELLED'}),
        ),
      });
      final repo = JobRepository(fakeDio(http));
      final got = (await repo.getJob('j1'))
          .getOrElse(() => throw StateError(''));
      final cancelled = (await repo.cancel('j1'))
          .getOrElse(() => throw StateError(''));
      expect(got.status, JobStatus.running);
      expect(cancelled.status, JobStatus.cancelled);
    });

    test('402 keeps its status code for the no-balance message', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/job': (402, {'status': 'PAYMENT_REQUIRED'}),
      });
      final result = await JobRepository(fakeDio(http))
          .createJob(mediaId: 'm', numSpeakers: 2);
      expect(
        result.fold((f) => f, (_) => null),
        const Failure.server(statusCode: 402),
      );
    });
  });

  test('TranscriptRepository reads segments and speakers', () async {
    final http = FakeHttpAdapter({
      'GET /api/v1/transcript/t1': (
        200,
        ok({
          'id': 't1',
          'title': 'Kengash',
          'speakers': [
            {'id': 's1', 'label': 'Maʼruzachi 1', 'ordinal': 1},
          ],
          'segments': [
            {
              'id': 'g',
              'start_ms': 7000,
              'end_ms': 12000,
              'text': 'Salom',
              'speaker_id': 's1',
              'words': <Object>[],
            },
          ],
        }),
      ),
    });
    final t = (await TranscriptRepository(fakeDio(http)).getTranscript('t1'))
        .getOrElse(() => throw StateError('left'));
    expect(t.toEntity().segments.single.speakerId, 's1');
  });

  group('UploadRepository', () {
    test('createMedia sends the CreateMediaRequest keys', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/media': (
          201,
          ok({'id': 'm', 'upload_url': 'https://s3.test/put?sig=1'}),
        ),
      });
      final media =
          (await UploadRepository(fakeDio(http), fakeDio(http)).createMedia(
            workspaceId: 'w',
            fileName: 'a.m4a',
            sizeBytes: 10,
            source: 'RECORDING',
          )).getOrElse(() => throw StateError('left'));
      expect(media.uploadUrl, 'https://s3.test/put?sig=1');
      expect(http.sent.single.body, {
        'workspace_id': 'w',
        'filename': 'a.m4a',
        'size_bytes': 10,
        'source': 'RECORDING',
      });
    });

    test('putFile streams the bytes with length and type, no auth', () async {
      final dir = await Directory.systemTemp.createTemp('tr_put');
      addTearDown(() => dir.delete(recursive: true));
      final file = File('${dir.path}/a.m4a')
        ..writeAsBytesSync(List.filled(2048, 7));
      final api = FakeHttpAdapter({});
      final storage = FakeHttpAdapter({'PUT /put': (200, null)});
      final progress = <int>[];

      final result = await UploadRepository(fakeDio(api), fakeDio(storage))
          .putFile(
            uploadUrl: 'https://s3.test/put?sig=1',
            path: file.path,
            sizeBytes: 2048,
            contentType: 'audio/mp4',
            onProgress: (sent, _) => progress.add(sent),
          );

      expect(result.isRight(), isTrue);
      expect(api.sent, isEmpty);
      final sent = storage.sent.single;
      expect(sent.bodyBytes, 2048);
      expect(sent.options.headers['content-type'], 'audio/mp4');
      expect(sent.options.headers.containsKey('Authorization'), isFalse);
      expect(progress.last, 2048);
    });

    test('a YouTube link goes to /media/youtube', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/media/youtube': (
          202,
          ok({'id': 'j', 'status': 'QUEUED'}),
        ),
        'POST /api/v1/media/cloud': (202, ok({'id': 'k', 'status': 'QUEUED'})),
      });
      final repo = UploadRepository(fakeDio(http), fakeDio(http));
      await repo.startLink(url: 'u', workspaceId: 'w', youtube: true);
      await repo.startLink(
        url: 'v',
        workspaceId: 'w',
        youtube: false,
        numSpeakers: 3,
      );
      expect(http.sent.map((s) => s.options.path), [
        '/api/v1/media/youtube',
        '/api/v1/media/cloud',
      ]);
      expect((http.sent.last.body! as Map)['num_speakers'], 3);
    });
  });
}
