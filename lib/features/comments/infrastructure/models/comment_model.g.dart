// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      id: json['id'] as String? ?? '',
      segmentId: json['segment_id'] as String? ?? '',
      authorId: json['author_id'] as String?,
      authorName: json['author_name'] as String? ?? '',
      body: json['body'] as String? ?? '',
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$CommentModelToJson(_CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'segment_id': instance.segmentId,
      'author_id': instance.authorId,
      'author_name': instance.authorName,
      'body': instance.body,
      'created_at': instance.createdAt,
    };

_CommentListModel _$CommentListModelFromJson(Map<String, dynamic> json) =>
    _CommentListModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CommentModel>[],
    );

Map<String, dynamic> _$CommentListModelToJson(_CommentListModel instance) =>
    <String, dynamic>{'items': instance.items};

_CommentEnvelopeModel _$CommentEnvelopeModelFromJson(
  Map<String, dynamic> json,
) => _CommentEnvelopeModel(
  comment: CommentModel.fromJson(json['comment'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentEnvelopeModelToJson(
  _CommentEnvelopeModel instance,
) => <String, dynamic>{'comment': instance.comment};
