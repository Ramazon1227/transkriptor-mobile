import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/features/capture/application/url_import_cubit.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/url_import_result.dart';
import 'package:transkriptor_uz/features/capture/domain/i_url_import_facade.dart';
import 'package:transkriptor_uz/features/capture/domain/url_check.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/demo/demo_url_import_repository.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/facades/url_import_facade.dart';

class _MockFacade extends Mock implements IUrlImportFacade;

void main() {
  group('classifyUrl', () {
    test('http(s) with a host is a direct link', () {
      expect(classifyUrl('https://example.uz/a.mp3'), UrlKind.direct);
      expect(classifyUrl(' http://10.0.0.5:8000/x.m4a '), UrlKind.direct);
    });

    test('YouTube, Drive and Dropbox go to the link flow', () {
      for (final url in [
        'https://www.youtube.com/watch?v=jNQXAC9IVRw',
        'https://youtu.be/jNQXAC9IVRw',
        'https://drive.google.com/file/d/abc/view',
        'https://www.dropbox.com/s/k/a.mp3',
      ]) {
        expect(classifyUrl(url), UrlKind.platform, reason: url);
      }
    });

    test('no scheme, another scheme or no host is invalid', () {
      for (final url in [
        '',
        'example.uz/a.mp3',
        'ftp://example.uz/a.mp3',
        'file:///sdcard/a.mp3',
        'https://',
        'javascript:alert(1)',
      ]) {
        expect(classifyUrl(url), UrlKind.invalid, reason: url);
      }
    });
  });

  group('UrlImportCubit', () {
    late _MockFacade facade;

    setUp(() {
      facade = _MockFacade();
      when(
        () => facade.importUrl(
          url: any(named: 'url'),
          workspaceId: any(named: 'workspaceId'),
        ),
      ).thenAnswer((_) async => const Right(UrlImportResult.notAvailable()));
    });

    blocTest<UrlImportCubit, UrlImportState>(
      'a YouTube link is handed to the link flow, nothing is sent',
      build: () => UrlImportCubit(facade),
      act: (c) =>
          c.submit(url: ' https://youtu.be/jNQXAC9IVRw ', workspaceId: 'w1'),
      expect: () => const [
        UrlImportState(platformUrl: 'https://youtu.be/jNQXAC9IVRw'),
      ],
      verify: (_) => verifyNever(
        () => facade.importUrl(
          url: any(named: 'url'),
          workspaceId: any(named: 'workspaceId'),
        ),
      ),
    );

    blocTest<UrlImportCubit, UrlImportState>(
      'an invalid URL says so',
      build: () => UrlImportCubit(facade),
      act: (c) => c.submit(url: 'example.uz/a.mp3', workspaceId: 'w1'),
      expect: () => const [UrlImportState(urlInvalid: true)],
    );

    blocTest<UrlImportCubit, UrlImportState>(
      'a direct link meets "not available yet"',
      build: () => UrlImportCubit(facade),
      act: (c) => c.submit(url: 'https://example.uz/a.mp3', workspaceId: 'w1'),
      expect: () => const [
        UrlImportState(status: UrlImportStatus.loading),
        UrlImportState(status: UrlImportStatus.notAvailable),
      ],
    );
  });

  test('the demo source answers "not available" and nothing else', () async {
    final facade = UrlImportFacade(DemoUrlImportRepository());
    final result = await facade.importUrl(
      url: 'https://example.uz/a.mp3',
      workspaceId: 'w1',
    );
    expect(
      result,
      const Right<Object, UrlImportResult>(UrlImportResult.notAvailable()),
    );
  });
}
