import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';

abstract interface class ILinksFacade {
  /// Opens [url] outside the app: the browser, or the app that owns the
  /// link (YouTube). Left when nothing on the phone opened it — the
  /// caller then offers the link to copy.
  Future<Either<Failure, Unit>> open(String url);

  /// True where an app may open its own page in the phone's settings
  /// (iOS). Android needs a native intent for that, so there the pages
  /// keep their written guidance.
  bool get canOpenAppSettings;

  /// The app's page in the phone's settings (permissions). Left when it
  /// is not available here or the system refused.
  Future<Either<Failure, Unit>> openAppSettings();
}
