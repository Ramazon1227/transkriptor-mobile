// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MediaUrlModel _$MediaUrlModelFromJson(Map<String, dynamic> json) =>
    _MediaUrlModel(
      url: json['url'] as String? ?? '',
      mime: json['mime'] as String? ?? '',
      youtubeId: json['youtube_id'] as String?,
    );

Map<String, dynamic> _$MediaUrlModelToJson(_MediaUrlModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'mime': instance.mime,
      'youtube_id': instance.youtubeId,
    };
