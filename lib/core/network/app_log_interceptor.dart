import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Debug-only request log. Prints method, path and status — never headers
/// or bodies, because those carry tokens (Authorization, refresh body).
class AppLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) debugPrint('→ ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      final o = response.requestOptions;
      debugPrint('← ${response.statusCode} ${o.method} ${o.path}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      final o = err.requestOptions;
      final status = err.response?.statusCode ?? err.type.name;
      debugPrint('✕ $status ${o.method} ${o.path}');
    }
    handler.next(err);
  }
}
