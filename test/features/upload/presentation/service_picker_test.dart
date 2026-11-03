import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_service.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/service_picker.dart';

void main() {
  Future<void> pump(
    WidgetTester tester,
    JobService value,
    ValueChanged<JobService> onChanged, {
    bool enabled = true,
  }) => tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ServicePicker(
          value: value,
          onChanged: onChanged,
          enabled: enabled,
        ),
      ),
    ),
  );

  testWidgets('picks subtitle and explains the frame size (S-1)', (
    tester,
  ) async {
    JobService? picked;
    await pump(tester, JobService.transcription, (s) => picked = s);
    expect(find.text('Transkripsiya'), findsOneWidget);
    expect(find.textContaining('2 satr × 42 belgi'), findsNothing);

    await tester.tap(find.text('Subtitr'));
    expect(picked, JobService.subtitle);

    await pump(tester, JobService.subtitle, (_) {});
    expect(find.textContaining('2 satr × 42 belgi'), findsOneWidget);
  });

  testWidgets('does nothing while disabled', (tester) async {
    JobService? picked;
    await pump(
      tester,
      JobService.transcription,
      (s) => picked = s,
      enabled: false,
    );
    await tester.tap(find.text('Subtitr'));
    expect(picked, isNull);
  });

  test('sends the backend names', () {
    expect(JobService.transcription.apiValue, 'TRANSCRIPTION');
    expect(JobService.subtitle.apiValue, 'SUBTITLE');
  });
}
