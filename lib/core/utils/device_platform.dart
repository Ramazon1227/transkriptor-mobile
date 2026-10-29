import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:injectable/injectable.dart';

/// Which phone the app runs on, for the few places where Android and iOS
/// take different paths (native channels that exist only on Android,
/// recording format, opening the app's settings page). Injected, so tests
/// pick a platform without overriding globals.
@lazySingleton
class DevicePlatform {
  bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
}
