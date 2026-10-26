// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibraryItemModel {

@JsonKey(name: 'media_id') String get mediaId;@JsonKey(name: 'name') String get name;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'duration_ms') int? get durationMs;@JsonKey(name: 'kind', unknownEnumValue: MediaKind.unknown) MediaKind get kind;@JsonKey(name: 'source', unknownEnumValue: MediaSource.unknown) MediaSource get source;@JsonKey(name: 'link_provider') String? get linkProvider;@JsonKey(name: 'job_id') String? get jobId;/// Empty string when there is no job; read as null.
@JsonKey(name: 'job_status') String? get jobStatus;@JsonKey(name: 'transcript_id') String? get transcriptId;@JsonKey(name: 'tags') List<String> get tags;
/// Create a copy of LibraryItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryItemModelCopyWith<LibraryItemModel> get copyWith => _$LibraryItemModelCopyWithImpl<LibraryItemModel>(this as LibraryItemModel, _$identity);

  /// Serializes this LibraryItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LibraryItemModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryItemModel&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.linkProvider, _this.linkProvider) || other.linkProvider == _this.linkProvider)&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.jobStatus, _this.jobStatus) || other.jobStatus == _this.jobStatus)&&(identical(other.transcriptId, _this.transcriptId) || other.transcriptId == _this.transcriptId)&&const DeepCollectionEquality().equals(other.tags, _this.tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LibraryItemModel;
  return Object.hash(runtimeType,_this.mediaId,_this.name,_this.createdAt,_this.durationMs,_this.kind,_this.source,_this.linkProvider,_this.jobId,_this.jobStatus,_this.transcriptId,const DeepCollectionEquality().hash(_this.tags));
}

@override
String toString() {
  final _this = this as LibraryItemModel;
  return 'LibraryItemModel(mediaId: ${_this.mediaId}, name: ${_this.name}, createdAt: ${_this.createdAt}, durationMs: ${_this.durationMs}, kind: ${_this.kind}, source: ${_this.source}, linkProvider: ${_this.linkProvider}, jobId: ${_this.jobId}, jobStatus: ${_this.jobStatus}, transcriptId: ${_this.transcriptId}, tags: ${_this.tags})';
}


}

/// @nodoc
abstract mixin class $LibraryItemModelCopyWith<$Res>  {
  factory $LibraryItemModelCopyWith(LibraryItemModel value, $Res Function(LibraryItemModel) _then) = _$LibraryItemModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'media_id') String mediaId,@JsonKey(name: 'name') String name,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'duration_ms') int? durationMs,@JsonKey(name: 'kind', unknownEnumValue: MediaKind.unknown) MediaKind kind,@JsonKey(name: 'source', unknownEnumValue: MediaSource.unknown) MediaSource source,@JsonKey(name: 'link_provider') String? linkProvider,@JsonKey(name: 'job_id') String? jobId,@JsonKey(name: 'job_status') String? jobStatus,@JsonKey(name: 'transcript_id') String? transcriptId,@JsonKey(name: 'tags') List<String> tags
});




}
/// @nodoc
class _$LibraryItemModelCopyWithImpl<$Res>
    implements $LibraryItemModelCopyWith<$Res> {
  _$LibraryItemModelCopyWithImpl(this._self, this._then);

  final LibraryItemModel _self;
  final $Res Function(LibraryItemModel) _then;

/// Create a copy of LibraryItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaId = null,Object? name = null,Object? createdAt = freezed,Object? durationMs = freezed,Object? kind = null,Object? source = null,Object? linkProvider = freezed,Object? jobId = freezed,Object? jobStatus = freezed,Object? transcriptId = freezed,Object? tags = null,}) {
  return _then(LibraryItemModel(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MediaKind,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as MediaSource,linkProvider: freezed == linkProvider ? _self.linkProvider : linkProvider // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,jobStatus: freezed == jobStatus ? _self.jobStatus : jobStatus // ignore: cast_nullable_to_non_nullable
as String?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [LibraryItemModel].
extension LibraryItemModelPatterns on LibraryItemModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryItemModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryItemModel value)  $default,){
final _that = this;
switch (_that) {
case _LibraryItemModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryItemModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'media_id')  String mediaId, @JsonKey(name: 'name')  String name, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'duration_ms')  int? durationMs, @JsonKey(name: 'kind', unknownEnumValue: MediaKind.unknown)  MediaKind kind, @JsonKey(name: 'source', unknownEnumValue: MediaSource.unknown)  MediaSource source, @JsonKey(name: 'link_provider')  String? linkProvider, @JsonKey(name: 'job_id')  String? jobId, @JsonKey(name: 'job_status')  String? jobStatus, @JsonKey(name: 'transcript_id')  String? transcriptId, @JsonKey(name: 'tags')  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryItemModel() when $default != null:
return $default(_that.mediaId,_that.name,_that.createdAt,_that.durationMs,_that.kind,_that.source,_that.linkProvider,_that.jobId,_that.jobStatus,_that.transcriptId,_that.tags);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'media_id')  String mediaId, @JsonKey(name: 'name')  String name, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'duration_ms')  int? durationMs, @JsonKey(name: 'kind', unknownEnumValue: MediaKind.unknown)  MediaKind kind, @JsonKey(name: 'source', unknownEnumValue: MediaSource.unknown)  MediaSource source, @JsonKey(name: 'link_provider')  String? linkProvider, @JsonKey(name: 'job_id')  String? jobId, @JsonKey(name: 'job_status')  String? jobStatus, @JsonKey(name: 'transcript_id')  String? transcriptId, @JsonKey(name: 'tags')  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _LibraryItemModel():
return $default(_that.mediaId,_that.name,_that.createdAt,_that.durationMs,_that.kind,_that.source,_that.linkProvider,_that.jobId,_that.jobStatus,_that.transcriptId,_that.tags);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'media_id')  String mediaId, @JsonKey(name: 'name')  String name, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'duration_ms')  int? durationMs, @JsonKey(name: 'kind', unknownEnumValue: MediaKind.unknown)  MediaKind kind, @JsonKey(name: 'source', unknownEnumValue: MediaSource.unknown)  MediaSource source, @JsonKey(name: 'link_provider')  String? linkProvider, @JsonKey(name: 'job_id')  String? jobId, @JsonKey(name: 'job_status')  String? jobStatus, @JsonKey(name: 'transcript_id')  String? transcriptId, @JsonKey(name: 'tags')  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _LibraryItemModel() when $default != null:
return $default(_that.mediaId,_that.name,_that.createdAt,_that.durationMs,_that.kind,_that.source,_that.linkProvider,_that.jobId,_that.jobStatus,_that.transcriptId,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LibraryItemModel extends LibraryItemModel {
  const _LibraryItemModel({@JsonKey(name: 'media_id') this.mediaId = '', @JsonKey(name: 'name') this.name = '', @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'duration_ms') this.durationMs, @JsonKey(name: 'kind', unknownEnumValue: MediaKind.unknown) this.kind = MediaKind.unknown, @JsonKey(name: 'source', unknownEnumValue: MediaSource.unknown) this.source = MediaSource.unknown, @JsonKey(name: 'link_provider') this.linkProvider, @JsonKey(name: 'job_id') this.jobId, @JsonKey(name: 'job_status') this.jobStatus, @JsonKey(name: 'transcript_id') this.transcriptId, @JsonKey(name: 'tags')  List<String> tags = const <String>[]}): _tags = tags,super._();
  factory _LibraryItemModel.fromJson(Map<String, dynamic> json) => _$LibraryItemModelFromJson(json);

@override@JsonKey(name: 'media_id') final  String mediaId;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'duration_ms') final  int? durationMs;
@override@JsonKey(name: 'kind', unknownEnumValue: MediaKind.unknown) final  MediaKind kind;
@override@JsonKey(name: 'source', unknownEnumValue: MediaSource.unknown) final  MediaSource source;
@override@JsonKey(name: 'link_provider') final  String? linkProvider;
@override@JsonKey(name: 'job_id') final  String? jobId;
/// Empty string when there is no job; read as null.
@override@JsonKey(name: 'job_status') final  String? jobStatus;
@override@JsonKey(name: 'transcript_id') final  String? transcriptId;
 final  List<String> _tags;
@override@JsonKey(name: 'tags') List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of LibraryItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryItemModelCopyWith<_LibraryItemModel> get copyWith => __$LibraryItemModelCopyWithImpl<_LibraryItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LibraryItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryItemModel&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.source, source) || other.source == source)&&(identical(other.linkProvider, linkProvider) || other.linkProvider == linkProvider)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.jobStatus, jobStatus) || other.jobStatus == jobStatus)&&(identical(other.transcriptId, transcriptId) || other.transcriptId == transcriptId)&&const DeepCollectionEquality().equals(other.tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,mediaId,name,createdAt,durationMs,kind,source,linkProvider,jobId,jobStatus,transcriptId,const DeepCollectionEquality().hash(_tags));
}

@override
String toString() {
    return 'LibraryItemModel(mediaId: $mediaId, name: $name, createdAt: $createdAt, durationMs: $durationMs, kind: $kind, source: $source, linkProvider: $linkProvider, jobId: $jobId, jobStatus: $jobStatus, transcriptId: $transcriptId, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$LibraryItemModelCopyWith<$Res> implements $LibraryItemModelCopyWith<$Res> {
  factory _$LibraryItemModelCopyWith(_LibraryItemModel value, $Res Function(_LibraryItemModel) _then) = __$LibraryItemModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'media_id') String mediaId,@JsonKey(name: 'name') String name,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'duration_ms') int? durationMs,@JsonKey(name: 'kind', unknownEnumValue: MediaKind.unknown) MediaKind kind,@JsonKey(name: 'source', unknownEnumValue: MediaSource.unknown) MediaSource source,@JsonKey(name: 'link_provider') String? linkProvider,@JsonKey(name: 'job_id') String? jobId,@JsonKey(name: 'job_status') String? jobStatus,@JsonKey(name: 'transcript_id') String? transcriptId,@JsonKey(name: 'tags') List<String> tags
});




}
/// @nodoc
class __$LibraryItemModelCopyWithImpl<$Res>
    implements _$LibraryItemModelCopyWith<$Res> {
  __$LibraryItemModelCopyWithImpl(this._self, this._then);

  final _LibraryItemModel _self;
  final $Res Function(_LibraryItemModel) _then;

/// Create a copy of LibraryItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaId = null,Object? name = null,Object? createdAt = freezed,Object? durationMs = freezed,Object? kind = null,Object? source = null,Object? linkProvider = freezed,Object? jobId = freezed,Object? jobStatus = freezed,Object? transcriptId = freezed,Object? tags = null,}) {
  return _then(_LibraryItemModel(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MediaKind,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as MediaSource,linkProvider: freezed == linkProvider ? _self.linkProvider : linkProvider // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,jobStatus: freezed == jobStatus ? _self.jobStatus : jobStatus // ignore: cast_nullable_to_non_nullable
as String?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
