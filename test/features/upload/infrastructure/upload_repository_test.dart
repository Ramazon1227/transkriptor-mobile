import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/error/held_file.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/repositories/upload_repository.dart';

import '../../../helpers/fake_http_adapter.dart';

void main() {
  Future<Failure?> create((int, Object?) answer) async {
    final dio = fakeDio(FakeHttpAdapter({'POST /api/v1/media': answer}));
    final result = await UploadRepository(dio, Dio()).createMedia(
      workspaceId: 'w1',
      fileName: 'a.mp3',
      sizeBytes: 10,
      source: 'UPLOAD',
    );
    return result.fold<Failure?>((f) => f, (_) => null);
  }

  test('a 409 PENDING_LIMIT names the files holding the limit', () async {
    final failure = await create((
      409,
      {
        'status': 'PENDING_LIMIT',
        'data': {
          'files': 5,
          'max_files': 5,
          'held': [
            {
              'id': 'm1',
              'name': 'suhbat.mp3',
              'size_bytes': 2048,
              'state': 'FAILED',
              'job_id': 'j1',
              'expires_at': '2026-11-05T10:00:00Z',
              'deletable': true,
            },
            {'id': 'm2', 'name': 'yozuv.webm', 'state': 'UNCONFIRMED'},
          ],
        },
      },
    ));
    expect(failure, isA<PendingLimitFailure>());
    final held = (failure! as PendingLimitFailure).held;
    expect(held, hasLength(2));
    expect(held[0].state, HeldFileState.failed);
    expect(held[0].sizeBytes, 2048);
    expect(held[0].expiresAt, DateTime.utc(2026, 11, 5, 10));
    expect(held[0].deletable, isTrue);
    expect(held[1].state, HeldFileState.unconfirmed);
    expect(held[1].deletable, isFalse);
  });

  test('an older server without the list still gives the reason', () async {
    final failure = await create((
      409,
      {
        'status': 'PENDING_LIMIT',
        'data': {'files': 5, 'max_files': 5},
      },
    ));
    expect(failure, const Failure.pendingLimit());
  });

  test('a list it cannot read still gives the reason', () async {
    final failure = await create((
      409,
      {
        'status': 'PENDING_LIMIT',
        'data': {
          'held': ['nonsense'],
        },
      },
    ));
    expect(failure, const Failure.pendingLimit());
  });

  test('another 409 stays a server failure', () async {
    final failure = await create((
      409,
      {'status': 'CONFLICT', 'data': <String, Object?>{}},
    ));
    expect(failure, isA<ServerFailure>());
  });
}
