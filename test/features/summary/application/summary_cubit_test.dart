import 'dart:async';

import 'package:dartz/dartz.dart' show Either, Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/job/application/job_poll_policy.dart';
import 'package:transkriptor_uz/features/summary/application/summary_cubit.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary_template.dart';
import 'package:transkriptor_uz/features/summary/domain/i_summary_facade.dart';

import '../../../helpers/transcripts.dart';

class _MockFacade extends Mock implements ISummaryFacade;

const _sys = SummaryTemplate(
  id: 't1',
  name: 'Asosiy xulosa',
  owner: SummaryTemplateOwner.system,
  categoryId: 'c1',
);
const _other = SummaryTemplate(
  id: 't2',
  name: 'Taʼlim',
  owner: SummaryTemplateOwner.system,
  categoryId: 'c1',
);
const _library = SummaryTemplateLibrary(
  categories: [SummaryTemplateCategory(id: 'c1', name: 'Umumiy')],
  templates: [_sys, _other],
);
const _summary = Summary(
  templateId: 't1',
  sections: [
    SummarySection(kind: SummarySectionKind.overview, paragraph: 'Matn'),
  ],
);

const _pending = Summary(id: 's1', progress: SummaryProgress.pending);
const _done = Summary(id: 's1', body: {'type': 'doc'});

final _fast = JobPollPolicy.custom(
  first: const Duration(milliseconds: 1),
  max: const Duration(milliseconds: 4),
);

void main() {
  late _MockFacade facade;

  setUpAll(() => registerFallbackValue(meetingTranscript()));

  setUp(() {
    facade = _MockFacade();
    when(facade.templates).thenAnswer((_) async => const Right(_library));
    when(() => facade.load(any()))
        .thenAnswer((_) async => const Right((summary: null, sample: false)));
    when(() => facade.delete(any())).thenAnswer((_) async => const Right(unit));
  });

  SummaryCubit build() => SummaryCubit(facade, _fast);

  /// [answers] in turn, the last one repeated.
  void refreshes(List<Either<Failure, Summary?>> answers) {
    var i = 0;
    when(() => facade.refresh(any())).thenAnswer((_) async {
      final a = answers[i < answers.length ? i : answers.length - 1];
      i++;
      return a;
    });
  }

  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 40));

  test('a short transcript is refused before anything loads', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(shortTranscript());
    expect(cubit.state.status, SummaryStatus.tooShort);
    await cubit.generate();
    verifyNever(facade.templates);
    verifyNever(() => facade.generate(any(), template: any(named: 'template')));
  });

  test('loads templates and preselects the preferred one', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    expect(cubit.state.templatesStatus, TemplatesStatus.success);
    expect(cubit.state.template, _sys);
    expect(cubit.state.status, SummaryStatus.idle);
  });

  test('a failed template list keeps the summary usable', () async {
    when(facade.templates)
        .thenAnswer((_) async => const Left(Failure.network()));
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer((_) async => const Right(_summary));
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    expect(cubit.state.templatesStatus, TemplatesStatus.failure);
    await cubit.generate();
    expect(cubit.state.status, SummaryStatus.success);
    expect(cubit.state.summary, _summary);
  });

  test('generates with the selected template', () async {
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer((_) async => const Right(_summary));
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    cubit.selectTemplate(_other);
    await cubit.generate();
    verify(() => facade.generate(any(), template: _other)).called(1);
    expect(cubit.state.status, SummaryStatus.success);
  });

  test('a summary that arrives after delete is dropped', () async {
    final pending = Completer<Either<Failure, Summary>>();
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer((_) => pending.future);
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    final running = cubit.generate();
    expect(cubit.state.status, SummaryStatus.generating);
    await cubit.delete();
    pending.complete(const Right(_summary));
    await running;
    expect(cubit.state.status, SummaryStatus.idle);
    expect(cubit.state.summary, isNull);
  });

  test('a failed star is undone', () async {
    when(() => facade.setFavorite('t2', favorite: true))
        .thenAnswer((_) async => const Left(Failure.network()));
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    final run = cubit.toggleFavorite(_other);
    expect(cubit.state.library!.favorites.single.id, 't2');
    await run;
    expect(cubit.state.library!.favorites, isEmpty);
    expect(cubit.state.favoriteFailure, const Failure.network());
  });

  test('save as note sends the resolved sections', () async {
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer((_) async => const Right(_summary));
    when(
      () => facade.saveAsNote(
        transcriptId: any(named: 'transcriptId'),
        title: any(named: 'title'),
        sections: any(named: 'sections'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => const Right('n1'));
    final cubit = build();
    addTearDown(cubit.close);
    final t = meetingTranscript();
    await cubit.start(t);
    await cubit.generate();
    await cubit.saveAsNote(title: 'X — xulosa', sections: _summary.sections);
    expect(cubit.state.noteStatus, NoteSaveStatus.saved);
    verify(
      () => facade.saveAsNote(
        transcriptId: 't1',
        title: 'X — xulosa',
        sections: _summary.sections,
        body: any(named: 'body'),
      ),
    ).called(1);
  });

  test('opening only reads: nothing is generated', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    verify(() => facade.load('t1')).called(1);
    verifyNever(() => facade.generate(any(), template: any(named: 'template')));
    expect(cubit.state.status, SummaryStatus.idle);
    expect(cubit.state.sample, isFalse);
  });

  test('a server without the API: idle, marked as sample', () async {
    when(() => facade.load(any()))
        .thenAnswer((_) async => const Right((summary: null, sample: true)));
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    expect(cubit.state.sample, isTrue);
    expect(cubit.state.status, SummaryStatus.idle);
  });

  test('a stored DONE summary shows at once', () async {
    when(() => facade.load(any()))
        .thenAnswer((_) async => const Right((summary: _done, sample: false)));
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    expect(cubit.state.status, SummaryStatus.success);
    expect(cubit.state.summary, _done);
  });

  test('generate → PENDING → polls until DONE, then stops', () async {
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer((_) async => const Right(_pending));
    refreshes([
      const Right(_pending),
      const Right(_pending),
      const Right(_done),
    ]);
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    await cubit.generate();
    expect(cubit.state.status, SummaryStatus.generating);
    await settle();
    expect(cubit.state.status, SummaryStatus.success);
    expect(cubit.state.summary, _done);
    verify(() => facade.refresh('t1')).called(3);
    await settle();
    verifyNever(() => facade.refresh(any()));
  });

  test('a stored PENDING summary (bot meeting) is polled too', () async {
    when(
      () => facade.load(any()),
    ).thenAnswer((_) async => const Right((summary: _pending, sample: false)));
    refreshes([const Right(_done)]);
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    expect(cubit.state.status, SummaryStatus.generating);
    await settle();
    expect(cubit.state.status, SummaryStatus.success);
  });

  test('FAILED from the server shows its sentence, retry generates', () async {
    const failed = Summary(
      id: 's1',
      progress: SummaryProgress.failed,
      error: 'Model hozir javob bermadi.',
    );
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer((_) async => const Right(_pending));
    refreshes([const Right(failed)]);
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    await cubit.generate();
    await settle();
    expect(cubit.state.status, SummaryStatus.failure);
    expect(cubit.state.failure, isNull);
    expect(cubit.state.summary?.error, 'Model hozir javob bermadi.');
    await cubit.retry();
    verify(() => facade.generate(any(), template: any(named: 'template')))
        .called(2);
  });

  test('a failed first read: retry reads again, does not generate', () async {
    var calls = 0;
    when(() => facade.load(any())).thenAnswer((_) async {
      calls++;
      return calls == 1
          ? const Left(Failure.network())
          : const Right((summary: null, sample: false));
    });
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    expect(cubit.state.status, SummaryStatus.failure);
    await cubit.retry();
    expect(cubit.state.status, SummaryStatus.idle);
    verifyNever(() => facade.generate(any(), template: any(named: 'template')));
  });

  test('a late poll after delete is dropped', () async {
    final inFlight = Completer<Either<Failure, Summary?>>();
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer((_) async => const Right(_pending));
    when(() => facade.refresh(any())).thenAnswer((_) => inFlight.future);
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    await cubit.generate();
    await settle(); // the poll is in flight
    await cubit.delete();
    expect(cubit.state.status, SummaryStatus.idle);
    inFlight.complete(const Right(_done));
    await settle();
    expect(cubit.state.status, SummaryStatus.idle);
    expect(cubit.state.summary, isNull);
  });

  test('a transient poll failure keeps waiting; a 404 stops', () async {
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer((_) async => const Right(_pending));
    refreshes([
      const Left(Failure.network()),
      const Left(Failure.server(statusCode: 404)),
    ]);
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    await cubit.generate();
    await settle();
    expect(cubit.state.status, SummaryStatus.failure);
    expect(cubit.state.failure, const Failure.server(statusCode: 404));
    verify(() => facade.refresh('t1')).called(2);
  });

  test('a failed delete keeps the summary and says so', () async {
    when(() => facade.load(any()))
        .thenAnswer((_) async => const Right((summary: _done, sample: false)));
    when(() => facade.delete(any()))
        .thenAnswer((_) async => const Left(Failure.network()));
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    await cubit.delete();
    expect(cubit.state.status, SummaryStatus.success);
    expect(cubit.state.summary, _done);
    expect(cubit.state.actionFailure, const Failure.network());
  });

  test('closing stops polling', () async {
    when(() => facade.generate(any(), template: any(named: 'template')))
        .thenAnswer((_) async => const Right(_pending));
    refreshes([const Right(_pending)]);
    final cubit = build();
    await cubit.start(meetingTranscript());
    await cubit.generate();
    await cubit.close();
    await settle();
    verifyNever(() => facade.refresh(any()));
  });

  test('save as note passes the server body', () async {
    when(() => facade.load(any()))
        .thenAnswer((_) async => const Right((summary: _done, sample: false)));
    when(
      () => facade.saveAsNote(
        transcriptId: any(named: 'transcriptId'),
        title: any(named: 'title'),
        sections: any(named: 'sections'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => const Right('n1'));
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    await cubit.saveAsNote(title: 'X', sections: const []);
    verify(
      () => facade.saveAsNote(
        transcriptId: 't1',
        title: 'X',
        sections: const [],
        body: const {'type': 'doc'},
      ),
    ).called(1);
  });
}
