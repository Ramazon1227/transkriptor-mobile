import 'package:transkriptor_uz/features/upload/application/upload_bloc.dart'
    show isSupportedLink;

/// What a URL typed on «Havola orqali» is.
enum UrlKind {
  /// Not http(s), or no host.
  invalid,

  /// YouTube, Google Drive or Dropbox: the existing link flow takes it.
  platform,

  /// Any other web address: a direct audio or video file.
  direct,
}

UrlKind classifyUrl(String raw) {
  final url = raw.trim();
  final uri = Uri.tryParse(url);
  if (uri == null ||
      !(uri.scheme == 'https' || uri.scheme == 'http') ||
      uri.host.isEmpty) {
    return UrlKind.invalid;
  }
  return isSupportedLink(url) ? UrlKind.platform : UrlKind.direct;
}
