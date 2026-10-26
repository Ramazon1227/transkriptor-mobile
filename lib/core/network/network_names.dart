/// `@Named` keys for network instances registered in DI.
abstract final class NetworkNames {
  /// Dio without `TokenInterceptor`, used only for retries and refresh.
  static const String retryDio = 'retryDio';

  /// Dio for signed upload URLs. No base URL and no `Authorization`
  /// header: the URL carries its own authority, and an extra header breaks
  /// an S3 pre-signed signature.
  static const String uploadDio = 'uploadDio';
}
