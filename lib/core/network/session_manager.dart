import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Tells the router that the session is gone, without the network layer
/// ever holding a `BuildContext`.
///
/// [isExpired] is the navigate-to-login flag: it flips once, so a burst of
/// failing requests produces one redirect, not one per request. The login
/// feature must call [markAuthenticated] after a successful login, or the
/// next expiry would not redirect again.
@lazySingleton
class SessionManager extends ChangeNotifier {
  bool _expired = false;

  bool get isExpired => _expired;

  void expire() {
    if (_expired) return;
    _expired = true;
    notifyListeners();
  }

  void markAuthenticated() {
    if (!_expired) return;
    _expired = false;
    notifyListeners();
  }
}
