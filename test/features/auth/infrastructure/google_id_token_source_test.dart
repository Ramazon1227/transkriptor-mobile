import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/utils/device_platform.dart';
import 'package:transkriptor_uz/features/auth/infrastructure/services/google_id_token_source.dart';

class _MockGoogle extends Mock implements GoogleSignIn;

class _Platform extends Mock implements DevicePlatform;

void main() {
  late _MockGoogle google;
  late _Platform platform;

  setUp(() {
    google = _MockGoogle();
    platform = _Platform();
    when(
      () => google.initialize(
        clientId: any(named: 'clientId'),
        serverClientId: any(named: 'serverClientId'),
      ),
    ).thenAnswer((_) async {});
    when(() => google.authenticate()).thenThrow(
      const GoogleSignInException(code: GoogleSignInExceptionCode.canceled),
    );
  });

  test('Android: always available, no client id of its own', () async {
    when(() => platform.isIOS).thenReturn(false);
    final source = GoogleIdTokenSource.withIosClientId(google, platform, '');
    expect(source.isAvailable, isTrue);

    expect(await source.idToken('web-id'), isNull);
    verify(() => google.initialize(serverClientId: 'web-id')).called(1);
  });

  test('iOS without its client id: not offered', () {
    when(() => platform.isIOS).thenReturn(true);
    final source = GoogleIdTokenSource.withIosClientId(google, platform, '');
    expect(source.isAvailable, isFalse);
  });

  test('iOS with its client id: passed to the SDK', () async {
    when(() => platform.isIOS).thenReturn(true);
    final source = GoogleIdTokenSource.withIosClientId(
      google,
      platform,
      'ios-id',
    );
    expect(source.isAvailable, isTrue);

    await source.idToken('web-id');
    verify(
      () => google.initialize(clientId: 'ios-id', serverClientId: 'web-id'),
    ).called(1);
  });
}
