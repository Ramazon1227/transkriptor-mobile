// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'media_id') String get mediaId;@JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown) JobStatus get status;@JsonKey(name: 'progress') int get progress;@JsonKey(name: 'error_message') String? get errorMessage;@JsonKey(name: 'transcript_id') String? get transcriptId;@JsonKey(name: 'num_speakers') int? get numSpeakers;
/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobModelCopyWith<JobModel> get copyWith => _$JobModelCopyWithImpl<JobModel>(this as JobModel, _$identity);

  /// Serializes this JobModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as JobModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.transcriptId, _this.transcriptId) || other.transcriptId == _this.transcriptId)&&(identical(other.numSpeakers, _this.numSpeakers) || other.numSpeakers == _this.numSpeakers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as JobModel;
  return Object.hash(runtimeType,_this.id,_this.mediaId,_this.status,_this.progress,_this.errorMessage,_this.transcriptId,_this.numSpeakers);
}

@override
String toString() {
  final _this = this as JobModel;
  return 'JobModel(id: ${_this.id}, mediaId: ${_this.mediaId}, status: ${_this.status}, progress: ${_this.progress}, errorMessage: ${_this.errorMessage}, transcriptId: ${_this.transcriptId}, numSpeakers: ${_this.numSpeakers})';
}


}

/// @nodoc
abstract mixin class $JobModelCopyWith<$Res>  {
  factory $JobModelCopyWith(JobModel value, $Res Function(JobModel) _then) = _$JobModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'media_id') String mediaId,@JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown) JobStatus status,@JsonKey(name: 'progress') int progress,@JsonKey(name: 'error_message') String? errorMessage,@JsonKey(name: 'transcript_id') String? transcriptId,@JsonKey(name: 'num_speakers') int? numSpeakers
});




}
/// @nodoc
class _$JobModelCopyWithImpl<$Res>
    implements $JobModelCopyWith<$Res> {
  _$JobModelCopyWithImpl(this._self, this._then);

  final JobModel _self;
  final $Res Function(JobModel) _then;

/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mediaId = null,Object? status = null,Object? progress = null,Object? errorMessage = freezed,Object? transcriptId = freezed,Object? numSpeakers = freezed,}) {
  return _then(JobModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,numSpeakers: freezed == numSpeakers ? _self.numSpeakers : numSpeakers // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobModel].
extension JobModelPatterns on JobModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobModel value)  $default,){
final _that = this;
switch (_that) {
case _JobModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobModel value)?  $default,){
final _that = this;
switch (_that) {
case _JobModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'media_id')  String mediaId, @JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown)  JobStatus status, @JsonKey(name: 'progress')  int progress, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'transcript_id')  String? transcriptId, @JsonKey(name: 'num_speakers')  int? numSpeakers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.id,_that.mediaId,_that.status,_that.progress,_that.errorMessage,_that.transcriptId,_that.numSpeakers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'media_id')  String mediaId, @JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown)  JobStatus status, @JsonKey(name: 'progress')  int progress, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'transcript_id')  String? transcriptId, @JsonKey(name: 'num_speakers')  int? numSpeakers)  $default,) {final _that = this;
switch (_that) {
case _JobModel():
return $default(_that.id,_that.mediaId,_that.status,_that.progress,_that.errorMessage,_that.transcriptId,_that.numSpeakers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'media_id')  String mediaId, @JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown)  JobStatus status, @JsonKey(name: 'progress')  int progress, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'transcript_id')  String? transcriptId, @JsonKey(name: 'num_speakers')  int? numSpeakers)?  $default,) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.id,_that.mediaId,_that.status,_that.progress,_that.errorMessage,_that.transcriptId,_that.numSpeakers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobModel extends JobModel {
  const _JobModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'media_id') this.mediaId = '', @JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown) this.status = JobStatus.unknown, @JsonKey(name: 'progress') this.progress = 0, @JsonKey(name: 'error_message') this.errorMessage, @JsonKey(name: 'transcript_id') this.transcriptId, @JsonKey(name: 'num_speakers') this.numSpeakers}): super._();
  factory _JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'media_id') final  String mediaId;
@override@JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown) final  JobStatus status;
@override@JsonKey(name: 'progress') final  int progress;
@override@JsonKey(name: 'error_message') final  String? errorMessage;
@override@JsonKey(name: 'transcript_id') final  String? transcriptId;
@override@JsonKey(name: 'num_speakers') final  int? numSpeakers;

/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobModelCopyWith<_JobModel> get copyWith => __$JobModelCopyWithImpl<_JobModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.transcriptId, transcriptId) || other.transcriptId == transcriptId)&&(identical(other.numSpeakers, numSpeakers) || other.numSpeakers == numSpeakers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,mediaId,status,progress,errorMessage,transcriptId,numSpeakers);
}

@override
String toString() {
    return 'JobModel(id: $id, mediaId: $mediaId, status: $status, progress: $progress, errorMessage: $errorMessage, transcriptId: $transcriptId, numSpeakers: $numSpeakers)';
}


}

/// @nodoc
abstract mixin class _$JobModelCopyWith<$Res> implements $JobModelCopyWith<$Res> {
  factory _$JobModelCopyWith(_JobModel value, $Res Function(_JobModel) _then) = __$JobModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'media_id') String mediaId,@JsonKey(name: 'status', unknownEnumValue: JobStatus.unknown) JobStatus status,@JsonKey(name: 'progress') int progress,@JsonKey(name: 'error_message') String? errorMessage,@JsonKey(name: 'transcript_id') String? transcriptId,@JsonKey(name: 'num_speakers') int? numSpeakers
});




}
/// @nodoc
class __$JobModelCopyWithImpl<$Res>
    implements _$JobModelCopyWith<$Res> {
  __$JobModelCopyWithImpl(this._self, this._then);

  final _JobModel _self;
  final $Res Function(_JobModel) _then;

/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mediaId = null,Object? status = null,Object? progress = null,Object? errorMessage = freezed,Object? transcriptId = freezed,Object? numSpeakers = freezed,}) {
  return _then(_JobModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,numSpeakers: freezed == numSpeakers ? _self.numSpeakers : numSpeakers // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
