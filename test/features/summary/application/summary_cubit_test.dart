import 'dart:async';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
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

void main() {
  late _MockFacade facade;

  setUpAll(() => registerFallbackValue(meetingTranscript()));

  setUp(() {
    facade = _MockFacade();
    when(facade.templates).thenAnswer((_) async => const Right(_library));
  });

  test('a short transcript is refused before anything loads', () async {
    final cubit = SummaryCubit(facade);
    addTearDown(cubit.close);
    await cubit.start(shortTranscript());
    expect(cubit.state.status, SummaryStatus.tooShort);
    await cubit.generate();
    verifyNever(facade.templates);
    verifyNever(() => facade.generate(any(), template: any(named: 'template')));
  });

  test('loads templates and preselects the preferred one', () async {
    final cubit = SummaryCubit(facade);
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
    final cubit = SummaryCubit(facade);
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
    final cubit = SummaryCubit(facade);
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
    final cubit = SummaryCubit(facade);
    addTearDown(cubit.close);
    await cubit.start(meetingTranscript());
    final running = cubit.generate();
    expect(cubit.state.status, SummaryStatus.generating);
    cubit.delete();
    pending.complete(const Right(_summary));
    await running;
    expect(cubit.state.status, SummaryStatus.idle);
    expect(cubit.state.summary, isNull);
  });

  test('a failed star is undone', () async {
    when(() => facade.setFavorite('t2', favorite: true))
        .thenAnswer((_) async => const Left(Failure.network()));
    final cubit = SummaryCubit(facade);
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
      ),
    ).thenAnswer((_) async => const Right('n1'));
    final cubit = SummaryCubit(facade);
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
      ),
    ).called(1);
  });
}
