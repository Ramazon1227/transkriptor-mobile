// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_bot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingBotModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'meet_url') String get meetUrl;@JsonKey(name: 'status', unknownEnumValue: MeetingBotStatus.unknown) MeetingBotStatus get status;@JsonKey(name: 'error_code') String? get errorCode;@JsonKey(name: 'error_message') String? get errorMessage;@JsonKey(name: 'cancel_requested') bool get cancelRequested;@JsonKey(name: 'bot_name') String get botName;@JsonKey(name: 'media_id') String? get mediaId;@JsonKey(name: 'job_id') String? get jobId;@JsonKey(name: 'meeting_title') String? get meetingTitle;@JsonKey(name: 'keep_video') bool get keepVideo;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of MeetingBotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingBotModelCopyWith<MeetingBotModel> get copyWith => _$MeetingBotModelCopyWithImpl<MeetingBotModel>(this as MeetingBotModel, _$identity);

  /// Serializes this MeetingBotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeetingBotModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingBotModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.meetUrl, _this.meetUrl) || other.meetUrl == _this.meetUrl)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.cancelRequested, _this.cancelRequested) || other.cancelRequested == _this.cancelRequested)&&(identical(other.botName, _this.botName) || other.botName == _this.botName)&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.meetingTitle, _this.meetingTitle) || other.meetingTitle == _this.meetingTitle)&&(identical(other.keepVideo, _this.keepVideo) || other.keepVideo == _this.keepVideo)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeetingBotModel;
  return Object.hash(runtimeType,_this.id,_this.meetUrl,_this.status,_this.errorCode,_this.errorMessage,_this.cancelRequested,_this.botName,_this.mediaId,_this.jobId,_this.meetingTitle,_this.keepVideo,_this.createdAt);
}

@override
String toString() {
  final _this = this as MeetingBotModel;
  return 'MeetingBotModel(id: ${_this.id}, meetUrl: ${_this.meetUrl}, status: ${_this.status}, errorCode: ${_this.errorCode}, errorMessage: ${_this.errorMessage}, cancelRequested: ${_this.cancelRequested}, botName: ${_this.botName}, mediaId: ${_this.mediaId}, jobId: ${_this.jobId}, meetingTitle: ${_this.meetingTitle}, keepVideo: ${_this.keepVideo}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $MeetingBotModelCopyWith<$Res>  {
  factory $MeetingBotModelCopyWith(MeetingBotModel value, $Res Function(MeetingBotModel) _then) = _$MeetingBotModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'meet_url') String meetUrl,@JsonKey(name: 'status', unknownEnumValue: MeetingBotStatus.unknown) MeetingBotStatus status,@JsonKey(name: 'error_code') String? errorCode,@JsonKey(name: 'error_message') String? errorMessage,@JsonKey(name: 'cancel_requested') bool cancelRequested,@JsonKey(name: 'bot_name') String botName,@JsonKey(name: 'media_id') String? mediaId,@JsonKey(name: 'job_id') String? jobId,@JsonKey(name: 'meeting_title') String? meetingTitle,@JsonKey(name: 'keep_video') bool keepVideo,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$MeetingBotModelCopyWithImpl<$Res>
    implements $MeetingBotModelCopyWith<$Res> {
  _$MeetingBotModelCopyWithImpl(this._self, this._then);

  final MeetingBotModel _self;
  final $Res Function(MeetingBotModel) _then;

/// Create a copy of MeetingBotModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? meetUrl = null,Object? status = null,Object? errorCode = freezed,Object? errorMessage = freezed,Object? cancelRequested = null,Object? botName = null,Object? mediaId = freezed,Object? jobId = freezed,Object? meetingTitle = freezed,Object? keepVideo = null,Object? createdAt = freezed,}) {
  return _then(MeetingBotModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,meetUrl: null == meetUrl ? _self.meetUrl : meetUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MeetingBotStatus,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,cancelRequested: null == cancelRequested ? _self.cancelRequested : cancelRequested // ignore: cast_nullable_to_non_nullable
as bool,botName: null == botName ? _self.botName : botName // ignore: cast_nullable_to_non_nullable
as String,mediaId: freezed == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,keepVideo: null == keepVideo ? _self.keepVideo : keepVideo // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingBotModel].
extension MeetingBotModelPatterns on MeetingBotModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingBotModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingBotModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingBotModel value)  $default,){
final _that = this;
switch (_that) {
case _MeetingBotModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingBotModel value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingBotModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'meet_url')  String meetUrl, @JsonKey(name: 'status', unknownEnumValue: MeetingBotStatus.unknown)  MeetingBotStatus status, @JsonKey(name: 'error_code')  String? errorCode, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'cancel_requested')  bool cancelRequested, @JsonKey(name: 'bot_name')  String botName, @JsonKey(name: 'media_id')  String? mediaId, @JsonKey(name: 'job_id')  String? jobId, @JsonKey(name: 'meeting_title')  String? meetingTitle, @JsonKey(name: 'keep_video')  bool keepVideo, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingBotModel() when $default != null:
return $default(_that.id,_that.meetUrl,_that.status,_that.errorCode,_that.errorMessage,_that.cancelRequested,_that.botName,_that.mediaId,_that.jobId,_that.meetingTitle,_that.keepVideo,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'meet_url')  String meetUrl, @JsonKey(name: 'status', unknownEnumValue: MeetingBotStatus.unknown)  MeetingBotStatus status, @JsonKey(name: 'error_code')  String? errorCode, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'cancel_requested')  bool cancelRequested, @JsonKey(name: 'bot_name')  String botName, @JsonKey(name: 'media_id')  String? mediaId, @JsonKey(name: 'job_id')  String? jobId, @JsonKey(name: 'meeting_title')  String? meetingTitle, @JsonKey(name: 'keep_video')  bool keepVideo, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MeetingBotModel():
return $default(_that.id,_that.meetUrl,_that.status,_that.errorCode,_that.errorMessage,_that.cancelRequested,_that.botName,_that.mediaId,_that.jobId,_that.meetingTitle,_that.keepVideo,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'meet_url')  String meetUrl, @JsonKey(name: 'status', unknownEnumValue: MeetingBotStatus.unknown)  MeetingBotStatus status, @JsonKey(name: 'error_code')  String? errorCode, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'cancel_requested')  bool cancelRequested, @JsonKey(name: 'bot_name')  String botName, @JsonKey(name: 'media_id')  String? mediaId, @JsonKey(name: 'job_id')  String? jobId, @JsonKey(name: 'meeting_title')  String? meetingTitle, @JsonKey(name: 'keep_video')  bool keepVideo, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MeetingBotModel() when $default != null:
return $default(_that.id,_that.meetUrl,_that.status,_that.errorCode,_that.errorMessage,_that.cancelRequested,_that.botName,_that.mediaId,_that.jobId,_that.meetingTitle,_that.keepVideo,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingBotModel extends MeetingBotModel {
  const _MeetingBotModel({@JsonKey(name: 'id') this.id = '', @JsonKey(name: 'meet_url') this.meetUrl = '', @JsonKey(name: 'status', unknownEnumValue: MeetingBotStatus.unknown) this.status = MeetingBotStatus.unknown, @JsonKey(name: 'error_code') this.errorCode, @JsonKey(name: 'error_message') this.errorMessage, @JsonKey(name: 'cancel_requested') this.cancelRequested = false, @JsonKey(name: 'bot_name') this.botName = '', @JsonKey(name: 'media_id') this.mediaId, @JsonKey(name: 'job_id') this.jobId, @JsonKey(name: 'meeting_title') this.meetingTitle, @JsonKey(name: 'keep_video') this.keepVideo = false, @JsonKey(name: 'created_at') this.createdAt}): super._();
  factory _MeetingBotModel.fromJson(Map<String, dynamic> json) => _$MeetingBotModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'meet_url') final  String meetUrl;
@override@JsonKey(name: 'status', unknownEnumValue: MeetingBotStatus.unknown) final  MeetingBotStatus status;
@override@JsonKey(name: 'error_code') final  String? errorCode;
@override@JsonKey(name: 'error_message') final  String? errorMessage;
@override@JsonKey(name: 'cancel_requested') final  bool cancelRequested;
@override@JsonKey(name: 'bot_name') final  String botName;
@override@JsonKey(name: 'media_id') final  String? mediaId;
@override@JsonKey(name: 'job_id') final  String? jobId;
@override@JsonKey(name: 'meeting_title') final  String? meetingTitle;
@override@JsonKey(name: 'keep_video') final  bool keepVideo;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of MeetingBotModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingBotModelCopyWith<_MeetingBotModel> get copyWith => __$MeetingBotModelCopyWithImpl<_MeetingBotModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingBotModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingBotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.meetUrl, meetUrl) || other.meetUrl == meetUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.cancelRequested, cancelRequested) || other.cancelRequested == cancelRequested)&&(identical(other.botName, botName) || other.botName == botName)&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.meetingTitle, meetingTitle) || other.meetingTitle == meetingTitle)&&(identical(other.keepVideo, keepVideo) || other.keepVideo == keepVideo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,meetUrl,status,errorCode,errorMessage,cancelRequested,botName,mediaId,jobId,meetingTitle,keepVideo,createdAt);
}

@override
String toString() {
    return 'MeetingBotModel(id: $id, meetUrl: $meetUrl, status: $status, errorCode: $errorCode, errorMessage: $errorMessage, cancelRequested: $cancelRequested, botName: $botName, mediaId: $mediaId, jobId: $jobId, meetingTitle: $meetingTitle, keepVideo: $keepVideo, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MeetingBotModelCopyWith<$Res> implements $MeetingBotModelCopyWith<$Res> {
  factory _$MeetingBotModelCopyWith(_MeetingBotModel value, $Res Function(_MeetingBotModel) _then) = __$MeetingBotModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'meet_url') String meetUrl,@JsonKey(name: 'status', unknownEnumValue: MeetingBotStatus.unknown) MeetingBotStatus status,@JsonKey(name: 'error_code') String? errorCode,@JsonKey(name: 'error_message') String? errorMessage,@JsonKey(name: 'cancel_requested') bool cancelRequested,@JsonKey(name: 'bot_name') String botName,@JsonKey(name: 'media_id') String? mediaId,@JsonKey(name: 'job_id') String? jobId,@JsonKey(name: 'meeting_title') String? meetingTitle,@JsonKey(name: 'keep_video') bool keepVideo,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$MeetingBotModelCopyWithImpl<$Res>
    implements _$MeetingBotModelCopyWith<$Res> {
  __$MeetingBotModelCopyWithImpl(this._self, this._then);

  final _MeetingBotModel _self;
  final $Res Function(_MeetingBotModel) _then;

/// Create a copy of MeetingBotModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? meetUrl = null,Object? status = null,Object? errorCode = freezed,Object? errorMessage = freezed,Object? cancelRequested = null,Object? botName = null,Object? mediaId = freezed,Object? jobId = freezed,Object? meetingTitle = freezed,Object? keepVideo = null,Object? createdAt = freezed,}) {
  return _then(_MeetingBotModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,meetUrl: null == meetUrl ? _self.meetUrl : meetUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MeetingBotStatus,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,cancelRequested: null == cancelRequested ? _self.cancelRequested : cancelRequested // ignore: cast_nullable_to_non_nullable
as bool,botName: null == botName ? _self.botName : botName // ignore: cast_nullable_to_non_nullable
as String,mediaId: freezed == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,keepVideo: null == keepVideo ? _self.keepVideo : keepVideo // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$MeetingBotListModel {

@JsonKey(name: 'available') bool get available;@JsonKey(name: 'default_bot_name') String get defaultBotName;@JsonKey(name: 'items') List<MeetingBotModel> get items;
/// Create a copy of MeetingBotListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingBotListModelCopyWith<MeetingBotListModel> get copyWith => _$MeetingBotListModelCopyWithImpl<MeetingBotListModel>(this as MeetingBotListModel, _$identity);

  /// Serializes this MeetingBotListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeetingBotListModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingBotListModel&&(identical(other.available, _this.available) || other.available == _this.available)&&(identical(other.defaultBotName, _this.defaultBotName) || other.defaultBotName == _this.defaultBotName)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeetingBotListModel;
  return Object.hash(runtimeType,_this.available,_this.defaultBotName,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as MeetingBotListModel;
  return 'MeetingBotListModel(available: ${_this.available}, defaultBotName: ${_this.defaultBotName}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $MeetingBotListModelCopyWith<$Res>  {
  factory $MeetingBotListModelCopyWith(MeetingBotListModel value, $Res Function(MeetingBotListModel) _then) = _$MeetingBotListModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'available') bool available,@JsonKey(name: 'default_bot_name') String defaultBotName,@JsonKey(name: 'items') List<MeetingBotModel> items
});




}
/// @nodoc
class _$MeetingBotListModelCopyWithImpl<$Res>
    implements $MeetingBotListModelCopyWith<$Res> {
  _$MeetingBotListModelCopyWithImpl(this._self, this._then);

  final MeetingBotListModel _self;
  final $Res Function(MeetingBotListModel) _then;

/// Create a copy of MeetingBotListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? available = null,Object? defaultBotName = null,Object? items = null,}) {
  return _then(MeetingBotListModel(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,defaultBotName: null == defaultBotName ? _self.defaultBotName : defaultBotName // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MeetingBotModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingBotListModel].
extension MeetingBotListModelPatterns on MeetingBotListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingBotListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingBotListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingBotListModel value)  $default,){
final _that = this;
switch (_that) {
case _MeetingBotListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingBotListModel value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingBotListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'available')  bool available, @JsonKey(name: 'default_bot_name')  String defaultBotName, @JsonKey(name: 'items')  List<MeetingBotModel> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingBotListModel() when $default != null:
return $default(_that.available,_that.defaultBotName,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'available')  bool available, @JsonKey(name: 'default_bot_name')  String defaultBotName, @JsonKey(name: 'items')  List<MeetingBotModel> items)  $default,) {final _that = this;
switch (_that) {
case _MeetingBotListModel():
return $default(_that.available,_that.defaultBotName,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'available')  bool available, @JsonKey(name: 'default_bot_name')  String defaultBotName, @JsonKey(name: 'items')  List<MeetingBotModel> items)?  $default,) {final _that = this;
switch (_that) {
case _MeetingBotListModel() when $default != null:
return $default(_that.available,_that.defaultBotName,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingBotListModel extends MeetingBotListModel {
  const _MeetingBotListModel({@JsonKey(name: 'available') this.available = true, @JsonKey(name: 'default_bot_name') this.defaultBotName = '', @JsonKey(name: 'items')  List<MeetingBotModel> items = const <MeetingBotModel>[]}): _items = items,super._();
  factory _MeetingBotListModel.fromJson(Map<String, dynamic> json) => _$MeetingBotListModelFromJson(json);

@override@JsonKey(name: 'available') final  bool available;
@override@JsonKey(name: 'default_bot_name') final  String defaultBotName;
 final  List<MeetingBotModel> _items;
@override@JsonKey(name: 'items') List<MeetingBotModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MeetingBotListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingBotListModelCopyWith<_MeetingBotListModel> get copyWith => __$MeetingBotListModelCopyWithImpl<_MeetingBotListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingBotListModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingBotListModel&&(identical(other.available, available) || other.available == available)&&(identical(other.defaultBotName, defaultBotName) || other.defaultBotName == defaultBotName)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,available,defaultBotName,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'MeetingBotListModel(available: $available, defaultBotName: $defaultBotName, items: $items)';
}


}

/// @nodoc
abstract mixin class _$MeetingBotListModelCopyWith<$Res> implements $MeetingBotListModelCopyWith<$Res> {
  factory _$MeetingBotListModelCopyWith(_MeetingBotListModel value, $Res Function(_MeetingBotListModel) _then) = __$MeetingBotListModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'available') bool available,@JsonKey(name: 'default_bot_name') String defaultBotName,@JsonKey(name: 'items') List<MeetingBotModel> items
});




}
/// @nodoc
class __$MeetingBotListModelCopyWithImpl<$Res>
    implements _$MeetingBotListModelCopyWith<$Res> {
  __$MeetingBotListModelCopyWithImpl(this._self, this._then);

  final _MeetingBotListModel _self;
  final $Res Function(_MeetingBotListModel) _then;

/// Create a copy of MeetingBotListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? available = null,Object? defaultBotName = null,Object? items = null,}) {
  return _then(_MeetingBotListModel(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,defaultBotName: null == defaultBotName ? _self.defaultBotName : defaultBotName // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MeetingBotModel>,
  ));
}


}

// dart format on
