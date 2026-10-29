/// The app's version as the build gave it. `flutter build` and
/// `flutter run` pass `FLUTTER_BUILD_NAME` / `FLUTTER_BUILD_NUMBER` (from
/// pubspec's `version`) as dart-defines, so no package is needed.
abstract final class AppInfo {
  static const String _name = String.fromEnvironment('FLUTTER_BUILD_NAME');
  static const String _number = String.fromEnvironment('FLUTTER_BUILD_NUMBER');

  /// `0.1.0 (1)`, or empty when the defines are missing (tests).
  static String get version {
    if (_name.isEmpty) return '';
    return _number.isEmpty ? _name : '$_name ($_number)';
  }
}
