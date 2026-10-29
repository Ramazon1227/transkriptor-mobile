import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/utils/device_platform.dart';
import 'package:transkriptor_uz/features/links/application/links_cubit.dart';
import 'package:transkriptor_uz/features/links/infrastructure/facades/links_facade.dart';
import 'package:transkriptor_uz/features/links/infrastructure/launcher/url_opener.dart';

class _Opener extends Mock implements UrlOpener;

class _Platform extends Mock implements DevicePlatform;

void main() {
  late _Opener opener;
  late _Platform platform;
  late LinksFacade facade;

  setUpAll(() => registerFallbackValue(Uri()));

  setUp(() {
    opener = _Opener();
    platform = _Platform();
    when(() => platform.isIOS).thenReturn(false);
    when(() => opener.open(any())).thenAnswer((_) async => true);
    facade = LinksFacade(opener, platform);
  });

  test('a web page goes to the opener as is', () async {
    expect(
      (await facade.open('https://app.test/xavfsizlik')).isRight(),
      isTrue,
    );
    verify(() => opener.open(Uri.parse('https://app.test/xavfsizlik')))
        .called(1);
  });

  test('nothing opened it, or the system threw: Left', () async {
    when(() => opener.open(any())).thenAnswer((_) async => false);
    expect((await facade.open('https://app.test')).isLeft(), isTrue);
    when(() => opener.open(any())).thenThrow(PlatformException(code: 'x'));
    expect((await facade.open('https://app.test')).isLeft(), isTrue);
  });

  test('anything but an http(s) page is never launched', () async {
    for (final url in ['', 'tel:123', 'intent://x', 'file:///etc', 'https:']) {
      expect((await facade.open(url)).isLeft(), isTrue, reason: url);
    }
    verifyNever(() => opener.open(any()));
  });

  test('Android: app settings are not offered', () async {
    expect(facade.canOpenAppSettings, isFalse);
    expect((await facade.openAppSettings()).isLeft(), isTrue);
    verifyNever(() => opener.open(any()));
  });

  test('iOS: app settings open through app-settings:', () async {
    when(() => platform.isIOS).thenReturn(true);
    expect(facade.canOpenAppSettings, isTrue);
    expect((await facade.openAppSettings()).isRight(), isTrue);
    verify(() => opener.open(Uri.parse('app-settings:'))).called(1);
  });

  test('the cubit answers true/false and carries the iOS flag', () async {
    when(() => platform.isIOS).thenReturn(true);
    final cubit = LinksCubit(facade);
    addTearDown(cubit.close);
    expect(cubit.state.canOpenAppSettings, isTrue);
    expect(await cubit.open('https://app.test'), isTrue);
    when(() => opener.open(any())).thenAnswer((_) async => false);
    expect(await cubit.open('https://app.test'), isFalse);
    expect(await cubit.openAppSettings(), isFalse);
  });
}
