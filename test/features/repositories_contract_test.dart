import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/infrastructure/repositories/job_repository.dart';
import 'package:transkriptor_uz/features/library/infrastructure/repositories/library_repository.dart';
import 'package:transkriptor_uz/features/push/infrastructure/repositories/push_repository.dart';
import 'package:transkriptor_uz/features/share/infrastructure/repositories/share_repository.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/repositories/transcript_repository.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/repositories/upload_repository.dart';

import '../helpers/fake_http_adapter.dart';

/// Paths, query parameters and JSON keys as `tr-backend`'s swagger
/// declares them (`api/docs/swagger.json`, 2026-10-26).
void main() {
  group('AuthRepository', () {
    test('deleteAccount sends DELETE /me with the confirmation', () async {
      final http = FakeHttpAdapter({
        'DELETE /api/v1/me': (200, ok({'deleted': true})),
      });
      final result = await AuthRepository(fakeDio(http))
          .deleteAccount(password: 'p');
      expect(result.isRight(), isTrue);
      // Only the field that applies: the server checks one or the other.
      expect(http.sent.single.body, {'password': 'p'});
    });

    test('GET /me reads has_password and the workspace role', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/me': (
          200,
          ok({
            'user': {'id': 'u', 'email': 'e', 'has_password': false},
            'workspaces': [
              {'id': 'w', 'name': 'S', 'role': 'VIEWER'},
            ],
          }),
        ),
      });
      final me = (await AuthRepository(
        fakeDio(http),
      ).me()).getOrElse(() => throw StateError('left'));
      final account = me.toEntity();
      expect(account.user.hasPassword, isFalse);
      expect(account.workspaces.single.role.canWrite, isFalse);
    });

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

    test('forgot posts only the email and takes the 202', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/auth/password/forgot': (202, ok({'sent': true})),
      });
      final result = await AuthRepository(fakeDio(http))
          .requestPasswordReset(email: 'e@misol.uz');
      expect(result.isRight(), isTrue);
      expect(http.sent.single.body, {'email': 'e@misol.uz'});
    });

    test('forgot without a mail service keeps its 503', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/auth/password/forgot': (503, {'status': 'UNAVAILABLE'}),
      });
      final result = await AuthRepository(fakeDio(http))
          .requestPasswordReset(email: 'e@misol.uz');
      expect(
        result.fold((f) => f, (_) => null),
        isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 503),
      );
    });

    test('a body without data is a parsing failure', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/me': (200, {'status': 'OK'}),
      });
      final result = await AuthRepository(fakeDio(http)).me();
      expect(result.fold((f) => f, (_) => null), const Failure.parsing());
    });

    test('updateName is PATCH /me {full_name} and reads data.user', () async {
      final http = FakeHttpAdapter({
        'PATCH /api/v1/me': (
          200,
          ok({
            'user': {
              'id': 'u1',
              'email': 'e@misol.uz',
              'full_name': 'Ali Valiyev',
              'email_verified': true,
              'locale': 'uz',
              'has_password': false,
            },
          }),
        ),
      });
      final user = (await AuthRepository(
        fakeDio(http),
      ).updateName('Ali Valiyev')).getOrElse(() => throw StateError('left'));
      expect(user.toEntity().fullName, 'Ali Valiyev');
      expect(user.hasPassword, isFalse);
      expect(http.sent.single.body, {'full_name': 'Ali Valiyev'});
    });

    test('updateName without data.user is a parsing failure', () async {
      final http = FakeHttpAdapter({'PATCH /api/v1/me': (200, ok({}))});
      final result = await AuthRepository(fakeDio(http)).updateName('A');
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

  group('LibraryRepository folders and file patch', () {
    test('folder_id narrows the list', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/library': (200, ok({'items': <Object>[]})),
      });
      await LibraryRepository(fakeDio(http))
          .getItems(workspaceId: 'w1', folderId: 'f1');
      expect(http.sent.single.options.queryParameters, {
        'workspace_id': 'w1',
        'folder_id': 'f1',
      });
    });

    test('folders are listed, created, renamed and deleted by path', () async {
      const folder = {'id': 'f1', 'name': 'Sud', 'file_count': 3};
      final http = FakeHttpAdapter({
        'GET /api/v1/workspaces/w1/folders': (
          200,
          ok({
            'items': [folder],
          }),
        ),
        'POST /api/v1/workspaces/w1/folders': (201, ok({'folder': folder})),
        'PATCH /api/v1/workspaces/w1/folders/f1': (200, ok({'folder': folder})),
        'DELETE /api/v1/workspaces/w1/folders/f1': (200, ok({'deleted': true})),
      });
      final repo = LibraryRepository(fakeDio(http));
      final list = (await repo.getFolders(workspaceId: 'w1'))
          .getOrElse(() => throw StateError('left'));
      expect(list.single.toEntity().fileCount, 3);
      await repo.createFolder(workspaceId: 'w1', name: 'Sud');
      await repo.renameFolder(workspaceId: 'w1', folderId: 'f1', name: 'Sud');
      final deleted = await repo.deleteFolder(
        workspaceId: 'w1',
        folderId: 'f1',
      );
      expect(deleted.isRight(), isTrue);
      expect(http.sent[1].body, {'name': 'Sud'});
      expect(http.sent[2].body, {'name': 'Sud'});
    });

    test('a move out of every folder sends folder_id: null', () async {
      final http = FakeHttpAdapter({
        'PATCH /api/v1/media/m1': (
          200,
          ok({
            'item': {'media_id': 'm1', 'name': 'A', 'folder_id': null},
          }),
        ),
      });
      final item = (await LibraryRepository(fakeDio(http)).updateMedia(
        mediaId: 'm1',
        patch: {'folder_id': null},
      )).getOrElse(() => throw StateError('left'));
      final body = http.sent.single.body! as Map<String, Object?>;
      expect(body.containsKey('folder_id'), isTrue);
      expect(body['folder_id'], isNull);
      expect(body.containsKey('tags'), isFalse);
      expect(item.toEntity().folderId, isNull);
    });
  });

  group('AuthRepository Google', () {
    test('providers: the client id, or null when Google is off', () async {
      final on = FakeHttpAdapter({
        'GET /api/v1/auth/oauth/providers': (
          200,
          ok({
            'google': {'client_id': 'web-id'},
            'apple': null,
          }),
        ),
      });
      final off = FakeHttpAdapter({
        'GET /api/v1/auth/oauth/providers': (
          200,
          ok({'google': null, 'apple': null}),
        ),
      });
      expect(
        (await AuthRepository(
          fakeDio(on),
        ).googleClientId()).getOrElse(() => throw StateError('left')),
        'web-id',
      );
      expect(
        (await AuthRepository(
          fakeDio(off),
        ).googleClientId()).getOrElse(() => throw StateError('left')),
        isNull,
      );
    });

    test('sign-in posts only id_token and reads the top-level pair', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/auth/oauth/google': (
          200,
          ok({
            'access_token': 'a',
            'refresh_token': 'r',
            'token_type': 'Bearer',
            'expires_in': 900,
            'user': {'id': 'u1'},
            'created': true,
          }),
        ),
      });
      final pair = (await AuthRepository(
        fakeDio(http),
      ).googleSignIn(idToken: 'g')).getOrElse(() => throw StateError('left'));
      expect(pair.accessToken, 'a');
      expect(pair.refreshToken, 'r');
      expect(http.sent.single.body, {'id_token': 'g'});
    });
  });

  test('PushRepository registers and removes by body token', () async {
    final http = FakeHttpAdapter({
      'POST /api/v1/me/devices': (200, ok({'registered': true})),
      'DELETE /api/v1/me/devices': (200, ok({'deleted': true})),
    });
    final repo = PushRepository(fakeDio(http));
    expect(
      (await repo.register(token: 't', platform: 'ANDROID')).isRight(),
      isTrue,
    );
    expect((await repo.unregister(token: 't')).isRight(), isTrue);
    expect(http.sent[0].body, {'token': 't', 'platform': 'ANDROID'});
    expect(http.sent[1].body, {'token': 't'});
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

  group('TranscriptRepository edits', () {
    test(
      'segment text sends text and revision, reads SegmentResponse',
      () async {
        final http = FakeHttpAdapter({
          'PATCH /api/v1/transcript/t1/segments/g': (
            200,
            ok({
              'segment': {
                'id': 'g',
                'start_ms': 7000,
                'end_ms': 12000,
                'text': 'Salom!',
                'speaker_id': 's1',
                'edited': true,
                'words': <Object>[],
              },
              'revision': 4,
            }),
          ),
        });
        final edit =
            (await TranscriptRepository(fakeDio(http)).updateSegmentText(
              transcriptId: 't1',
              segmentId: 'g',
              text: 'Salom!',
              revision: 3,
            )).getOrElse(() => throw StateError('left')).toEntity();

        expect(http.sent.single.body, {'text': 'Salom!', 'revision': 3});
        expect(edit.revision, 4);
        expect(edit.segment.text, 'Salom!');
        expect(edit.segment.edited, isTrue);
      },
    );

    test('a stale revision keeps its 409', () async {
      final http = FakeHttpAdapter({
        'PATCH /api/v1/transcript/t1/segments/g': (
          409,
          {'status': 'CONFLICT', 'description': 'ziddiyat'},
        ),
      });
      final result = await TranscriptRepository(fakeDio(http))
          .updateSegmentText(
            transcriptId: 't1',
            segmentId: 'g',
            text: 'x',
            revision: 1,
          );
      expect(
        result.fold((f) => f, (_) => null),
        isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 409),
      );
    });

    test(
      'speaker rename sends only the label, reads SpeakerResponse',
      () async {
        final http = FakeHttpAdapter({
          'PATCH /api/v1/transcript/t1/speakers/s1': (
            200,
            ok({
              'speaker': {'id': 's1', 'ordinal': 1, 'label': 'Dilnoza R.'},
            }),
          ),
        });
        final speaker =
            (await TranscriptRepository(fakeDio(http)).renameSpeaker(
              transcriptId: 't1',
              speakerId: 's1',
              label: 'Dilnoza R.',
            )).getOrElse(() => throw StateError('left'));

        expect(http.sent.single.body, {'label': 'Dilnoza R.'});
        expect(speaker.label, 'Dilnoza R.');
      },
    );
  });

  group('TranscriptRepository speaker assignment', () {
    Map<String, (int, Object?)> route() => {
      'PATCH /api/v1/transcript/t1/segments/g': (
        200,
        ok({
          'segment': {
            'id': 'g',
            'start_ms': 7000,
            'end_ms': 12000,
            'text': 'Salom',
            'speaker_id': 's3',
            'edited': false,
            'words': <Object>[],
          },
          'revision': 4,
          'new_speaker': {'id': 's3', 'ordinal': 3, 'label': 'Maʼruzachi 3'},
        }),
      ),
    };

    test('an existing speaker sends speaker_id and revision', () async {
      final http = FakeHttpAdapter(route());
      await TranscriptRepository(fakeDio(http)).assignSpeaker(
        transcriptId: 't1',
        segmentId: 'g',
        speakerId: 's2',
        revision: 3,
      );
      expect(http.sent.single.body, {'speaker_id': 's2', 'revision': 3});
    });

    test('a new speaker sends new_speaker and reads it back', () async {
      final http = FakeHttpAdapter(route());
      final edit = (await TranscriptRepository(fakeDio(http)).assignSpeaker(
        transcriptId: 't1',
        segmentId: 'g',
        speakerId: null,
        revision: 3,
      )).getOrElse(() => throw StateError('left')).toEntity();

      expect(http.sent.single.body, {'new_speaker': true, 'revision': 3});
      expect(edit.revision, 4);
      expect(edit.segment.speakerId, 's3');
      expect(edit.newSpeaker?.label, 'Maʼruzachi 3');
    });
  });

  group('TranscriptRepository split and merge', () {
    Map<String, Object> seg(String id, String text) => {
      'id': id,
      'start_ms': 0,
      'end_ms': 1000,
      'text': text,
      'speaker_id': 's1',
      'edited': true,
      'words': <Object>[],
    };

    test('split posts at and revision, reads both parts', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/transcript/t1/segments/g/split': (
          200,
          ok({
            'segments': [seg('g', 'Salom'), seg('h', 'dunyo')],
            'revision': 4,
          }),
        ),
      });
      final split = (await TranscriptRepository(fakeDio(http)).splitSegment(
        transcriptId: 't1',
        segmentId: 'g',
        at: 6,
        revision: 3,
      )).getOrElse(() => throw StateError('left')).toEntity();

      expect(http.sent.single.body, {'at': 6, 'revision': 3});
      expect(split.first.text, 'Salom');
      expect(split.second.id, 'h');
      expect(split.revision, 4);
    });

    test('a split answer without two parts is a parsing failure', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/transcript/t1/segments/g/split': (
          200,
          ok({
            'segments': [seg('g', 'Salom')],
            'revision': 4,
          }),
        ),
      });
      final result = await TranscriptRepository(fakeDio(http))
          .splitSegment(transcriptId: 't1', segmentId: 'g', at: 6, revision: 3);
      expect(result.fold((f) => f, (_) => null), const Failure.parsing());
    });

    test('a split at the edge keeps its 422', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/transcript/t1/segments/g/split': (
          422,
          {'status': 'UNPROCESSABLE_ENTITY', 'description': 'chetda'},
        ),
      });
      final result = await TranscriptRepository(fakeDio(http))
          .splitSegment(transcriptId: 't1', segmentId: 'g', at: 1, revision: 3);
      expect(
        result.fold((f) => f, (_) => null),
        isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 422),
      );
    });

    test('merge-next posts the revision, reads removed_id', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/transcript/t1/segments/g/merge-next': (
          200,
          ok({
            'segment': seg('g', 'Salom dunyo'),
            'removed_id': 'h',
            'revision': 5,
          }),
        ),
      });
      final merge = (await TranscriptRepository(fakeDio(http)).mergeNext(
        transcriptId: 't1',
        segmentId: 'g',
        revision: 4,
      )).getOrElse(() => throw StateError('left')).toEntity();

      expect(http.sent.single.body, {'revision': 4});
      expect(merge.segment.text, 'Salom dunyo');
      expect(merge.removedId, 'h');
      expect(merge.revision, 5);
    });
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

  group('ShareRepository', () {
    test('create sends CreateShareRequest keys and reads link.url', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/transcript/t1/share': (
          201,
          ok({
            'link': {
              'id': 'l1',
              'transcript_id': 't1',
              'token': 'tok',
              'url': 'https://app.test/s/tok',
              'can_comment': false,
              'include_media': true,
              'view_count': 0,
              'expires_at': '2026-11-26T10:00:00Z',
              'created_at': '2026-10-27T10:00:00Z',
            },
          }),
        ),
      });
      final link = (await ShareRepository(fakeDio(http)).createLink(
        transcriptId: 't1',
        includeMedia: true,
        expiresDays: 30,
      )).getOrElse(() => throw StateError('left')).toEntity();

      expect(http.sent.single.body, {
        'include_media': true,
        'expires_days': 30,
      });
      expect(link.url, 'https://app.test/s/tok');
      expect(link.expiresAt, DateTime.utc(2026, 11, 26, 10));
    });

    test('list reads items; a missing expiry is null', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/transcript/t1/share': (
          200,
          ok({
            'items': [
              {
                'id': 'l1',
                'view_count': 7,
                'expires_at': null,
                'created_at': '2026-10-27T10:00:00Z',
              },
            ],
          }),
        ),
      });
      final items = (await ShareRepository(fakeDio(http)).listLinks('t1'))
          .getOrElse(() => throw StateError('left'));
      expect(items.single.toEntity().viewCount, 7);
      expect(items.single.toEntity().expiresAt, isNull);
      expect(items.single.toEntity().url, isNull);
    });

    test('revoke deletes /share/:id', () async {
      final http = FakeHttpAdapter({
        'DELETE /api/v1/share/l1': (200, ok({'deleted': true})),
      });
      final result = await ShareRepository(fakeDio(http)).revokeLink('l1');
      expect(result.isRight(), isTrue);
      expect(http.sent.single.options.method, 'DELETE');
    });
  });
}
