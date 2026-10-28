// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {

 LoginStatus get status; bool get emailMissing; bool get passwordMissing; Account? get account; Failure? get failure;/// The backend's Google web client id; null hides the Google button
/// (off on the server, or the check failed).
 String? get googleClientId;/// The last attempt was Google's, so a 401 is not a wrong password.
 bool get viaGoogle;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LoginState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.emailMissing, _this.emailMissing) || other.emailMissing == _this.emailMissing)&&(identical(other.passwordMissing, _this.passwordMissing) || other.passwordMissing == _this.passwordMissing)&&(identical(other.account, _this.account) || other.account == _this.account)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.googleClientId, _this.googleClientId) || other.googleClientId == _this.googleClientId)&&(identical(other.viaGoogle, _this.viaGoogle) || other.viaGoogle == _this.viaGoogle));
}


@override
int get hashCode {
  final _this = this as LoginState;
  return Object.hash(runtimeType,_this.status,_this.emailMissing,_this.passwordMissing,_this.account,_this.failure,_this.googleClientId,_this.viaGoogle);
}

@override
String toString() {
  final _this = this as LoginState;
  return 'LoginState(status: ${_this.status}, emailMissing: ${_this.emailMissing}, passwordMissing: ${_this.passwordMissing}, account: ${_this.account}, failure: ${_this.failure}, googleClientId: ${_this.googleClientId}, viaGoogle: ${_this.viaGoogle})';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 LoginStatus status, bool emailMissing, bool passwordMissing, Account? account, Failure? failure, String? googleClientId, bool viaGoogle
});


$AccountCopyWith<$Res>? get account;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? emailMissing = null,Object? passwordMissing = null,Object? account = freezed,Object? failure = freezed,Object? googleClientId = freezed,Object? viaGoogle = null,}) {
  return _then(LoginState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoginStatus,emailMissing: null == emailMissing ? _self.emailMissing : emailMissing // ignore: cast_nullable_to_non_nullable
as bool,passwordMissing: null == passwordMissing ? _self.passwordMissing : passwordMissing // ignore: cast_nullable_to_non_nullable
as bool,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as Account?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,googleClientId: freezed == googleClientId ? _self.googleClientId : googleClientId // ignore: cast_nullable_to_non_nullable
as String?,viaGoogle: null == viaGoogle ? _self.viaGoogle : viaGoogle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LoginState
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
}/// Create a copy of LoginState
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


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginState value)  $default,){
final _that = this;
switch (_that) {
case _LoginState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoginStatus status,  bool emailMissing,  bool passwordMissing,  Account? account,  Failure? failure,  String? googleClientId,  bool viaGoogle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.status,_that.emailMissing,_that.passwordMissing,_that.account,_that.failure,_that.googleClientId,_that.viaGoogle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoginStatus status,  bool emailMissing,  bool passwordMissing,  Account? account,  Failure? failure,  String? googleClientId,  bool viaGoogle)  $default,) {final _that = this;
switch (_that) {
case _LoginState():
return $default(_that.status,_that.emailMissing,_that.passwordMissing,_that.account,_that.failure,_that.googleClientId,_that.viaGoogle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoginStatus status,  bool emailMissing,  bool passwordMissing,  Account? account,  Failure? failure,  String? googleClientId,  bool viaGoogle)?  $default,) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.status,_that.emailMissing,_that.passwordMissing,_that.account,_that.failure,_that.googleClientId,_that.viaGoogle);case _:
  return null;

}
}

}

/// @nodoc


class _LoginState implements LoginState {
  const _LoginState({this.status = LoginStatus.initial, this.emailMissing = false, this.passwordMissing = false, this.account, this.failure, this.googleClientId, this.viaGoogle = false});
  

@override@JsonKey() final  LoginStatus status;
@override@JsonKey() final  bool emailMissing;
@override@JsonKey() final  bool passwordMissing;
@override final  Account? account;
@override final  Failure? failure;
/// The backend's Google web client id; null hides the Google button
/// (off on the server, or the check failed).
@override final  String? googleClientId;
/// The last attempt was Google's, so a 401 is not a wrong password.
@override@JsonKey() final  bool viaGoogle;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.status, status) || other.status == status)&&(identical(other.emailMissing, emailMissing) || other.emailMissing == emailMissing)&&(identical(other.passwordMissing, passwordMissing) || other.passwordMissing == passwordMissing)&&(identical(other.account, account) || other.account == account)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.googleClientId, googleClientId) || other.googleClientId == googleClientId)&&(identical(other.viaGoogle, viaGoogle) || other.viaGoogle == viaGoogle));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,emailMissing,passwordMissing,account,failure,googleClientId,viaGoogle);
}

@override
String toString() {
    return 'LoginState(status: $status, emailMissing: $emailMissing, passwordMissing: $passwordMissing, account: $account, failure: $failure, googleClientId: $googleClientId, viaGoogle: $viaGoogle)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 LoginStatus status, bool emailMissing, bool passwordMissing, Account? account, Failure? failure, String? googleClientId, bool viaGoogle
});


@override $AccountCopyWith<$Res>? get account;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? emailMissing = null,Object? passwordMissing = null,Object? account = freezed,Object? failure = freezed,Object? googleClientId = freezed,Object? viaGoogle = null,}) {
  return _then(_LoginState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoginStatus,emailMissing: null == emailMissing ? _self.emailMissing : emailMissing // ignore: cast_nullable_to_non_nullable
as bool,passwordMissing: null == passwordMissing ? _self.passwordMissing : passwordMissing // ignore: cast_nullable_to_non_nullable
as bool,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as Account?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,googleClientId: freezed == googleClientId ? _self.googleClientId : googleClientId // ignore: cast_nullable_to_non_nullable
as String?,viaGoogle: null == viaGoogle ? _self.viaGoogle : viaGoogle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LoginState
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
}/// Create a copy of LoginState
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
