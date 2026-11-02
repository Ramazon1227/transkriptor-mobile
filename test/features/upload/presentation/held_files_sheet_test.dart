import 'package:dartz/dartz.dart' show Right, unit;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/error/held_file.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/upload/application/held_files_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';
import 'package:transkriptor_uz/features/upload/presentation/widgets/held_files_sheet.dart';

class _MockFacade extends Mock implements IUploadFacade;

const _failed = HeldFile(
  id: 'a',
  name: 'yiqilgan.mp3',
  state: HeldFileState.failed,
  sizeBytes: 2048,
  deletable: true,
);
const _live = HeldFile(
  id: 'b',
  name: 'yozuv.webm',
  state: HeldFileState.unconfirmed,
  sizeBytes: 0,
);

void main() {
  late _MockFacade facade;

  setUp(() {
    facade = _MockFacade();
    getIt.registerFactory<HeldFilesCubit>(() => HeldFilesCubit(facade));
  });
  tearDown(() => getIt.unregister<HeldFilesCubit>());

  Future<void> pump(WidgetTester tester, Failure? failure) => tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: HeldFilesButton(failure: failure)),
    ),
  );

  testWidgets('nothing for other failures or an empty list', (tester) async {
    await pump(tester, const Failure.network());
    expect(find.byKey(const Key('held_files_show')), findsNothing);
    await pump(tester, const Failure.pendingLimit());
    expect(find.byKey(const Key('held_files_show')), findsNothing);
  });

  testWidgets('lists the files and deletes one after asking', (tester) async {
    when(() => facade.deleteHeld('a'))
        .thenAnswer((_) async => const Right(unit));
    await pump(tester, const Failure.pendingLimit(held: [_failed, _live]));
    await tester.tap(find.byKey(const Key('held_files_show')));
    await tester.pumpAndSettle();

    expect(find.text('yiqilgan.mp3'), findsOneWidget);
    expect(find.text('yozuv.webm'), findsOneWidget);
    // A running recording cannot be deleted from here.
    expect(find.byKey(const Key('held_delete_b')), findsNothing);

    await tester.tap(find.byKey(const Key('held_delete_a')));
    await tester.pumpAndSettle();
    verifyNever(() => facade.deleteHeld('a'));
    await tester.tap(find.byKey(const Key('confirm_sheet_confirm')));
    await tester.pumpAndSettle();

    verify(() => facade.deleteHeld('a')).called(1);
    expect(find.text('yiqilgan.mp3'), findsNothing);
    expect(find.text('yozuv.webm'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
