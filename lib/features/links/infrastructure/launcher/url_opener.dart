import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

/// The one place `url_launcher` is called. True when something opened
/// the address.
abstract interface class UrlOpener {
  Future<bool> open(Uri uri);
}

@LazySingleton(as: UrlOpener)
class LauncherUrlOpener implements UrlOpener {
  /// External application: the browser or the app that handles the link
  /// (YouTube links open the YouTube app when it is installed), never an
  /// in-app web view. No `canLaunchUrl` first — on Android 11+ it needs
  /// `<queries>` in the manifest, and `launchUrl` answers the same
  /// question by its result.
  @override
  Future<bool> open(Uri uri) =>
      launchUrl(uri, mode: LaunchMode.externalApplication);
}
