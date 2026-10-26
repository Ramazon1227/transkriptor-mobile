import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/api_config.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/network/models/token_pair.dart';
import 'package:transkriptor_uz/core/network/network_names.dart';
import 'package:transkriptor_uz/core/network/session_manager.dart';
import 'package:transkriptor_uz/core/storage/token_storage.dart';

/// Attaches the access token and recovers from a 401 with one refresh.
///
/// The backend rotates refresh tokens and treats reuse of an old one as
/// theft — it revokes every session of that user. So refreshes must never
/// overlap: one [Completer] is shared by every request that hit 401 while
/// a refresh was in flight.
@lazySingleton
class TokenInterceptor extends Interceptor {
  TokenInterceptor(
    this._storage,
    this._session,
    @Named(NetworkNames.retryDio) this._retryDio,
  );

  final TokenStorage _storage;
  final SessionManager _session;

  /// Has no [TokenInterceptor], so a retry or refresh that fails with 401
  /// cannot start another refresh.
  final Dio _retryDio;

  Completer<String?>? _refreshing;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers[_authHeader] = _bearer(token);
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    if (err.response?.statusCode != 401) return handler.next(err);

    // A 401 from login is a wrong password, not an expired session.
    if (options.path == Endpoints.authLogin) return handler.next(err);

    if (options.path == Endpoints.authRefresh) {
      await _logout();
      return handler.next(err);
    }

    final newToken = await _freshAccessToken(sentWith: options.headers);
    if (newToken == null) return handler.next(err);

    try {
      final retry = options.copyWith(
        headers: {...options.headers, _authHeader: _bearer(newToken)},
      );
      handler.resolve(await _retryDio.fetch<dynamic>(retry));
    } on DioException catch (e) {
      handler.reject(e);
    }
  }

  /// Returns a token newer than the one the failed request carried, or
  /// null when there is none to be had.
  Future<String?> _freshAccessToken({
    required Map<String, dynamic> sentWith,
  }) async {
    // Another request already refreshed while this one was in flight.
    final stored = await _storage.readAccessToken();
    if (stored != null &&
        stored.isNotEmpty &&
        _bearer(stored) != sentWith[_authHeader]) {
      return stored;
    }
    return await _refreshOnce();
  }

  Future<String?> _refreshOnce() async {
    final inFlight = _refreshing;
    if (inFlight != null) return await inFlight.future;

    final completer = Completer<String?>();
    _refreshing = completer;
    String? token;
    try {
      token = await _refresh().timeout(ApiConfig.refreshTimeout);
    } on DioException catch (e) {
      // A 401 from refresh means the session is over. A network error does
      // not: the refresh token may still be valid, so keep it.
      if (e.response?.statusCode == 401) await _logout();
    } on Object {
      // Timeout, a mis-shaped body, a storage error. Never let it escape:
      // every request waiting on [completer] would hang.
      token = null;
    } finally {
      completer.complete(token);
      _refreshing = null;
    }
    return token;
  }

  /// Null when there is no refresh token to use.
  Future<String?> _refresh() async {
    final refreshToken = await _storage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _logout();
      return null;
    }

    final response = await _retryDio.post<Map<String, dynamic>>(
      Endpoints.authRefresh,
      data: {'refresh_token': refreshToken},
    );
    final data = response.data?['data'];
    if (data is! Map<String, dynamic>) return null;

    final pair = TokenPair.fromJson(data);
    if (pair.accessToken.isEmpty || pair.refreshToken.isEmpty) return null;

    await _storage.save(
      accessToken: pair.accessToken,
      refreshToken: pair.refreshToken,
    );
    return pair.accessToken;
  }

  Future<void> _logout() async {
    try {
      await _storage.clear();
    } finally {
      _session.expire();
    }
  }

  static const _authHeader = 'Authorization';

  static String _bearer(String token) => 'Bearer $token';
}
