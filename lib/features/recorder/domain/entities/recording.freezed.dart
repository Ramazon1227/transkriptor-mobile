// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recording.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Recording {

 String get path; int get sizeBytes; Duration get duration;
/// Create a copy of Recording
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordingCopyWith<Recording> get copyWith => _$RecordingCopyWithImpl<Recording>(this as Recording, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Recording;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Recording&&(identical(other.path, _this.path) || other.path == _this.path)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.duration, _this.duration) || other.duration == _this.duration));
}


@override
int get hashCode {
  final _this = this as Recording;
  return Object.hash(runtimeType,_this.path,_this.sizeBytes,_this.duration);
}

@override
String toString() {
  final _this = this as Recording;
  return 'Recording(path: ${_this.path}, sizeBytes: ${_this.sizeBytes}, duration: ${_this.duration})';
}


}

/// @nodoc
abstract mixin class $RecordingCopyWith<$Res>  {
  factory $RecordingCopyWith(Recording value, $Res Function(Recording) _then) = _$RecordingCopyWithImpl;
@useResult
$Res call({
 String path, int sizeBytes, Duration duration
});




}
/// @nodoc
class _$RecordingCopyWithImpl<$Res>
    implements $RecordingCopyWith<$Res> {
  _$RecordingCopyWithImpl(this._self, this._then);

  final Recording _self;
  final $Res Function(Recording) _then;

/// Create a copy of Recording
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? sizeBytes = null,Object? duration = null,}) {
  return _then(Recording(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [Recording].
extension RecordingPatterns on Recording {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Recording value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Recording() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Recording value)  $default,){
final _that = this;
switch (_that) {
case _Recording():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Recording value)?  $default,){
final _that = this;
switch (_that) {
case _Recording() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  int sizeBytes,  Duration duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Recording() when $default != null:
return $default(_that.path,_that.sizeBytes,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  int sizeBytes,  Duration duration)  $default,) {final _that = this;
switch (_that) {
case _Recording():
return $default(_that.path,_that.sizeBytes,_that.duration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  int sizeBytes,  Duration duration)?  $default,) {final _that = this;
switch (_that) {
case _Recording() when $default != null:
return $default(_that.path,_that.sizeBytes,_that.duration);case _:
  return null;

}
}

}

/// @nodoc


class _Recording implements Recording {
  const _Recording({required this.path, required this.sizeBytes, required this.duration});
  

@override final  String path;
@override final  int sizeBytes;
@override final  Duration duration;

/// Create a copy of Recording
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordingCopyWith<_Recording> get copyWith => __$RecordingCopyWithImpl<_Recording>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Recording&&(identical(other.path, path) || other.path == path)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode {
    return Object.hash(runtimeType,path,sizeBytes,duration);
}

@override
String toString() {
    return 'Recording(path: $path, sizeBytes: $sizeBytes, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$RecordingCopyWith<$Res> implements $RecordingCopyWith<$Res> {
  factory _$RecordingCopyWith(_Recording value, $Res Function(_Recording) _then) = __$RecordingCopyWithImpl;
@override @useResult
$Res call({
 String path, int sizeBytes, Duration duration
});




}
/// @nodoc
class __$RecordingCopyWithImpl<$Res>
    implements _$RecordingCopyWith<$Res> {
  __$RecordingCopyWithImpl(this._self, this._then);

  final _Recording _self;
  final $Res Function(_Recording) _then;

/// Create a copy of Recording
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? sizeBytes = null,Object? duration = null,}) {
  return _then(_Recording(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
