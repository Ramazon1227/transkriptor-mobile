// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerState {

 PlayerStatus get status; MediaSource? get source; Duration get position; Duration get duration; bool get playing; bool get buffering; bool get hasVideo; double get aspectRatio; double get speed;/// The video surface is folded away. Playback does not notice.
 bool get videoFolded; Failure? get failure;
/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerStateCopyWith<PlayerState> get copyWith => _$PlayerStateCopyWithImpl<PlayerState>(this as PlayerState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlayerState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.playing, _this.playing) || other.playing == _this.playing)&&(identical(other.buffering, _this.buffering) || other.buffering == _this.buffering)&&(identical(other.hasVideo, _this.hasVideo) || other.hasVideo == _this.hasVideo)&&(identical(other.aspectRatio, _this.aspectRatio) || other.aspectRatio == _this.aspectRatio)&&(identical(other.speed, _this.speed) || other.speed == _this.speed)&&(identical(other.videoFolded, _this.videoFolded) || other.videoFolded == _this.videoFolded)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as PlayerState;
  return Object.hash(runtimeType,_this.status,_this.source,_this.position,_this.duration,_this.playing,_this.buffering,_this.hasVideo,_this.aspectRatio,_this.speed,_this.videoFolded,_this.failure);
}

@override
String toString() {
  final _this = this as PlayerState;
  return 'PlayerState(status: ${_this.status}, source: ${_this.source}, position: ${_this.position}, duration: ${_this.duration}, playing: ${_this.playing}, buffering: ${_this.buffering}, hasVideo: ${_this.hasVideo}, aspectRatio: ${_this.aspectRatio}, speed: ${_this.speed}, videoFolded: ${_this.videoFolded}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $PlayerStateCopyWith<$Res>  {
  factory $PlayerStateCopyWith(PlayerState value, $Res Function(PlayerState) _then) = _$PlayerStateCopyWithImpl;
@useResult
$Res call({
 PlayerStatus status, MediaSource? source, Duration position, Duration duration, bool playing, bool buffering, bool hasVideo, double aspectRatio, double speed, bool videoFolded, Failure? failure
});


$MediaSourceCopyWith<$Res>? get source;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$PlayerStateCopyWithImpl<$Res>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._self, this._then);

  final PlayerState _self;
  final $Res Function(PlayerState) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? source = freezed,Object? position = null,Object? duration = null,Object? playing = null,Object? buffering = null,Object? hasVideo = null,Object? aspectRatio = null,Object? speed = null,Object? videoFolded = null,Object? failure = freezed,}) {
  return _then(PlayerState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlayerStatus,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as MediaSource?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,playing: null == playing ? _self.playing : playing // ignore: cast_nullable_to_non_nullable
as bool,buffering: null == buffering ? _self.buffering : buffering // ignore: cast_nullable_to_non_nullable
as bool,hasVideo: null == hasVideo ? _self.hasVideo : hasVideo // ignore: cast_nullable_to_non_nullable
as bool,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as double,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,videoFolded: null == videoFolded ? _self.videoFolded : videoFolded // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $MediaSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerState].
extension PlayerStatePatterns on PlayerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerState value)  $default,){
final _that = this;
switch (_that) {
case _PlayerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlayerStatus status,  MediaSource? source,  Duration position,  Duration duration,  bool playing,  bool buffering,  bool hasVideo,  double aspectRatio,  double speed,  bool videoFolded,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that.status,_that.source,_that.position,_that.duration,_that.playing,_that.buffering,_that.hasVideo,_that.aspectRatio,_that.speed,_that.videoFolded,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlayerStatus status,  MediaSource? source,  Duration position,  Duration duration,  bool playing,  bool buffering,  bool hasVideo,  double aspectRatio,  double speed,  bool videoFolded,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _PlayerState():
return $default(_that.status,_that.source,_that.position,_that.duration,_that.playing,_that.buffering,_that.hasVideo,_that.aspectRatio,_that.speed,_that.videoFolded,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlayerStatus status,  MediaSource? source,  Duration position,  Duration duration,  bool playing,  bool buffering,  bool hasVideo,  double aspectRatio,  double speed,  bool videoFolded,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that.status,_that.source,_that.position,_that.duration,_that.playing,_that.buffering,_that.hasVideo,_that.aspectRatio,_that.speed,_that.videoFolded,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerState extends PlayerState {
  const _PlayerState({this.status = PlayerStatus.initial, this.source, this.position = Duration.zero, this.duration = Duration.zero, this.playing = false, this.buffering = false, this.hasVideo = false, this.aspectRatio = 16 / 9, this.speed = 1.0, this.videoFolded = false, this.failure}): super._();
  

@override@JsonKey() final  PlayerStatus status;
@override final  MediaSource? source;
@override@JsonKey() final  Duration position;
@override@JsonKey() final  Duration duration;
@override@JsonKey() final  bool playing;
@override@JsonKey() final  bool buffering;
@override@JsonKey() final  bool hasVideo;
@override@JsonKey() final  double aspectRatio;
@override@JsonKey() final  double speed;
/// The video surface is folded away. Playback does not notice.
@override@JsonKey() final  bool videoFolded;
@override final  Failure? failure;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerStateCopyWith<_PlayerState> get copyWith => __$PlayerStateCopyWithImpl<_PlayerState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerState&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playing, playing) || other.playing == playing)&&(identical(other.buffering, buffering) || other.buffering == buffering)&&(identical(other.hasVideo, hasVideo) || other.hasVideo == hasVideo)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.videoFolded, videoFolded) || other.videoFolded == videoFolded)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,source,position,duration,playing,buffering,hasVideo,aspectRatio,speed,videoFolded,failure);
}

@override
String toString() {
    return 'PlayerState(status: $status, source: $source, position: $position, duration: $duration, playing: $playing, buffering: $buffering, hasVideo: $hasVideo, aspectRatio: $aspectRatio, speed: $speed, videoFolded: $videoFolded, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$PlayerStateCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory _$PlayerStateCopyWith(_PlayerState value, $Res Function(_PlayerState) _then) = __$PlayerStateCopyWithImpl;
@override @useResult
$Res call({
 PlayerStatus status, MediaSource? source, Duration position, Duration duration, bool playing, bool buffering, bool hasVideo, double aspectRatio, double speed, bool videoFolded, Failure? failure
});


@override $MediaSourceCopyWith<$Res>? get source;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$PlayerStateCopyWithImpl<$Res>
    implements _$PlayerStateCopyWith<$Res> {
  __$PlayerStateCopyWithImpl(this._self, this._then);

  final _PlayerState _self;
  final $Res Function(_PlayerState) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? source = freezed,Object? position = null,Object? duration = null,Object? playing = null,Object? buffering = null,Object? hasVideo = null,Object? aspectRatio = null,Object? speed = null,Object? videoFolded = null,Object? failure = freezed,}) {
  return _then(_PlayerState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlayerStatus,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as MediaSource?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,playing: null == playing ? _self.playing : playing // ignore: cast_nullable_to_non_nullable
as bool,buffering: null == buffering ? _self.buffering : buffering // ignore: cast_nullable_to_non_nullable
as bool,hasVideo: null == hasVideo ? _self.hasVideo : hasVideo // ignore: cast_nullable_to_non_nullable
as bool,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as double,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,videoFolded: null == videoFolded ? _self.videoFolded : videoFolded // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $MediaSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
