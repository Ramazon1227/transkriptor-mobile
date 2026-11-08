import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/facades/transcript_facade.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/models/transcript_model.dart';
import 'package:transkriptor_uz/features/transcript/infrastructure/repositories/transcript_repository.dart';

class _MockRepository extends Mock implements TranscriptRepository;

void main() {
  late _MockRepository repository;
  late LibraryChanges changes;
  late TranscriptFacade facade;
  late List<void> notified;

  setUp(() {
    repository = _MockRepository();
    changes = LibraryChanges();
    notified = [];
    changes.stream.listen(notified.add);
    facade = TranscriptFacade(repository, changes);
  });

  tearDown(() => changes.dispose());

  void stubRename(Either<Failure, TranscriptMetaModel> answer) => when(
    () => repository.renameTranscript(
      transcriptId: 't1',
      title: 'Yangi nom',
      revision: 3,
    ),
  ).thenAnswer((_) async => answer);

  Future<void> rename() => facade.renameTranscript(
    transcriptId: 't1',
    title: 'Yangi nom',
    revision: 3,
  );

  test('a saved title tells the files list to reload (F-31)', () async {
    stubRename(
      const Right(TranscriptMetaModel(title: 'Yangi nom', revision: 4)),
    );

    await rename();
    await pumpEventQueue();

    expect(notified, hasLength(1));
  });

  test('a refused title leaves the files list alone', () async {
    // A stale revision is a 409.
    stubRename(const Left(Failure.server(statusCode: 409)));

    await rename();
    await pumpEventQueue();

    expect(notified, isEmpty);
  });
}
