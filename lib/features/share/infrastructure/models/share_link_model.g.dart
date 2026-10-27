// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShareLinkModel _$ShareLinkModelFromJson(Map<String, dynamic> json) =>
    _ShareLinkModel(
      id: json['id'] as String? ?? '',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
      includeMedia: json['include_media'] as bool? ?? false,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ShareLinkModelToJson(_ShareLinkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'view_count': instance.viewCount,
      'include_media': instance.includeMedia,
      'url': instance.url,
    };
