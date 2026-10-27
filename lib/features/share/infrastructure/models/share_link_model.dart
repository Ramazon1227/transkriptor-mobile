import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/share/domain/entities/share_link.dart';

part 'share_link_model.freezed.dart';
part 'share_link_model.g.dart';

/// `models.ShareLink` in the backend. `token` is not read: `url` already
/// carries it, and nothing else in the app needs the raw token.
@freezed
abstract class ShareLinkModel with _$ShareLinkModel {
  const factory ShareLinkModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'view_count') @Default(0) int viewCount,
    @JsonKey(name: 'include_media') @Default(false) bool includeMedia,
    @JsonKey(name: 'url') String? url,
  }) = _ShareLinkModel;

  const ShareLinkModel._();

  factory ShareLinkModel.fromJson(Map<String, dynamic> json) =>
      _$ShareLinkModelFromJson(json);

  ShareLink toEntity() => ShareLink(
    id: id,
    createdAt: createdAt,
    expiresAt: expiresAt,
    viewCount: viewCount,
    includeMedia: includeMedia,
    url: (url?.isEmpty ?? true) ? null : url,
  );
}
