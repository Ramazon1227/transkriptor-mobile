import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_link.freezed.dart';

/// A public read link to one transcript.
@freezed
abstract class ShareLink with _$ShareLink {
  const factory ShareLink({
    required String id,
    DateTime? createdAt,

    /// Null: the link never expires.
    DateTime? expiresAt,
    @Default(0) int viewCount,
    @Default(false) bool includeMedia,

    /// `PUBLIC_APP_URL/s/<token>`. Only on the link just created: the
    /// server keeps a hash of the token and never shows it again.
    String? url,
  }) = _ShareLink;
}
