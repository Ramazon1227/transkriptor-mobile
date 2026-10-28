import 'package:flutter/services.dart' show AssetBundle, rootBundle;
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

@module
abstract class ShareModule {
  @lazySingleton
  SharePlus get sharePlus => SharePlus.instance;

  /// The app's bundled files — the PDF fonts.
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;
}
