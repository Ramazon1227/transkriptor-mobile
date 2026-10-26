// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recorder_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecorderState {

 RecorderStatus get status; Duration get elapsed;/// Most recent last, each 0–1.
 List<double> get levels; Recording? get recording; Failure? get failure;
/// Create a copy of RecorderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecorderStateCopyWith<RecorderState> get copyWith => _$RecorderStateCopyWithImpl<RecorderState>(this as RecorderState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecorderState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecorderState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.elapsed, _this.elapsed) || other.elapsed == _this.elapsed)&&const DeepCollectionEquality().equals(other.levels, _this.levels)&&(identical(other.recording, _this.recording) || other.recording == _this.recording)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as RecorderState;
  return Object.hash(runtimeType,_this.status,_this.elapsed,const DeepCollectionEquality().hash(_this.levels),_this.recording,_this.failure);
}

@override
String toString() {
  final _this = this as RecorderState;
  return 'RecorderState(status: ${_this.status}, elapsed: ${_this.elapsed}, levels: ${_this.levels}, recording: ${_this.recording}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $RecorderStateCopyWith<$Res>  {
  factory $RecorderStateCopyWith(RecorderState value, $Res Function(RecorderState) _then) = _$RecorderStateCopyWithImpl;
@useResult
$Res call({
 RecorderStatus status, Duration elapsed, List<double> levels, Recording? recording, Failure? failure
});


$RecordingCopyWith<$Res>? get recording;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$RecorderStateCopyWithImpl<$Res>
    implements $RecorderStateCopyWith<$Res> {
  _$RecorderStateCopyWithImpl(this._self, this._then);

  final RecorderState _self;
  final $Res Function(RecorderState) _then;

/// Create a copy of RecorderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? elapsed = null,Object? levels = null,Object? recording = freezed,Object? failure = freezed,}) {
  return _then(RecorderState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecorderStatus,elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,levels: null == levels ? _self.levels : levels // ignore: cast_nullable_to_non_nullable
as List<double>,recording: freezed == recording ? _self.recording : recording // ignore: cast_nullable_to_non_nullable
as Recording?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of RecorderState
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
}/// Create a copy of RecorderState
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


/// Adds pattern-matching-related methods to [RecorderState].
extension RecorderStatePatterns on RecorderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecorderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecorderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecorderState value)  $default,){
final _that = this;
switch (_that) {
case _RecorderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecorderState value)?  $default,){
final _that = this;
switch (_that) {
case _RecorderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecorderStatus status,  Duration elapsed,  List<double> levels,  Recording? recording,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecorderState() when $default != null:
return $default(_that.status,_that.elapsed,_that.levels,_that.recording,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecorderStatus status,  Duration elapsed,  List<double> levels,  Recording? recording,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _RecorderState():
return $default(_that.status,_that.elapsed,_that.levels,_that.recording,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecorderStatus status,  Duration elapsed,  List<double> levels,  Recording? recording,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RecorderState() when $default != null:
return $default(_that.status,_that.elapsed,_that.levels,_that.recording,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RecorderState implements RecorderState {
  const _RecorderState({this.status = RecorderStatus.idle, this.elapsed = Duration.zero,  List<double> levels = const <double>[], this.recording, this.failure}): _levels = levels;
  

@override@JsonKey() final  RecorderStatus status;
@override@JsonKey() final  Duration elapsed;
/// Most recent last, each 0–1.
 final  List<double> _levels;
/// Most recent last, each 0–1.
@override@JsonKey() List<double> get levels {
  if (_levels is EqualUnmodifiableListView) return _levels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_levels);
}

@override final  Recording? recording;
@override final  Failure? failure;

/// Create a copy of RecorderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecorderStateCopyWith<_RecorderState> get copyWith => __$RecorderStateCopyWithImpl<_RecorderState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecorderState&&(identical(other.status, status) || other.status == status)&&(identical(other.elapsed, elapsed) || other.elapsed == elapsed)&&const DeepCollectionEquality().equals(other.levels, _levels)&&(identical(other.recording, recording) || other.recording == recording)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,elapsed,const DeepCollectionEquality().hash(_levels),recording,failure);
}

@override
String toString() {
    return 'RecorderState(status: $status, elapsed: $elapsed, levels: $levels, recording: $recording, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RecorderStateCopyWith<$Res> implements $RecorderStateCopyWith<$Res> {
  factory _$RecorderStateCopyWith(_RecorderState value, $Res Function(_RecorderState) _then) = __$RecorderStateCopyWithImpl;
@override @useResult
$Res call({
 RecorderStatus status, Duration elapsed, List<double> levels, Recording? recording, Failure? failure
});


@override $RecordingCopyWith<$Res>? get recording;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$RecorderStateCopyWithImpl<$Res>
    implements _$RecorderStateCopyWith<$Res> {
  __$RecorderStateCopyWithImpl(this._self, this._then);

  final _RecorderState _self;
  final $Res Function(_RecorderState) _then;

/// Create a copy of RecorderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? elapsed = null,Object? levels = null,Object? recording = freezed,Object? failure = freezed,}) {
  return _then(_RecorderState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecorderStatus,elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,levels: null == levels ? _self._levels : levels // ignore: cast_nullable_to_non_nullable
as List<double>,recording: freezed == recording ? _self.recording : recording // ignore: cast_nullable_to_non_nullable
as Recording?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of RecorderState
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
}/// Create a copy of RecorderState
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
