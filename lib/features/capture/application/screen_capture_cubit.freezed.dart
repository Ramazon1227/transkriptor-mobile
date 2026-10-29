// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_capture_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScreenCaptureState {

 ScreenCaptureStatus get status;/// Null until [ScreenCaptureCubit.init] has asked. False on iOS and
/// Android below 10: the page says why instead of offering a button.
 bool? get supported; bool get withMic; Duration get elapsed;/// Most recent last, each 0–1.
 List<double> get levels;/// Nothing came from playback in the first seconds: nothing is
/// playing, or the app playing forbids capture (call apps do).
 bool get playbackSilent;/// Set with [ScreenCaptureStatus.done]: send it like a microphone
/// recording (`UploadSource.recording`).
 Recording? get recording; Failure? get failure;
/// Create a copy of ScreenCaptureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScreenCaptureStateCopyWith<ScreenCaptureState> get copyWith => _$ScreenCaptureStateCopyWithImpl<ScreenCaptureState>(this as ScreenCaptureState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScreenCaptureState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenCaptureState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.supported, _this.supported) || other.supported == _this.supported)&&(identical(other.withMic, _this.withMic) || other.withMic == _this.withMic)&&(identical(other.elapsed, _this.elapsed) || other.elapsed == _this.elapsed)&&const DeepCollectionEquality().equals(other.levels, _this.levels)&&(identical(other.playbackSilent, _this.playbackSilent) || other.playbackSilent == _this.playbackSilent)&&(identical(other.recording, _this.recording) || other.recording == _this.recording)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as ScreenCaptureState;
  return Object.hash(runtimeType,_this.status,_this.supported,_this.withMic,_this.elapsed,const DeepCollectionEquality().hash(_this.levels),_this.playbackSilent,_this.recording,_this.failure);
}

@override
String toString() {
  final _this = this as ScreenCaptureState;
  return 'ScreenCaptureState(status: ${_this.status}, supported: ${_this.supported}, withMic: ${_this.withMic}, elapsed: ${_this.elapsed}, levels: ${_this.levels}, playbackSilent: ${_this.playbackSilent}, recording: ${_this.recording}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $ScreenCaptureStateCopyWith<$Res>  {
  factory $ScreenCaptureStateCopyWith(ScreenCaptureState value, $Res Function(ScreenCaptureState) _then) = _$ScreenCaptureStateCopyWithImpl;
@useResult
$Res call({
 ScreenCaptureStatus status, bool? supported, bool withMic, Duration elapsed, List<double> levels, bool playbackSilent, Recording? recording, Failure? failure
});


$RecordingCopyWith<$Res>? get recording;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ScreenCaptureStateCopyWithImpl<$Res>
    implements $ScreenCaptureStateCopyWith<$Res> {
  _$ScreenCaptureStateCopyWithImpl(this._self, this._then);

  final ScreenCaptureState _self;
  final $Res Function(ScreenCaptureState) _then;

/// Create a copy of ScreenCaptureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? supported = freezed,Object? withMic = null,Object? elapsed = null,Object? levels = null,Object? playbackSilent = null,Object? recording = freezed,Object? failure = freezed,}) {
  return _then(ScreenCaptureState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScreenCaptureStatus,supported: freezed == supported ? _self.supported : supported // ignore: cast_nullable_to_non_nullable
as bool?,withMic: null == withMic ? _self.withMic : withMic // ignore: cast_nullable_to_non_nullable
as bool,elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,levels: null == levels ? _self.levels : levels // ignore: cast_nullable_to_non_nullable
as List<double>,playbackSilent: null == playbackSilent ? _self.playbackSilent : playbackSilent // ignore: cast_nullable_to_non_nullable
as bool,recording: freezed == recording ? _self.recording : recording // ignore: cast_nullable_to_non_nullable
as Recording?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of ScreenCaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecordingCopyWith<$Res>? get recording {
    if (_self.recording == null) {
    return null;
  }

  return $RecordingCopyWith<$Res>(_self.recording!, (value) {
    return _then(_self.copyWith(recording: value));
  });
}/// Create a copy of ScreenCaptureState
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


/// Adds pattern-matching-related methods to [ScreenCaptureState].
extension ScreenCaptureStatePatterns on ScreenCaptureState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScreenCaptureState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScreenCaptureState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScreenCaptureState value)  $default,){
final _that = this;
switch (_that) {
case _ScreenCaptureState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScreenCaptureState value)?  $default,){
final _that = this;
switch (_that) {
case _ScreenCaptureState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScreenCaptureStatus status,  bool? supported,  bool withMic,  Duration elapsed,  List<double> levels,  bool playbackSilent,  Recording? recording,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScreenCaptureState() when $default != null:
return $default(_that.status,_that.supported,_that.withMic,_that.elapsed,_that.levels,_that.playbackSilent,_that.recording,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScreenCaptureStatus status,  bool? supported,  bool withMic,  Duration elapsed,  List<double> levels,  bool playbackSilent,  Recording? recording,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _ScreenCaptureState():
return $default(_that.status,_that.supported,_that.withMic,_that.elapsed,_that.levels,_that.playbackSilent,_that.recording,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScreenCaptureStatus status,  bool? supported,  bool withMic,  Duration elapsed,  List<double> levels,  bool playbackSilent,  Recording? recording,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _ScreenCaptureState() when $default != null:
return $default(_that.status,_that.supported,_that.withMic,_that.elapsed,_that.levels,_that.playbackSilent,_that.recording,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _ScreenCaptureState implements ScreenCaptureState {
  const _ScreenCaptureState({this.status = ScreenCaptureStatus.idle, this.supported, this.withMic = false, this.elapsed = Duration.zero,  List<double> levels = const <double>[], this.playbackSilent = false, this.recording, this.failure}): _levels = levels;
  

@override@JsonKey() final  ScreenCaptureStatus status;
/// Null until [ScreenCaptureCubit.init] has asked. False on iOS and
/// Android below 10: the page says why instead of offering a button.
@override final  bool? supported;
@override@JsonKey() final  bool withMic;
@override@JsonKey() final  Duration elapsed;
/// Most recent last, each 0–1.
 final  List<double> _levels;
/// Most recent last, each 0–1.
@override@JsonKey() List<double> get levels {
  if (_levels is EqualUnmodifiableListView) return _levels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_levels);
}

/// Nothing came from playback in the first seconds: nothing is
/// playing, or the app playing forbids capture (call apps do).
@override@JsonKey() final  bool playbackSilent;
/// Set with [ScreenCaptureStatus.done]: send it like a microphone
/// recording (`UploadSource.recording`).
@override final  Recording? recording;
@override final  Failure? failure;

/// Create a copy of ScreenCaptureState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScreenCaptureStateCopyWith<_ScreenCaptureState> get copyWith => __$ScreenCaptureStateCopyWithImpl<_ScreenCaptureState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScreenCaptureState&&(identical(other.status, status) || other.status == status)&&(identical(other.supported, supported) || other.supported == supported)&&(identical(other.withMic, withMic) || other.withMic == withMic)&&(identical(other.elapsed, elapsed) || other.elapsed == elapsed)&&const DeepCollectionEquality().equals(other.levels, _levels)&&(identical(other.playbackSilent, playbackSilent) || other.playbackSilent == playbackSilent)&&(identical(other.recording, recording) || other.recording == recording)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,supported,withMic,elapsed,const DeepCollectionEquality().hash(_levels),playbackSilent,recording,failure);
}

@override
String toString() {
    return 'ScreenCaptureState(status: $status, supported: $supported, withMic: $withMic, elapsed: $elapsed, levels: $levels, playbackSilent: $playbackSilent, recording: $recording, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ScreenCaptureStateCopyWith<$Res> implements $ScreenCaptureStateCopyWith<$Res> {
  factory _$ScreenCaptureStateCopyWith(_ScreenCaptureState value, $Res Function(_ScreenCaptureState) _then) = __$ScreenCaptureStateCopyWithImpl;
@override @useResult
$Res call({
 ScreenCaptureStatus status, bool? supported, bool withMic, Duration elapsed, List<double> levels, bool playbackSilent, Recording? recording, Failure? failure
});


@override $RecordingCopyWith<$Res>? get recording;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ScreenCaptureStateCopyWithImpl<$Res>
    implements _$ScreenCaptureStateCopyWith<$Res> {
  __$ScreenCaptureStateCopyWithImpl(this._self, this._then);

  final _ScreenCaptureState _self;
  final $Res Function(_ScreenCaptureState) _then;

/// Create a copy of ScreenCaptureState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? supported = freezed,Object? withMic = null,Object? elapsed = null,Object? levels = null,Object? playbackSilent = null,Object? recording = freezed,Object? failure = freezed,}) {
  return _then(_ScreenCaptureState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScreenCaptureStatus,supported: freezed == supported ? _self.supported : supported // ignore: cast_nullable_to_non_nullable
as bool?,withMic: null == withMic ? _self.withMic : withMic // ignore: cast_nullable_to_non_nullable
as bool,elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,levels: null == levels ? _self._levels : levels // ignore: cast_nullable_to_non_nullable
as List<double>,playbackSilent: null == playbackSilent ? _self.playbackSilent : playbackSilent // ignore: cast_nullable_to_non_nullable
as bool,recording: freezed == recording ? _self.recording : recording // ignore: cast_nullable_to_non_nullable
as Recording?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of ScreenCaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecordingCopyWith<$Res>? get recording {
    if (_self.recording == null) {
    return null;
  }

  return $RecordingCopyWith<$Res>(_self.recording!, (value) {
    return _then(_self.copyWith(recording: value));
  });
}/// Create a copy of ScreenCaptureState
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
