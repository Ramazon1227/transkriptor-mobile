// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plans_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlansState {

 PlansStatus get status; List<Plan> get plans; Failure? get failure;
/// Create a copy of PlansState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlansStateCopyWith<PlansState> get copyWith => _$PlansStateCopyWithImpl<PlansState>(this as PlansState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlansState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlansState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.plans, _this.plans)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as PlansState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.plans),_this.failure);
}

@override
String toString() {
  final _this = this as PlansState;
  return 'PlansState(status: ${_this.status}, plans: ${_this.plans}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $PlansStateCopyWith<$Res>  {
  factory $PlansStateCopyWith(PlansState value, $Res Function(PlansState) _then) = _$PlansStateCopyWithImpl;
@useResult
$Res call({
 PlansStatus status, List<Plan> plans, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$PlansStateCopyWithImpl<$Res>
    implements $PlansStateCopyWith<$Res> {
  _$PlansStateCopyWithImpl(this._self, this._then);

  final PlansState _self;
  final $Res Function(PlansState) _then;

/// Create a copy of PlansState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? plans = null,Object? failure = freezed,}) {
  return _then(PlansState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlansStatus,plans: null == plans ? _self.plans : plans // ignore: cast_nullable_to_non_nullable
as List<Plan>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of PlansState
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


/// Adds pattern-matching-related methods to [PlansState].
extension PlansStatePatterns on PlansState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlansState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlansState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlansState value)  $default,){
final _that = this;
switch (_that) {
case _PlansState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlansState value)?  $default,){
final _that = this;
switch (_that) {
case _PlansState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlansStatus status,  List<Plan> plans,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlansState() when $default != null:
return $default(_that.status,_that.plans,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlansStatus status,  List<Plan> plans,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _PlansState():
return $default(_that.status,_that.plans,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlansStatus status,  List<Plan> plans,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _PlansState() when $default != null:
return $default(_that.status,_that.plans,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _PlansState implements PlansState {
  const _PlansState({this.status = PlansStatus.initial,  List<Plan> plans = const <Plan>[], this.failure}): _plans = plans;
  

@override@JsonKey() final  PlansStatus status;
 final  List<Plan> _plans;
@override@JsonKey() List<Plan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}

@override final  Failure? failure;

/// Create a copy of PlansState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlansStateCopyWith<_PlansState> get copyWith => __$PlansStateCopyWithImpl<_PlansState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlansState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.plans, _plans)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_plans),failure);
}

@override
String toString() {
    return 'PlansState(status: $status, plans: $plans, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$PlansStateCopyWith<$Res> implements $PlansStateCopyWith<$Res> {
  factory _$PlansStateCopyWith(_PlansState value, $Res Function(_PlansState) _then) = __$PlansStateCopyWithImpl;
@override @useResult
$Res call({
 PlansStatus status, List<Plan> plans, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$PlansStateCopyWithImpl<$Res>
    implements _$PlansStateCopyWith<$Res> {
  __$PlansStateCopyWithImpl(this._self, this._then);

  final _PlansState _self;
  final $Res Function(_PlansState) _then;

/// Create a copy of PlansState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? plans = null,Object? failure = freezed,}) {
  return _then(_PlansState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlansStatus,plans: null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<Plan>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of PlansState
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
