// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_capture_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScreenCaptureEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenCaptureEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ScreenCaptureEvent()';
}


}

/// @nodoc
class $ScreenCaptureEventCopyWith<$Res>  {
$ScreenCaptureEventCopyWith(ScreenCaptureEvent _, $Res Function(ScreenCaptureEvent) __);
}


/// Adds pattern-matching-related methods to [ScreenCaptureEvent].
extension ScreenCaptureEventPatterns on ScreenCaptureEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ScreenCaptureLevel value)?  level,TResult Function( ScreenCaptureSilent value)?  silent,TResult Function( ScreenCaptureEnded value)?  ended,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ScreenCaptureLevel() when level != null:
return level(_that);case ScreenCaptureSilent() when silent != null:
return silent(_that);case ScreenCaptureEnded() when ended != null:
return ended(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ScreenCaptureLevel value)  level,required TResult Function( ScreenCaptureSilent value)  silent,required TResult Function( ScreenCaptureEnded value)  ended,}){
final _that = this;
switch (_that) {
case ScreenCaptureLevel():
return level(_that);case ScreenCaptureSilent():
return silent(_that);case ScreenCaptureEnded():
return ended(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ScreenCaptureLevel value)?  level,TResult? Function( ScreenCaptureSilent value)?  silent,TResult? Function( ScreenCaptureEnded value)?  ended,}){
final _that = this;
switch (_that) {
case ScreenCaptureLevel() when level != null:
return level(_that);case ScreenCaptureSilent() when silent != null:
return silent(_that);case ScreenCaptureEnded() when ended != null:
return ended(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double level,  Duration elapsed)?  level,TResult Function()?  silent,TResult Function( Recording? recording,  Failure? failure)?  ended,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ScreenCaptureLevel() when level != null:
return level(_that.level,_that.elapsed);case ScreenCaptureSilent() when silent != null:
return silent();case ScreenCaptureEnded() when ended != null:
return ended(_that.recording,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double level,  Duration elapsed)  level,required TResult Function()  silent,required TResult Function( Recording? recording,  Failure? failure)  ended,}) {final _that = this;
switch (_that) {
case ScreenCaptureLevel():
return level(_that.level,_that.elapsed);case ScreenCaptureSilent():
return silent();case ScreenCaptureEnded():
return ended(_that.recording,_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double level,  Duration elapsed)?  level,TResult? Function()?  silent,TResult? Function( Recording? recording,  Failure? failure)?  ended,}) {final _that = this;
switch (_that) {
case ScreenCaptureLevel() when level != null:
return level(_that.level,_that.elapsed);case ScreenCaptureSilent() when silent != null:
return silent();case ScreenCaptureEnded() when ended != null:
return ended(_that.recording,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ScreenCaptureLevel implements ScreenCaptureEvent {
  const ScreenCaptureLevel({required this.level, required this.elapsed});
  

 final  double level;
 final  Duration elapsed;

/// Create a copy of ScreenCaptureEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScreenCaptureLevelCopyWith<ScreenCaptureLevel> get copyWith => _$ScreenCaptureLevelCopyWithImpl<ScreenCaptureLevel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenCaptureLevel&&(identical(other.level, level) || other.level == level)&&(identical(other.elapsed, elapsed) || other.elapsed == elapsed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,level,elapsed);
}

@override
String toString() {
    return 'ScreenCaptureEvent.level(level: $level, elapsed: $elapsed)';
}


}

/// @nodoc
abstract mixin class $ScreenCaptureLevelCopyWith<$Res> implements $ScreenCaptureEventCopyWith<$Res> {
  factory $ScreenCaptureLevelCopyWith(ScreenCaptureLevel value, $Res Function(ScreenCaptureLevel) _then) = _$ScreenCaptureLevelCopyWithImpl;
@useResult
$Res call({
 double level, Duration elapsed
});




}
/// @nodoc
class _$ScreenCaptureLevelCopyWithImpl<$Res>
    implements $ScreenCaptureLevelCopyWith<$Res> {
  _$ScreenCaptureLevelCopyWithImpl(this._self, this._then);

  final ScreenCaptureLevel _self;
  final $Res Function(ScreenCaptureLevel) _then;

/// Create a copy of ScreenCaptureEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? level = null,Object? elapsed = null,}) {
  return _then(ScreenCaptureLevel(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as double,elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc


class ScreenCaptureSilent implements ScreenCaptureEvent {
  const ScreenCaptureSilent();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenCaptureSilent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ScreenCaptureEvent.silent()';
}


}




/// @nodoc


class ScreenCaptureEnded implements ScreenCaptureEvent {
  const ScreenCaptureEnded({this.recording, this.failure});
  

 final  Recording? recording;
 final  Failure? failure;

/// Create a copy of ScreenCaptureEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScreenCaptureEndedCopyWith<ScreenCaptureEnded> get copyWith => _$ScreenCaptureEndedCopyWithImpl<ScreenCaptureEnded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenCaptureEnded&&(identical(other.recording, recording) || other.recording == recording)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,recording,failure);
}

@override
String toString() {
    return 'ScreenCaptureEvent.ended(recording: $recording, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ScreenCaptureEndedCopyWith<$Res> implements $ScreenCaptureEventCopyWith<$Res> {
  factory $ScreenCaptureEndedCopyWith(ScreenCaptureEnded value, $Res Function(ScreenCaptureEnded) _then) = _$ScreenCaptureEndedCopyWithImpl;
@useResult
$Res call({
 Recording? recording, Failure? failure
});


$RecordingCopyWith<$Res>? get recording;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ScreenCaptureEndedCopyWithImpl<$Res>
    implements $ScreenCaptureEndedCopyWith<$Res> {
  _$ScreenCaptureEndedCopyWithImpl(this._self, this._then);

  final ScreenCaptureEnded _self;
  final $Res Function(ScreenCaptureEnded) _then;

/// Create a copy of ScreenCaptureEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recording = freezed,Object? failure = freezed,}) {
  return _then(ScreenCaptureEnded(
recording: freezed == recording ? _self.recording : recording // ignore: cast_nullable_to_non_nullable
as Recording?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of ScreenCaptureEvent
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
}/// Create a copy of ScreenCaptureEvent
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

/// @nodoc
mixin _$ScreenCaptureSession {

 Duration get elapsed; bool get withMic;
/// Create a copy of ScreenCaptureSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScreenCaptureSessionCopyWith<ScreenCaptureSession> get copyWith => _$ScreenCaptureSessionCopyWithImpl<ScreenCaptureSession>(this as ScreenCaptureSession, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScreenCaptureSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenCaptureSession&&(identical(other.elapsed, _this.elapsed) || other.elapsed == _this.elapsed)&&(identical(other.withMic, _this.withMic) || other.withMic == _this.withMic));
}


@override
int get hashCode {
  final _this = this as ScreenCaptureSession;
  return Object.hash(runtimeType,_this.elapsed,_this.withMic);
}

@override
String toString() {
  final _this = this as ScreenCaptureSession;
  return 'ScreenCaptureSession(elapsed: ${_this.elapsed}, withMic: ${_this.withMic})';
}


}

/// @nodoc
abstract mixin class $ScreenCaptureSessionCopyWith<$Res>  {
  factory $ScreenCaptureSessionCopyWith(ScreenCaptureSession value, $Res Function(ScreenCaptureSession) _then) = _$ScreenCaptureSessionCopyWithImpl;
@useResult
$Res call({
 Duration elapsed, bool withMic
});




}
/// @nodoc
class _$ScreenCaptureSessionCopyWithImpl<$Res>
    implements $ScreenCaptureSessionCopyWith<$Res> {
  _$ScreenCaptureSessionCopyWithImpl(this._self, this._then);

  final ScreenCaptureSession _self;
  final $Res Function(ScreenCaptureSession) _then;

/// Create a copy of ScreenCaptureSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? elapsed = null,Object? withMic = null,}) {
  return _then(ScreenCaptureSession(
elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,withMic: null == withMic ? _self.withMic : withMic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScreenCaptureSession].
extension ScreenCaptureSessionPatterns on ScreenCaptureSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScreenCaptureSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScreenCaptureSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScreenCaptureSession value)  $default,){
final _that = this;
switch (_that) {
case _ScreenCaptureSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScreenCaptureSession value)?  $default,){
final _that = this;
switch (_that) {
case _ScreenCaptureSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration elapsed,  bool withMic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScreenCaptureSession() when $default != null:
return $default(_that.elapsed,_that.withMic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration elapsed,  bool withMic)  $default,) {final _that = this;
switch (_that) {
case _ScreenCaptureSession():
return $default(_that.elapsed,_that.withMic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration elapsed,  bool withMic)?  $default,) {final _that = this;
switch (_that) {
case _ScreenCaptureSession() when $default != null:
return $default(_that.elapsed,_that.withMic);case _:
  return null;

}
}

}

/// @nodoc


class _ScreenCaptureSession implements ScreenCaptureSession {
  const _ScreenCaptureSession({required this.elapsed, required this.withMic});
  

@override final  Duration elapsed;
@override final  bool withMic;

/// Create a copy of ScreenCaptureSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScreenCaptureSessionCopyWith<_ScreenCaptureSession> get copyWith => __$ScreenCaptureSessionCopyWithImpl<_ScreenCaptureSession>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScreenCaptureSession&&(identical(other.elapsed, elapsed) || other.elapsed == elapsed)&&(identical(other.withMic, withMic) || other.withMic == withMic));
}


@override
int get hashCode {
    return Object.hash(runtimeType,elapsed,withMic);
}

@override
String toString() {
    return 'ScreenCaptureSession(elapsed: $elapsed, withMic: $withMic)';
}


}

/// @nodoc
abstract mixin class _$ScreenCaptureSessionCopyWith<$Res> implements $ScreenCaptureSessionCopyWith<$Res> {
  factory _$ScreenCaptureSessionCopyWith(_ScreenCaptureSession value, $Res Function(_ScreenCaptureSession) _then) = __$ScreenCaptureSessionCopyWithImpl;
@override @useResult
$Res call({
 Duration elapsed, bool withMic
});




}
/// @nodoc
class __$ScreenCaptureSessionCopyWithImpl<$Res>
    implements _$ScreenCaptureSessionCopyWith<$Res> {
  __$ScreenCaptureSessionCopyWithImpl(this._self, this._then);

  final _ScreenCaptureSession _self;
  final $Res Function(_ScreenCaptureSession) _then;

/// Create a copy of ScreenCaptureSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? elapsed = null,Object? withMic = null,}) {
  return _then(_ScreenCaptureSession(
elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,withMic: null == withMic ? _self.withMic : withMic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
