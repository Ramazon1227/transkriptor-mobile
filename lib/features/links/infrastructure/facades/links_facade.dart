import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/system_links.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/utils/device_platform.dart';
import 'package:transkriptor_uz/features/links/domain/i_links_facade.dart';
import 'package:transkriptor_uz/features/links/infrastructure/launcher/url_opener.dart';

@LazySingleton(as: ILinksFacade)
class LinksFacade implements ILinksFacade {
  LinksFacade(this._opener, this._platform);

  final UrlOpener _opener;
  final DevicePlatform _platform;

  @override
  Future<Either<Failure, Unit>> open(String url) {
    final uri = Uri.tryParse(url.trim());
    // Only web pages: a link from the server is never run as anything
    // else (tel:, intent:, file:).
    if (uri == null ||
        !(uri.isScheme('https') || uri.isScheme('http')) ||
        uri.host.isEmpty) {
      return Future.value(const Left(Failure.unknown()));
    }
    return _launch(uri);
  }

  @override
  bool get canOpenAppSettings => _platform.isIOS;

  @override
  Future<Either<Failure, Unit>> openAppSettings() {
    if (!canOpenAppSettings) {
      return Future.value(const Left(Failure.unknown()));
    }
    return _launch(Uri.parse(SystemLinks.iosAppSettings));
  }

  Future<Either<Failure, Unit>> _launch(Uri uri) async {
    try {
      return await _opener.open(uri)
          ? const Right(unit)
          : const Left(Failure.unknown());
    } on Object {
      // PlatformException when no app takes the link.
      return const Left(Failure.unknown());
    }
  }
}
