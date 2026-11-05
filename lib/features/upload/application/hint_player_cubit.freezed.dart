// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hint_player_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HintPlayerState {

 HintPlayerStatus get status; Duration get position; Duration get duration; bool get playing;
/// Create a copy of HintPlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HintPlayerStateCopyWith<HintPlayerState> get copyWith => _$HintPlayerStateCopyWithImpl<HintPlayerState>(this as HintPlayerState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HintPlayerState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HintPlayerState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.playing, _this.playing) || other.playing == _this.playing));
}


@override
int get hashCode {
  final _this = this as HintPlayerState;
  return Object.hash(runtimeType,_this.status,_this.position,_this.duration,_this.playing);
}

@override
String toString() {
  final _this = this as HintPlayerState;
  return 'HintPlayerState(status: ${_this.status}, position: ${_this.position}, duration: ${_this.duration}, playing: ${_this.playing})';
}


}

/// @nodoc
abstract mixin class $HintPlayerStateCopyWith<$Res>  {
  factory $HintPlayerStateCopyWith(HintPlayerState value, $Res Function(HintPlayerState) _then) = _$HintPlayerStateCopyWithImpl;
@useResult
$Res call({
 HintPlayerStatus status, Duration position, Duration duration, bool playing
});




}
/// @nodoc
class _$HintPlayerStateCopyWithImpl<$Res>
    implements $HintPlayerStateCopyWith<$Res> {
  _$HintPlayerStateCopyWithImpl(this._self, this._then);

  final HintPlayerState _self;
  final $Res Function(HintPlayerState) _then;

/// Create a copy of HintPlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? position = null,Object? duration = null,Object? playing = null,}) {
  return _then(HintPlayerState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HintPlayerStatus,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,playing: null == playing ? _self.playing : playing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HintPlayerState].
extension HintPlayerStatePatterns on HintPlayerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HintPlayerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HintPlayerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HintPlayerState value)  $default,){
final _that = this;
switch (_that) {
case _HintPlayerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HintPlayerState value)?  $default,){
final _that = this;
switch (_that) {
case _HintPlayerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HintPlayerStatus status,  Duration position,  Duration duration,  bool playing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HintPlayerState() when $default != null:
return $default(_that.status,_that.position,_that.duration,_that.playing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HintPlayerStatus status,  Duration position,  Duration duration,  bool playing)  $default,) {final _that = this;
switch (_that) {
case _HintPlayerState():
return $default(_that.status,_that.position,_that.duration,_that.playing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HintPlayerStatus status,  Duration position,  Duration duration,  bool playing)?  $default,) {final _that = this;
switch (_that) {
case _HintPlayerState() when $default != null:
return $default(_that.status,_that.position,_that.duration,_that.playing);case _:
  return null;

}
}

}

/// @nodoc


class _HintPlayerState implements HintPlayerState {
  const _HintPlayerState({this.status = HintPlayerStatus.initial, this.position = Duration.zero, this.duration = Duration.zero, this.playing = false});
  

@override@JsonKey() final  HintPlayerStatus status;
@override@JsonKey() final  Duration position;
@override@JsonKey() final  Duration duration;
@override@JsonKey() final  bool playing;

/// Create a copy of HintPlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HintPlayerStateCopyWith<_HintPlayerState> get copyWith => __$HintPlayerStateCopyWithImpl<_HintPlayerState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HintPlayerState&&(identical(other.status, status) || other.status == status)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playing, playing) || other.playing == playing));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,position,duration,playing);
}

@override
String toString() {
    return 'HintPlayerState(status: $status, position: $position, duration: $duration, playing: $playing)';
}


}

/// @nodoc
abstract mixin class _$HintPlayerStateCopyWith<$Res> implements $HintPlayerStateCopyWith<$Res> {
  factory _$HintPlayerStateCopyWith(_HintPlayerState value, $Res Function(_HintPlayerState) _then) = __$HintPlayerStateCopyWithImpl;
@override @useResult
$Res call({
 HintPlayerStatus status, Duration position, Duration duration, bool playing
});




}
/// @nodoc
class __$HintPlayerStateCopyWithImpl<$Res>
    implements _$HintPlayerStateCopyWith<$Res> {
  __$HintPlayerStateCopyWithImpl(this._self, this._then);

  final _HintPlayerState _self;
  final $Res Function(_HintPlayerState) _then;

/// Create a copy of HintPlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? position = null,Object? duration = null,Object? playing = null,}) {
  return _then(_HintPlayerState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HintPlayerStatus,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,playing: null == playing ? _self.playing : playing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
