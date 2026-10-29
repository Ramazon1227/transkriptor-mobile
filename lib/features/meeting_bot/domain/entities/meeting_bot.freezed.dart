// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_bot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeetingBot {

 String get id; MeetingBotStatus get status; String get meetUrl;/// The name the meeting sees; ends with « (yozib olmoqda)».
 String get botName;/// A ready sentence for the person (the server's), or null.
 String? get errorMessage; String? get errorCode; bool get cancelRequested; bool get keepVideo; String? get mediaId;/// Set once the recording is handed to transcription.
 String? get jobId; String? get meetingTitle; DateTime? get createdAt;
/// Create a copy of MeetingBot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingBotCopyWith<MeetingBot> get copyWith => _$MeetingBotCopyWithImpl<MeetingBot>(this as MeetingBot, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MeetingBot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingBot&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.meetUrl, _this.meetUrl) || other.meetUrl == _this.meetUrl)&&(identical(other.botName, _this.botName) || other.botName == _this.botName)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode)&&(identical(other.cancelRequested, _this.cancelRequested) || other.cancelRequested == _this.cancelRequested)&&(identical(other.keepVideo, _this.keepVideo) || other.keepVideo == _this.keepVideo)&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.meetingTitle, _this.meetingTitle) || other.meetingTitle == _this.meetingTitle)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as MeetingBot;
  return Object.hash(runtimeType,_this.id,_this.status,_this.meetUrl,_this.botName,_this.errorMessage,_this.errorCode,_this.cancelRequested,_this.keepVideo,_this.mediaId,_this.jobId,_this.meetingTitle,_this.createdAt);
}

@override
String toString() {
  final _this = this as MeetingBot;
  return 'MeetingBot(id: ${_this.id}, status: ${_this.status}, meetUrl: ${_this.meetUrl}, botName: ${_this.botName}, errorMessage: ${_this.errorMessage}, errorCode: ${_this.errorCode}, cancelRequested: ${_this.cancelRequested}, keepVideo: ${_this.keepVideo}, mediaId: ${_this.mediaId}, jobId: ${_this.jobId}, meetingTitle: ${_this.meetingTitle}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $MeetingBotCopyWith<$Res>  {
  factory $MeetingBotCopyWith(MeetingBot value, $Res Function(MeetingBot) _then) = _$MeetingBotCopyWithImpl;
@useResult
$Res call({
 String id, MeetingBotStatus status, String meetUrl, String botName, String? errorMessage, String? errorCode, bool cancelRequested, bool keepVideo, String? mediaId, String? jobId, String? meetingTitle, DateTime? createdAt
});




}
/// @nodoc
class _$MeetingBotCopyWithImpl<$Res>
    implements $MeetingBotCopyWith<$Res> {
  _$MeetingBotCopyWithImpl(this._self, this._then);

  final MeetingBot _self;
  final $Res Function(MeetingBot) _then;

/// Create a copy of MeetingBot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? meetUrl = null,Object? botName = null,Object? errorMessage = freezed,Object? errorCode = freezed,Object? cancelRequested = null,Object? keepVideo = null,Object? mediaId = freezed,Object? jobId = freezed,Object? meetingTitle = freezed,Object? createdAt = freezed,}) {
  return _then(MeetingBot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MeetingBotStatus,meetUrl: null == meetUrl ? _self.meetUrl : meetUrl // ignore: cast_nullable_to_non_nullable
as String,botName: null == botName ? _self.botName : botName // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,cancelRequested: null == cancelRequested ? _self.cancelRequested : cancelRequested // ignore: cast_nullable_to_non_nullable
as bool,keepVideo: null == keepVideo ? _self.keepVideo : keepVideo // ignore: cast_nullable_to_non_nullable
as bool,mediaId: freezed == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingBot].
extension MeetingBotPatterns on MeetingBot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingBot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingBot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingBot value)  $default,){
final _that = this;
switch (_that) {
case _MeetingBot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingBot value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingBot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  MeetingBotStatus status,  String meetUrl,  String botName,  String? errorMessage,  String? errorCode,  bool cancelRequested,  bool keepVideo,  String? mediaId,  String? jobId,  String? meetingTitle,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingBot() when $default != null:
return $default(_that.id,_that.status,_that.meetUrl,_that.botName,_that.errorMessage,_that.errorCode,_that.cancelRequested,_that.keepVideo,_that.mediaId,_that.jobId,_that.meetingTitle,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  MeetingBotStatus status,  String meetUrl,  String botName,  String? errorMessage,  String? errorCode,  bool cancelRequested,  bool keepVideo,  String? mediaId,  String? jobId,  String? meetingTitle,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MeetingBot():
return $default(_that.id,_that.status,_that.meetUrl,_that.botName,_that.errorMessage,_that.errorCode,_that.cancelRequested,_that.keepVideo,_that.mediaId,_that.jobId,_that.meetingTitle,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  MeetingBotStatus status,  String meetUrl,  String botName,  String? errorMessage,  String? errorCode,  bool cancelRequested,  bool keepVideo,  String? mediaId,  String? jobId,  String? meetingTitle,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MeetingBot() when $default != null:
return $default(_that.id,_that.status,_that.meetUrl,_that.botName,_that.errorMessage,_that.errorCode,_that.cancelRequested,_that.keepVideo,_that.mediaId,_that.jobId,_that.meetingTitle,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _MeetingBot implements MeetingBot {
  const _MeetingBot({required this.id, required this.status, this.meetUrl = '', this.botName = '', this.errorMessage, this.errorCode, this.cancelRequested = false, this.keepVideo = false, this.mediaId, this.jobId, this.meetingTitle, this.createdAt});
  

@override final  String id;
@override final  MeetingBotStatus status;
@override@JsonKey() final  String meetUrl;
/// The name the meeting sees; ends with « (yozib olmoqda)».
@override@JsonKey() final  String botName;
/// A ready sentence for the person (the server's), or null.
@override final  String? errorMessage;
@override final  String? errorCode;
@override@JsonKey() final  bool cancelRequested;
@override@JsonKey() final  bool keepVideo;
@override final  String? mediaId;
/// Set once the recording is handed to transcription.
@override final  String? jobId;
@override final  String? meetingTitle;
@override final  DateTime? createdAt;

/// Create a copy of MeetingBot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingBotCopyWith<_MeetingBot> get copyWith => __$MeetingBotCopyWithImpl<_MeetingBot>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingBot&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.meetUrl, meetUrl) || other.meetUrl == meetUrl)&&(identical(other.botName, botName) || other.botName == botName)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.cancelRequested, cancelRequested) || other.cancelRequested == cancelRequested)&&(identical(other.keepVideo, keepVideo) || other.keepVideo == keepVideo)&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.meetingTitle, meetingTitle) || other.meetingTitle == meetingTitle)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,status,meetUrl,botName,errorMessage,errorCode,cancelRequested,keepVideo,mediaId,jobId,meetingTitle,createdAt);
}

@override
String toString() {
    return 'MeetingBot(id: $id, status: $status, meetUrl: $meetUrl, botName: $botName, errorMessage: $errorMessage, errorCode: $errorCode, cancelRequested: $cancelRequested, keepVideo: $keepVideo, mediaId: $mediaId, jobId: $jobId, meetingTitle: $meetingTitle, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MeetingBotCopyWith<$Res> implements $MeetingBotCopyWith<$Res> {
  factory _$MeetingBotCopyWith(_MeetingBot value, $Res Function(_MeetingBot) _then) = __$MeetingBotCopyWithImpl;
@override @useResult
$Res call({
 String id, MeetingBotStatus status, String meetUrl, String botName, String? errorMessage, String? errorCode, bool cancelRequested, bool keepVideo, String? mediaId, String? jobId, String? meetingTitle, DateTime? createdAt
});




}
/// @nodoc
class __$MeetingBotCopyWithImpl<$Res>
    implements _$MeetingBotCopyWith<$Res> {
  __$MeetingBotCopyWithImpl(this._self, this._then);

  final _MeetingBot _self;
  final $Res Function(_MeetingBot) _then;

/// Create a copy of MeetingBot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? meetUrl = null,Object? botName = null,Object? errorMessage = freezed,Object? errorCode = freezed,Object? cancelRequested = null,Object? keepVideo = null,Object? mediaId = freezed,Object? jobId = freezed,Object? meetingTitle = freezed,Object? createdAt = freezed,}) {
  return _then(_MeetingBot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MeetingBotStatus,meetUrl: null == meetUrl ? _self.meetUrl : meetUrl // ignore: cast_nullable_to_non_nullable
as String,botName: null == botName ? _self.botName : botName // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,cancelRequested: null == cancelRequested ? _self.cancelRequested : cancelRequested // ignore: cast_nullable_to_non_nullable
as bool,keepVideo: null == keepVideo ? _self.keepVideo : keepVideo // ignore: cast_nullable_to_non_nullable
as bool,mediaId: freezed == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$MeetingBotList {

 bool get available; String get defaultBotName; List<MeetingBot> get items;
/// Create a copy of MeetingBotList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingBotListCopyWith<MeetingBotList> get copyWith => _$MeetingBotListCopyWithImpl<MeetingBotList>(this as MeetingBotList, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MeetingBotList;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingBotList&&(identical(other.available, _this.available) || other.available == _this.available)&&(identical(other.defaultBotName, _this.defaultBotName) || other.defaultBotName == _this.defaultBotName)&&const DeepCollectionEquality().equals(other.items, _this.items));
}


@override
int get hashCode {
  final _this = this as MeetingBotList;
  return Object.hash(runtimeType,_this.available,_this.defaultBotName,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as MeetingBotList;
  return 'MeetingBotList(available: ${_this.available}, defaultBotName: ${_this.defaultBotName}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $MeetingBotListCopyWith<$Res>  {
  factory $MeetingBotListCopyWith(MeetingBotList value, $Res Function(MeetingBotList) _then) = _$MeetingBotListCopyWithImpl;
@useResult
$Res call({
 bool available, String defaultBotName, List<MeetingBot> items
});




}
/// @nodoc
class _$MeetingBotListCopyWithImpl<$Res>
    implements $MeetingBotListCopyWith<$Res> {
  _$MeetingBotListCopyWithImpl(this._self, this._then);

  final MeetingBotList _self;
  final $Res Function(MeetingBotList) _then;

/// Create a copy of MeetingBotList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? available = null,Object? defaultBotName = null,Object? items = null,}) {
  return _then(MeetingBotList(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,defaultBotName: null == defaultBotName ? _self.defaultBotName : defaultBotName // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MeetingBot>,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingBotList].
extension MeetingBotListPatterns on MeetingBotList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingBotList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingBotList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingBotList value)  $default,){
final _that = this;
switch (_that) {
case _MeetingBotList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingBotList value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingBotList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool available,  String defaultBotName,  List<MeetingBot> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingBotList() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool available,  String defaultBotName,  List<MeetingBot> items)  $default,) {final _that = this;
switch (_that) {
case _MeetingBotList():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool available,  String defaultBotName,  List<MeetingBot> items)?  $default,) {final _that = this;
switch (_that) {
case _MeetingBotList() when $default != null:
return $default(_that.available,_that.defaultBotName,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _MeetingBotList implements MeetingBotList {
  const _MeetingBotList({this.available = true, this.defaultBotName = '',  List<MeetingBot> items = const <MeetingBot>[]}): _items = items;
  

@override@JsonKey() final  bool available;
@override@JsonKey() final  String defaultBotName;
 final  List<MeetingBot> _items;
@override@JsonKey() List<MeetingBot> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MeetingBotList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingBotListCopyWith<_MeetingBotList> get copyWith => __$MeetingBotListCopyWithImpl<_MeetingBotList>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingBotList&&(identical(other.available, available) || other.available == available)&&(identical(other.defaultBotName, defaultBotName) || other.defaultBotName == defaultBotName)&&const DeepCollectionEquality().equals(other.items, _items));
}


@override
int get hashCode {
    return Object.hash(runtimeType,available,defaultBotName,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'MeetingBotList(available: $available, defaultBotName: $defaultBotName, items: $items)';
}


}

/// @nodoc
abstract mixin class _$MeetingBotListCopyWith<$Res> implements $MeetingBotListCopyWith<$Res> {
  factory _$MeetingBotListCopyWith(_MeetingBotList value, $Res Function(_MeetingBotList) _then) = __$MeetingBotListCopyWithImpl;
@override @useResult
$Res call({
 bool available, String defaultBotName, List<MeetingBot> items
});




}
/// @nodoc
class __$MeetingBotListCopyWithImpl<$Res>
    implements _$MeetingBotListCopyWith<$Res> {
  __$MeetingBotListCopyWithImpl(this._self, this._then);

  final _MeetingBotList _self;
  final $Res Function(_MeetingBotList) _then;

/// Create a copy of MeetingBotList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? available = null,Object? defaultBotName = null,Object? items = null,}) {
  return _then(_MeetingBotList(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,defaultBotName: null == defaultBotName ? _self.defaultBotName : defaultBotName // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MeetingBot>,
  ));
}


}

// dart format on
