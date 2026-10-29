// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BalanceState {

 BalanceStatus get status; String? get workspaceId; Balance? get balance; Failure? get failure;
/// Create a copy of BalanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceStateCopyWith<BalanceState> get copyWith => _$BalanceStateCopyWithImpl<BalanceState>(this as BalanceState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BalanceState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.workspaceId, _this.workspaceId) || other.workspaceId == _this.workspaceId)&&(identical(other.balance, _this.balance) || other.balance == _this.balance)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as BalanceState;
  return Object.hash(runtimeType,_this.status,_this.workspaceId,_this.balance,_this.failure);
}

@override
String toString() {
  final _this = this as BalanceState;
  return 'BalanceState(status: ${_this.status}, workspaceId: ${_this.workspaceId}, balance: ${_this.balance}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $BalanceStateCopyWith<$Res>  {
  factory $BalanceStateCopyWith(BalanceState value, $Res Function(BalanceState) _then) = _$BalanceStateCopyWithImpl;
@useResult
$Res call({
 BalanceStatus status, String? workspaceId, Balance? balance, Failure? failure
});


$BalanceCopyWith<$Res>? get balance;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$BalanceStateCopyWithImpl<$Res>
    implements $BalanceStateCopyWith<$Res> {
  _$BalanceStateCopyWithImpl(this._self, this._then);

  final BalanceState _self;
  final $Res Function(BalanceState) _then;

/// Create a copy of BalanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? workspaceId = freezed,Object? balance = freezed,Object? failure = freezed,}) {
  return _then(BalanceState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BalanceStatus,workspaceId: freezed == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as Balance?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of BalanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceCopyWith<$Res>? get balance {
    if (_self.balance == null) {
    return null;
  }

  return $BalanceCopyWith<$Res>(_self.balance!, (value) {
    return _then(_self.copyWith(balance: value));
  });
}/// Create a copy of BalanceState
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


/// Adds pattern-matching-related methods to [BalanceState].
extension BalanceStatePatterns on BalanceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalanceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalanceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalanceState value)  $default,){
final _that = this;
switch (_that) {
case _BalanceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalanceState value)?  $default,){
final _that = this;
switch (_that) {
case _BalanceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BalanceStatus status,  String? workspaceId,  Balance? balance,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalanceState() when $default != null:
return $default(_that.status,_that.workspaceId,_that.balance,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BalanceStatus status,  String? workspaceId,  Balance? balance,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _BalanceState():
return $default(_that.status,_that.workspaceId,_that.balance,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BalanceStatus status,  String? workspaceId,  Balance? balance,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _BalanceState() when $default != null:
return $default(_that.status,_that.workspaceId,_that.balance,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _BalanceState implements BalanceState {
  const _BalanceState({this.status = BalanceStatus.initial, this.workspaceId, this.balance, this.failure});
  

@override@JsonKey() final  BalanceStatus status;
@override final  String? workspaceId;
@override final  Balance? balance;
@override final  Failure? failure;

/// Create a copy of BalanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceStateCopyWith<_BalanceState> get copyWith => __$BalanceStateCopyWithImpl<_BalanceState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceState&&(identical(other.status, status) || other.status == status)&&(identical(other.workspaceId, workspaceId) || other.workspaceId == workspaceId)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,workspaceId,balance,failure);
}

@override
String toString() {
    return 'BalanceState(status: $status, workspaceId: $workspaceId, balance: $balance, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$BalanceStateCopyWith<$Res> implements $BalanceStateCopyWith<$Res> {
  factory _$BalanceStateCopyWith(_BalanceState value, $Res Function(_BalanceState) _then) = __$BalanceStateCopyWithImpl;
@override @useResult
$Res call({
 BalanceStatus status, String? workspaceId, Balance? balance, Failure? failure
});


@override $BalanceCopyWith<$Res>? get balance;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$BalanceStateCopyWithImpl<$Res>
    implements _$BalanceStateCopyWith<$Res> {
  __$BalanceStateCopyWithImpl(this._self, this._then);

  final _BalanceState _self;
  final $Res Function(_BalanceState) _then;

/// Create a copy of BalanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? workspaceId = freezed,Object? balance = freezed,Object? failure = freezed,}) {
  return _then(_BalanceState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BalanceStatus,workspaceId: freezed == workspaceId ? _self.workspaceId : workspaceId // ignore: cast_nullable_to_non_nullable
as String?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as Balance?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of BalanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceCopyWith<$Res>? get balance {
    if (_self.balance == null) {
    return null;
  }

  return $BalanceCopyWith<$Res>(_self.balance!, (value) {
    return _then(_self.copyWith(balance: value));
  });
}/// Create a copy of BalanceState
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
