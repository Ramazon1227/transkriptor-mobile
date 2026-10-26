import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/api_config.dart';
import 'package:transkriptor_uz/core/network/app_log_interceptor.dart';
import 'package:transkriptor_uz/core/network/network_names.dart';
import 'package:transkriptor_uz/core/network/token_interceptor.dart';

/// The only place a [Dio] is constructed.
@module
abstract class NetworkModule {
  /// The shared instance every repository uses.
  @lazySingleton
  Dio dio(TokenInterceptor tokenInterceptor) => Dio(_options())
    ..interceptors.addAll([
      tokenInterceptor,
      if (kDebugMode) AppLogInterceptor(),
    ]);

  /// Retries and refresh only. Without [TokenInterceptor], so a 401 here
  /// can never trigger another refresh.
  @Named(NetworkNames.retryDio)
  @lazySingleton
  Dio retryDio() =>
      Dio(_options())
        ..interceptors.addAll([if (kDebugMode) AppLogInterceptor()]);

  /// Signed upload URLs are absolute, so no base URL; the send timeout is
  /// long because one PUT carries a whole recording. No log interceptor:
  /// the URL itself is the credential (a path token or an S3 signature).
  @Named(NetworkNames.uploadDio)
  @lazySingleton
  Dio uploadDio() => Dio(
    BaseOptions(
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      sendTimeout: ApiConfig.uploadSendTimeout,
    ),
  );

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  BaseOptions _options() => BaseOptions(
    // Empty only when analysed without --dart-define; then it equals the
    // default, but it is the configured value, not a redundant one.
    // ignore: avoid_redundant_argument_values
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: ApiConfig.connectTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    sendTimeout: ApiConfig.sendTimeout,
    contentType: Headers.jsonContentType,
  );
}
