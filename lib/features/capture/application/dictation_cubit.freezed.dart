// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dictation_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DictationState {

 DictationStatus get status;/// Settled sentences, in order.
 List<String> get finals;/// The sentence still being heard; shown muted.
 String get partial; Duration get elapsed;/// Of the last save; the text stays.
 Failure? get failure;
/// Create a copy of DictationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DictationStateCopyWith<DictationState> get copyWith => _$DictationStateCopyWithImpl<DictationState>(this as DictationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DictationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DictationState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.finals, _this.finals)&&(identical(other.partial, _this.partial) || other.partial == _this.partial)&&(identical(other.elapsed, _this.elapsed) || other.elapsed == _this.elapsed)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as DictationState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.finals),_this.partial,_this.elapsed,_this.failure);
}

@override
String toString() {
  final _this = this as DictationState;
  return 'DictationState(status: ${_this.status}, finals: ${_this.finals}, partial: ${_this.partial}, elapsed: ${_this.elapsed}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $DictationStateCopyWith<$Res>  {
  factory $DictationStateCopyWith(DictationState value, $Res Function(DictationState) _then) = _$DictationStateCopyWithImpl;
@useResult
$Res call({
 DictationStatus status, List<String> finals, String partial, Duration elapsed, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$DictationStateCopyWithImpl<$Res>
    implements $DictationStateCopyWith<$Res> {
  _$DictationStateCopyWithImpl(this._self, this._then);

  final DictationState _self;
  final $Res Function(DictationState) _then;

/// Create a copy of DictationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? finals = null,Object? partial = null,Object? elapsed = null,Object? failure = freezed,}) {
  return _then(DictationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DictationStatus,finals: null == finals ? _self.finals : finals // ignore: cast_nullable_to_non_nullable
as List<String>,partial: null == partial ? _self.partial : partial // ignore: cast_nullable_to_non_nullable
as String,elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of DictationState
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


/// Adds pattern-matching-related methods to [DictationState].
extension DictationStatePatterns on DictationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DictationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DictationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DictationState value)  $default,){
final _that = this;
switch (_that) {
case _DictationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DictationState value)?  $default,){
final _that = this;
switch (_that) {
case _DictationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DictationStatus status,  List<String> finals,  String partial,  Duration elapsed,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DictationState() when $default != null:
return $default(_that.status,_that.finals,_that.partial,_that.elapsed,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DictationStatus status,  List<String> finals,  String partial,  Duration elapsed,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _DictationState():
return $default(_that.status,_that.finals,_that.partial,_that.elapsed,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DictationStatus status,  List<String> finals,  String partial,  Duration elapsed,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _DictationState() when $default != null:
return $default(_that.status,_that.finals,_that.partial,_that.elapsed,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _DictationState extends DictationState {
  const _DictationState({this.status = DictationStatus.idle,  List<String> finals = const <String>[], this.partial = '', this.elapsed = Duration.zero, this.failure}): _finals = finals,super._();
  

@override@JsonKey() final  DictationStatus status;
/// Settled sentences, in order.
 final  List<String> _finals;
/// Settled sentences, in order.
@override@JsonKey() List<String> get finals {
  if (_finals is EqualUnmodifiableListView) return _finals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_finals);
}

/// The sentence still being heard; shown muted.
@override@JsonKey() final  String partial;
@override@JsonKey() final  Duration elapsed;
/// Of the last save; the text stays.
@override final  Failure? failure;

/// Create a copy of DictationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DictationStateCopyWith<_DictationState> get copyWith => __$DictationStateCopyWithImpl<_DictationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DictationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.finals, _finals)&&(identical(other.partial, partial) || other.partial == partial)&&(identical(other.elapsed, elapsed) || other.elapsed == elapsed)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_finals),partial,elapsed,failure);
}

@override
String toString() {
    return 'DictationState(status: $status, finals: $finals, partial: $partial, elapsed: $elapsed, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DictationStateCopyWith<$Res> implements $DictationStateCopyWith<$Res> {
  factory _$DictationStateCopyWith(_DictationState value, $Res Function(_DictationState) _then) = __$DictationStateCopyWithImpl;
@override @useResult
$Res call({
 DictationStatus status, List<String> finals, String partial, Duration elapsed, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$DictationStateCopyWithImpl<$Res>
    implements _$DictationStateCopyWith<$Res> {
  __$DictationStateCopyWithImpl(this._self, this._then);

  final _DictationState _self;
  final $Res Function(_DictationState) _then;

/// Create a copy of DictationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? finals = null,Object? partial = null,Object? elapsed = null,Object? failure = freezed,}) {
  return _then(_DictationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DictationStatus,finals: null == finals ? _self._finals : finals // ignore: cast_nullable_to_non_nullable
as List<String>,partial: null == partial ? _self.partial : partial // ignore: cast_nullable_to_non_nullable
as String,elapsed: null == elapsed ? _self.elapsed : elapsed // ignore: cast_nullable_to_non_nullable
as Duration,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of DictationState
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
