import 'package:dartz/dartz.dart' show Right, unit;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/glossary/infrastructure/facades/glossary_facade.dart';
import 'package:transkriptor_uz/features/glossary/infrastructure/repositories/glossary_repository.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_options.dart';
import 'package:transkriptor_uz/features/job/infrastructure/models/job_model.dart';
import 'package:transkriptor_uz/features/job/infrastructure/repositories/job_repository.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/facades/upload_facade.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/media_picker.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/models/media_created_model.dart';
import 'package:transkriptor_uz/features/upload/infrastructure/repositories/upload_repository.dart';

import '../../../helpers/fake_http_adapter.dart';

class _MockRepository extends Mock implements UploadRepository;

class _MockJobs extends Mock implements JobRepository;

class _MockPicker extends Mock implements MediaPicker;

const _options = JobOptions(
  glossaryId: 'g1',
  terms: ['IT Park', 'Mirziyoyev'],
  speakerHints: [SpeakerHint(label: 'Sarvar', startMs: 15000, endMs: 25000)],
);

const Map<String, Object> _optionsJson = {
  'glossary_id': 'g1',
  'terms': ['IT Park', 'Mirziyoyev'],
  'speaker_hints': [
    {'label': 'Sarvar', 'start_ms': 15000, 'end_ms': 25000},
  ],
};

void main() {
  group('JobRepository panel options (A-1, A-3)', () {
    test('sends glossary, terms and hints when set', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/job': (202, ok({'id': 'j', 'status': 'QUEUED'})),
      });
      await JobRepository(fakeDio(http)).createJob(
        mediaId: 'm',
        idempotencyKey: 'k',
        numSpeakers: 2,
        options: _options,
      );
      final body = http.sent.single.body! as Map<String, Object?>;
      expect(body, {
        'media_id': 'm',
        'num_speakers': 2,
        ..._optionsJson,
        'idempotency_key': 'k',
      });
    });

    test('empty options send no field at all', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/job': (202, ok({'id': 'j', 'status': 'QUEUED'})),
      });
      await JobRepository(fakeDio(http)).createJob(
        mediaId: 'm',
        idempotencyKey: 'k',
        options: const JobOptions(glossaryId: ''),
      );
      final body = http.sent.single.body! as Map<String, Object?>;
      expect(body.keys, unorderedEquals(['media_id', 'idempotency_key']));
    });

    test('reads the options back, skipping what it cannot read', () {
      final job = JobModel.fromJson({
        'id': 'j',
        'status': 'FAILED',
        'glossary_id': 'g1',
        'terms': ['IT Park', 7, null, ''],
        'terms_applied': 3,
        'speaker_hints': [
          {'label': 'Sarvar', 'start_ms': 15000, 'end_ms': 25000},
          {'label': 'Bad', 'start_ms': 5000, 'end_ms': 1000},
          'nonsense',
          {'label': '', 'start_ms': 0, 'end_ms': 2000},
        ],
      }).toEntity();
      expect(job.glossaryId, 'g1');
      expect(job.terms, ['IT Park']);
      expect(job.termsApplied, 3);
      expect(job.speakerHints, const [
        SpeakerHint(label: 'Sarvar', startMs: 15000, endMs: 25000),
      ]);
      expect(
        job.options,
        const JobOptions(
          glossaryId: 'g1',
          terms: ['IT Park'],
          speakerHints: [
            SpeakerHint(label: 'Sarvar', startMs: 15000, endMs: 25000),
          ],
        ),
      );
    });

    test('an older server without the fields: none, not a failure', () {
      final job = JobModel.fromJson({
        'id': 'j',
        'status': 'QUEUED',
        'glossary_id': null,
        'terms': null,
        'speaker_hints': null,
      }).toEntity();
      expect(job.glossaryId, isNull);
      expect(job.terms, isEmpty);
      expect(job.termsApplied, 0);
      expect(job.speakerHints, isEmpty);
      expect(job.options.isEmpty, isTrue);
    });
  });

  group('UploadRepository destination (A-2)', () {
    test('the folder goes with the media row only when chosen', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/media': (201, ok({'id': 'm', 'upload_url': 'u'})),
      });
      final repo = UploadRepository(fakeDio(http), Dio());
      await repo.createMedia(
        workspaceId: 'w2',
        fileName: 'a.mp3',
        sizeBytes: 10,
        source: 'UPLOAD',
        folderId: 'f1',
      );
      await repo.createMedia(
        workspaceId: 'w2',
        fileName: 'a.mp3',
        sizeBytes: 10,
        source: 'UPLOAD',
      );
      final first = http.sent[0].body! as Map<String, Object?>;
      final second = http.sent[1].body! as Map<String, Object?>;
      expect(first['workspace_id'], 'w2');
      expect(first['folder_id'], 'f1');
      expect(second.containsKey('folder_id'), isFalse);
    });

    test('a link sends folder and options', () async {
      final http = FakeHttpAdapter({
        'POST /api/v1/media/youtube': (
          202,
          ok({'id': 'j', 'status': 'QUEUED'}),
        ),
        'POST /api/v1/media/cloud': (202, ok({'id': 'j', 'status': 'QUEUED'})),
      });
      final repo = UploadRepository(fakeDio(http), Dio());
      await repo.startLink(
        url: 'https://youtu.be/x',
        workspaceId: 'w1',
        youtube: true,
        idempotencyKey: 'k',
        folderId: 'f1',
        options: const JobOptions(glossaryId: 'g1', terms: ['IT Park']),
      );
      await repo.startLink(
        url: 'https://drive.google.com/x',
        workspaceId: 'w1',
        youtube: false,
        idempotencyKey: 'k2',
      );
      final yt = http.sent[0].body! as Map<String, Object?>;
      expect(yt['folder_id'], 'f1');
      expect(yt['glossary_id'], 'g1');
      expect(yt['terms'], ['IT Park']);
      expect(yt.containsKey('speaker_hints'), isFalse);
      final cloud = http.sent[1].body! as Map<String, Object?>;
      expect(
        cloud.keys,
        unorderedEquals(['url', 'workspace_id', 'idempotency_key']),
      );
    });
  });

  test('UploadFacade hands folder to the row and options to the job', () async {
    final repository = _MockRepository();
    final jobs = _MockJobs();
    final changes = LibraryChanges();
    addTearDown(changes.dispose);
    final facade = UploadFacade(repository, jobs, _MockPicker(), changes);
    when(
      () => repository.createMedia(
        workspaceId: 'w2',
        fileName: 'a.mp3',
        sizeBytes: 10,
        source: 'UPLOAD',
        folderId: 'f1',
      ),
    ).thenAnswer(
      (_) async => const Right(MediaCreatedModel(id: 'm1', uploadUrl: 'u')),
    );
    when(
      () => repository.putFile(
        uploadUrl: any(named: 'uploadUrl'),
        path: any(named: 'path'),
        sizeBytes: any(named: 'sizeBytes'),
        contentType: any(named: 'contentType'),
        onProgress: any(named: 'onProgress'),
        cancel: any(named: 'cancel'),
      ),
    ).thenAnswer((_) async => const Right(unit));
    when(() => repository.confirm('m1'))
        .thenAnswer((_) async => const Right(unit));
    when(
      () => jobs.createJob(
        mediaId: 'm1',
        idempotencyKey: 'k',
        numSpeakers: 2,
        service: any(named: 'service'),
        options: _options,
      ),
    ).thenAnswer(
      (_) async => const Right(
        JobModel(id: 'j1', mediaId: 'm1', status: JobStatus.queued),
      ),
    );

    final result = await facade.upload(
      file: const PendingFile(
        path: '/a.mp3',
        fileName: 'a.mp3',
        sizeBytes: 10,
        source: UploadSource.upload,
      ),
      workspaceId: 'w2',
      folderId: 'f1',
      title: 'a',
      startTranscription: true,
      jobKey: 'k',
      numSpeakers: 2,
      options: _options,
    );
    expect(result.getOrElse(() => throw StateError('left')).job?.id, 'j1');
  });

  group('GlossaryRepository', () {
    test('asks by workspace in the query and reads the lists', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/glossaries': (
          200,
          ok({
            'items': [
              {
                'id': 'g1',
                'workspace_id': 'w1',
                'name': 'Kengash',
                'term_count': 4,
                'is_default': true,
              },
              {'name': 'no id'},
            ],
          }),
        ),
      });
      final lists =
          (await GlossaryFacade(GlossaryRepository(fakeDio(http)))
                  .glossaries(workspaceId: 'w 1'))
              .getOrElse(() => throw StateError('left'));
      expect(http.sent.single.options.queryParameters, {'workspace_id': 'w 1'});
      expect(lists.single.name, 'Kengash');
      expect(lists.single.termCount, 4);
    });

    test('null items is an empty list', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/glossaries': (200, ok({'items': null})),
      });
      final lists = (await GlossaryRepository(fakeDio(http)).glossaries(
        workspaceId: 'w1',
      )).getOrElse(() => throw StateError('left'));
      expect(lists, isEmpty);
    });
  });
}
