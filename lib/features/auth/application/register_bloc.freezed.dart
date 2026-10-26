// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterState {

 RegisterStatus get status; bool get emailInvalid;/// Null when the password passes the backend's rules.
 PasswordProblem? get passwordProblem; Account? get account; Failure? get failure;
/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterStateCopyWith<RegisterState> get copyWith => _$RegisterStateCopyWithImpl<RegisterState>(this as RegisterState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RegisterState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.emailInvalid, _this.emailInvalid) || other.emailInvalid == _this.emailInvalid)&&(identical(other.passwordProblem, _this.passwordProblem) || other.passwordProblem == _this.passwordProblem)&&(identical(other.account, _this.account) || other.account == _this.account)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as RegisterState;
  return Object.hash(runtimeType,_this.status,_this.emailInvalid,_this.passwordProblem,_this.account,_this.failure);
}

@override
String toString() {
  final _this = this as RegisterState;
  return 'RegisterState(status: ${_this.status}, emailInvalid: ${_this.emailInvalid}, passwordProblem: ${_this.passwordProblem}, account: ${_this.account}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $RegisterStateCopyWith<$Res>  {
  factory $RegisterStateCopyWith(RegisterState value, $Res Function(RegisterState) _then) = _$RegisterStateCopyWithImpl;
@useResult
$Res call({
 RegisterStatus status, bool emailInvalid, PasswordProblem? passwordProblem, Account? account, Failure? failure
});


$AccountCopyWith<$Res>? get account;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$RegisterStateCopyWithImpl<$Res>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._self, this._then);

  final RegisterState _self;
  final $Res Function(RegisterState) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? emailInvalid = null,Object? passwordProblem = freezed,Object? account = freezed,Object? failure = freezed,}) {
  return _then(RegisterState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RegisterStatus,emailInvalid: null == emailInvalid ? _self.emailInvalid : emailInvalid // ignore: cast_nullable_to_non_nullable
as bool,passwordProblem: freezed == passwordProblem ? _self.passwordProblem : passwordProblem // ignore: cast_nullable_to_non_nullable
as PasswordProblem?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as Account?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $AccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of RegisterState
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


/// Adds pattern-matching-related methods to [RegisterState].
extension RegisterStatePatterns on RegisterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterState value)  $default,){
final _that = this;
switch (_that) {
case _RegisterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterState value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RegisterStatus status,  bool emailInvalid,  PasswordProblem? passwordProblem,  Account? account,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterState() when $default != null:
return $default(_that.status,_that.emailInvalid,_that.passwordProblem,_that.account,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RegisterStatus status,  bool emailInvalid,  PasswordProblem? passwordProblem,  Account? account,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _RegisterState():
return $default(_that.status,_that.emailInvalid,_that.passwordProblem,_that.account,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RegisterStatus status,  bool emailInvalid,  PasswordProblem? passwordProblem,  Account? account,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RegisterState() when $default != null:
return $default(_that.status,_that.emailInvalid,_that.passwordProblem,_that.account,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RegisterState implements RegisterState {
  const _RegisterState({this.status = RegisterStatus.initial, this.emailInvalid = false, this.passwordProblem, this.account, this.failure});
  

@override@JsonKey() final  RegisterStatus status;
@override@JsonKey() final  bool emailInvalid;
/// Null when the password passes the backend's rules.
@override final  PasswordProblem? passwordProblem;
@override final  Account? account;
@override final  Failure? failure;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterStateCopyWith<_RegisterState> get copyWith => __$RegisterStateCopyWithImpl<_RegisterState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterState&&(identical(other.status, status) || other.status == status)&&(identical(other.emailInvalid, emailInvalid) || other.emailInvalid == emailInvalid)&&(identical(other.passwordProblem, passwordProblem) || other.passwordProblem == passwordProblem)&&(identical(other.account, account) || other.account == account)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,emailInvalid,passwordProblem,account,failure);
}

@override
String toString() {
    return 'RegisterState(status: $status, emailInvalid: $emailInvalid, passwordProblem: $passwordProblem, account: $account, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RegisterStateCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory _$RegisterStateCopyWith(_RegisterState value, $Res Function(_RegisterState) _then) = __$RegisterStateCopyWithImpl;
@override @useResult
$Res call({
 RegisterStatus status, bool emailInvalid, PasswordProblem? passwordProblem, Account? account, Failure? failure
});


@override $AccountCopyWith<$Res>? get account;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$RegisterStateCopyWithImpl<$Res>
    implements _$RegisterStateCopyWith<$Res> {
  __$RegisterStateCopyWithImpl(this._self, this._then);

  final _RegisterState _self;
  final $Res Function(_RegisterState) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? emailInvalid = null,Object? passwordProblem = freezed,Object? account = freezed,Object? failure = freezed,}) {
  return _then(_RegisterState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RegisterStatus,emailInvalid: null == emailInvalid ? _self.emailInvalid : emailInvalid // ignore: cast_nullable_to_non_nullable
as bool,passwordProblem: freezed == passwordProblem ? _self.passwordProblem : passwordProblem // ignore: cast_nullable_to_non_nullable
as PasswordProblem?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as Account?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $AccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of RegisterState
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
