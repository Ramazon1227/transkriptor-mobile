// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learn_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LearnState {

 LearnStatus get status; LearnSets get sets; LearnCreateStatus get createStatus; Failure? get failure;
/// Create a copy of LearnState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnStateCopyWith<LearnState> get copyWith => _$LearnStateCopyWithImpl<LearnState>(this as LearnState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LearnState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.sets, _this.sets) || other.sets == _this.sets)&&(identical(other.createStatus, _this.createStatus) || other.createStatus == _this.createStatus)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as LearnState;
  return Object.hash(runtimeType,_this.status,_this.sets,_this.createStatus,_this.failure);
}

@override
String toString() {
  final _this = this as LearnState;
  return 'LearnState(status: ${_this.status}, sets: ${_this.sets}, createStatus: ${_this.createStatus}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $LearnStateCopyWith<$Res>  {
  factory $LearnStateCopyWith(LearnState value, $Res Function(LearnState) _then) = _$LearnStateCopyWithImpl;
@useResult
$Res call({
 LearnStatus status, LearnSets sets, LearnCreateStatus createStatus, Failure? failure
});


$LearnSetsCopyWith<$Res> get sets;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$LearnStateCopyWithImpl<$Res>
    implements $LearnStateCopyWith<$Res> {
  _$LearnStateCopyWithImpl(this._self, this._then);

  final LearnState _self;
  final $Res Function(LearnState) _then;

/// Create a copy of LearnState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? sets = null,Object? createStatus = null,Object? failure = freezed,}) {
  return _then(LearnState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearnStatus,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as LearnSets,createStatus: null == createStatus ? _self.createStatus : createStatus // ignore: cast_nullable_to_non_nullable
as LearnCreateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of LearnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LearnSetsCopyWith<$Res> get sets {
  
  return $LearnSetsCopyWith<$Res>(_self.sets, (value) {
    return _then(_self.copyWith(sets: value));
  });
}/// Create a copy of LearnState
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


/// Adds pattern-matching-related methods to [LearnState].
extension LearnStatePatterns on LearnState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearnState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearnState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearnState value)  $default,){
final _that = this;
switch (_that) {
case _LearnState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearnState value)?  $default,){
final _that = this;
switch (_that) {
case _LearnState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LearnStatus status,  LearnSets sets,  LearnCreateStatus createStatus,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearnState() when $default != null:
return $default(_that.status,_that.sets,_that.createStatus,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LearnStatus status,  LearnSets sets,  LearnCreateStatus createStatus,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _LearnState():
return $default(_that.status,_that.sets,_that.createStatus,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LearnStatus status,  LearnSets sets,  LearnCreateStatus createStatus,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _LearnState() when $default != null:
return $default(_that.status,_that.sets,_that.createStatus,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _LearnState implements LearnState {
  const _LearnState({this.status = LearnStatus.initial, this.sets = const LearnSets(), this.createStatus = LearnCreateStatus.idle, this.failure});
  

@override@JsonKey() final  LearnStatus status;
@override@JsonKey() final  LearnSets sets;
@override@JsonKey() final  LearnCreateStatus createStatus;
@override final  Failure? failure;

/// Create a copy of LearnState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearnStateCopyWith<_LearnState> get copyWith => __$LearnStateCopyWithImpl<_LearnState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearnState&&(identical(other.status, status) || other.status == status)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.createStatus, createStatus) || other.createStatus == createStatus)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,sets,createStatus,failure);
}

@override
String toString() {
    return 'LearnState(status: $status, sets: $sets, createStatus: $createStatus, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$LearnStateCopyWith<$Res> implements $LearnStateCopyWith<$Res> {
  factory _$LearnStateCopyWith(_LearnState value, $Res Function(_LearnState) _then) = __$LearnStateCopyWithImpl;
@override @useResult
$Res call({
 LearnStatus status, LearnSets sets, LearnCreateStatus createStatus, Failure? failure
});


@override $LearnSetsCopyWith<$Res> get sets;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$LearnStateCopyWithImpl<$Res>
    implements _$LearnStateCopyWith<$Res> {
  __$LearnStateCopyWithImpl(this._self, this._then);

  final _LearnState _self;
  final $Res Function(_LearnState) _then;

/// Create a copy of LearnState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? sets = null,Object? createStatus = null,Object? failure = freezed,}) {
  return _then(_LearnState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearnStatus,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as LearnSets,createStatus: null == createStatus ? _self.createStatus : createStatus // ignore: cast_nullable_to_non_nullable
as LearnCreateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of LearnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LearnSetsCopyWith<$Res> get sets {
  
  return $LearnSetsCopyWith<$Res>(_self.sets, (value) {
    return _then(_self.copyWith(sets: value));
  });
}/// Create a copy of LearnState
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
