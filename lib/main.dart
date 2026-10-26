import 'package:flutter/widgets.dart';
import 'package:transkriptor_uz/app.dart';
import 'package:transkriptor_uz/core/constants/api_config.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/network/session_manager.dart';
import 'package:transkriptor_uz/core/storage/token_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (ApiConfig.baseUrl.isEmpty) {
    throw StateError(
      'API_BASE_URL is not set. Build with '
      '--dart-define=API_BASE_URL=https://<api host>',
    );
  }
  configureDependencies();

  final signedIn = await _hasSession();
  // No tokens: the router starts at login instead of flashing the home
  // screen and bouncing off its first 401.
  if (!signedIn) getIt<SessionManager>().expire();

  runApp(App(signedIn: signedIn));
}

Future<bool> _hasSession() async {
  try {
    final token = await getIt<TokenStorage>().readRefreshToken();
    return token != null && token.isNotEmpty;
  } on Object {
    // An unreadable keychain is treated as signed out.
    return false;
  }
}
