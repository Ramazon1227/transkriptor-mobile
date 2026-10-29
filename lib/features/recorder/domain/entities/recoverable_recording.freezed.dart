// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recoverable_recording.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecoverableRecording {

 String get path; RecordingKind get kind; RecordingCompletion get state; DateTime get createdAt; int get sizeBytes;/// Exact for interrupted ones (counted from the frames); read from the
/// file for finished ones; null when it could not be read.
 Duration? get duration;
/// Create a copy of RecoverableRecording
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecoverableRecordingCopyWith<RecoverableRecording> get copyWith => _$RecoverableRecordingCopyWithImpl<RecoverableRecording>(this as RecoverableRecording, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecoverableRecording;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverableRecording&&(identical(other.path, _this.path) || other.path == _this.path)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.duration, _this.duration) || other.duration == _this.duration));
}


@override
int get hashCode {
  final _this = this as RecoverableRecording;
  return Object.hash(runtimeType,_this.path,_this.kind,_this.state,_this.createdAt,_this.sizeBytes,_this.duration);
}

@override
String toString() {
  final _this = this as RecoverableRecording;
  return 'RecoverableRecording(path: ${_this.path}, kind: ${_this.kind}, state: ${_this.state}, createdAt: ${_this.createdAt}, sizeBytes: ${_this.sizeBytes}, duration: ${_this.duration})';
}


}

/// @nodoc
abstract mixin class $RecoverableRecordingCopyWith<$Res>  {
  factory $RecoverableRecordingCopyWith(RecoverableRecording value, $Res Function(RecoverableRecording) _then) = _$RecoverableRecordingCopyWithImpl;
@useResult
$Res call({
 String path, RecordingKind kind, RecordingCompletion state, DateTime createdAt, int sizeBytes, Duration? duration
});




}
/// @nodoc
class _$RecoverableRecordingCopyWithImpl<$Res>
    implements $RecoverableRecordingCopyWith<$Res> {
  _$RecoverableRecordingCopyWithImpl(this._self, this._then);

  final RecoverableRecording _self;
  final $Res Function(RecoverableRecording) _then;

/// Create a copy of RecoverableRecording
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? kind = null,Object? state = null,Object? createdAt = null,Object? sizeBytes = null,Object? duration = freezed,}) {
  return _then(RecoverableRecording(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RecordingKind,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RecordingCompletion,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecoverableRecording].
extension RecoverableRecordingPatterns on RecoverableRecording {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecoverableRecording value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecoverableRecording() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecoverableRecording value)  $default,){
final _that = this;
switch (_that) {
case _RecoverableRecording():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecoverableRecording value)?  $default,){
final _that = this;
switch (_that) {
case _RecoverableRecording() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  RecordingKind kind,  RecordingCompletion state,  DateTime createdAt,  int sizeBytes,  Duration? duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecoverableRecording() when $default != null:
return $default(_that.path,_that.kind,_that.state,_that.createdAt,_that.sizeBytes,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  RecordingKind kind,  RecordingCompletion state,  DateTime createdAt,  int sizeBytes,  Duration? duration)  $default,) {final _that = this;
switch (_that) {
case _RecoverableRecording():
return $default(_that.path,_that.kind,_that.state,_that.createdAt,_that.sizeBytes,_that.duration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  RecordingKind kind,  RecordingCompletion state,  DateTime createdAt,  int sizeBytes,  Duration? duration)?  $default,) {final _that = this;
switch (_that) {
case _RecoverableRecording() when $default != null:
return $default(_that.path,_that.kind,_that.state,_that.createdAt,_that.sizeBytes,_that.duration);case _:
  return null;

}
}

}

/// @nodoc


class _RecoverableRecording implements RecoverableRecording {
  const _RecoverableRecording({required this.path, required this.kind, required this.state, required this.createdAt, required this.sizeBytes, this.duration});
  

@override final  String path;
@override final  RecordingKind kind;
@override final  RecordingCompletion state;
@override final  DateTime createdAt;
@override final  int sizeBytes;
/// Exact for interrupted ones (counted from the frames); read from the
/// file for finished ones; null when it could not be read.
@override final  Duration? duration;

/// Create a copy of RecoverableRecording
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecoverableRecordingCopyWith<_RecoverableRecording> get copyWith => __$RecoverableRecordingCopyWithImpl<_RecoverableRecording>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecoverableRecording&&(identical(other.path, path) || other.path == path)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.state, state) || other.state == state)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode {
    return Object.hash(runtimeType,path,kind,state,createdAt,sizeBytes,duration);
}

@override
String toString() {
    return 'RecoverableRecording(path: $path, kind: $kind, state: $state, createdAt: $createdAt, sizeBytes: $sizeBytes, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$RecoverableRecordingCopyWith<$Res> implements $RecoverableRecordingCopyWith<$Res> {
  factory _$RecoverableRecordingCopyWith(_RecoverableRecording value, $Res Function(_RecoverableRecording) _then) = __$RecoverableRecordingCopyWithImpl;
@override @useResult
$Res call({
 String path, RecordingKind kind, RecordingCompletion state, DateTime createdAt, int sizeBytes, Duration? duration
});




}
/// @nodoc
class __$RecoverableRecordingCopyWithImpl<$Res>
    implements _$RecoverableRecordingCopyWith<$Res> {
  __$RecoverableRecordingCopyWithImpl(this._self, this._then);

  final _RecoverableRecording _self;
  final $Res Function(_RecoverableRecording) _then;

/// Create a copy of RecoverableRecording
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? kind = null,Object? state = null,Object? createdAt = null,Object? sizeBytes = null,Object? duration = freezed,}) {
  return _then(_RecoverableRecording(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RecordingKind,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RecordingCompletion,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
