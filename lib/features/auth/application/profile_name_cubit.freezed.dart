// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_name_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileNameState {

 ProfileNameStatus get status;/// The name did not pass [NameRules]; nothing was sent.
 NameError? get invalid; Failure? get failure;/// The account as the server stored it, after a success.
 AppUser? get user;
/// Create a copy of ProfileNameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileNameStateCopyWith<ProfileNameState> get copyWith => _$ProfileNameStateCopyWithImpl<ProfileNameState>(this as ProfileNameState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileNameState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileNameState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.invalid, _this.invalid) || other.invalid == _this.invalid)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.user, _this.user) || other.user == _this.user));
}


@override
int get hashCode {
  final _this = this as ProfileNameState;
  return Object.hash(runtimeType,_this.status,_this.invalid,_this.failure,_this.user);
}

@override
String toString() {
  final _this = this as ProfileNameState;
  return 'ProfileNameState(status: ${_this.status}, invalid: ${_this.invalid}, failure: ${_this.failure}, user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $ProfileNameStateCopyWith<$Res>  {
  factory $ProfileNameStateCopyWith(ProfileNameState value, $Res Function(ProfileNameState) _then) = _$ProfileNameStateCopyWithImpl;
@useResult
$Res call({
 ProfileNameStatus status, NameError? invalid, Failure? failure, AppUser? user
});


$FailureCopyWith<$Res>? get failure;$AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class _$ProfileNameStateCopyWithImpl<$Res>
    implements $ProfileNameStateCopyWith<$Res> {
  _$ProfileNameStateCopyWithImpl(this._self, this._then);

  final ProfileNameState _self;
  final $Res Function(ProfileNameState) _then;

/// Create a copy of ProfileNameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? invalid = freezed,Object? failure = freezed,Object? user = freezed,}) {
  return _then(ProfileNameState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileNameStatus,invalid: freezed == invalid ? _self.invalid : invalid // ignore: cast_nullable_to_non_nullable
as NameError?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,
  ));
}
/// Create a copy of ProfileNameState
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
}/// Create a copy of ProfileNameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AppUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileNameState].
extension ProfileNameStatePatterns on ProfileNameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileNameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileNameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileNameState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileNameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileNameState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileNameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfileNameStatus status,  NameError? invalid,  Failure? failure,  AppUser? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileNameState() when $default != null:
return $default(_that.status,_that.invalid,_that.failure,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfileNameStatus status,  NameError? invalid,  Failure? failure,  AppUser? user)  $default,) {final _that = this;
switch (_that) {
case _ProfileNameState():
return $default(_that.status,_that.invalid,_that.failure,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfileNameStatus status,  NameError? invalid,  Failure? failure,  AppUser? user)?  $default,) {final _that = this;
switch (_that) {
case _ProfileNameState() when $default != null:
return $default(_that.status,_that.invalid,_that.failure,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileNameState implements ProfileNameState {
  const _ProfileNameState({this.status = ProfileNameStatus.initial, this.invalid, this.failure, this.user});
  

@override@JsonKey() final  ProfileNameStatus status;
/// The name did not pass [NameRules]; nothing was sent.
@override final  NameError? invalid;
@override final  Failure? failure;
/// The account as the server stored it, after a success.
@override final  AppUser? user;

/// Create a copy of ProfileNameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileNameStateCopyWith<_ProfileNameState> get copyWith => __$ProfileNameStateCopyWithImpl<_ProfileNameState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileNameState&&(identical(other.status, status) || other.status == status)&&(identical(other.invalid, invalid) || other.invalid == invalid)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,invalid,failure,user);
}

@override
String toString() {
    return 'ProfileNameState(status: $status, invalid: $invalid, failure: $failure, user: $user)';
}


}

/// @nodoc
abstract mixin class _$ProfileNameStateCopyWith<$Res> implements $ProfileNameStateCopyWith<$Res> {
  factory _$ProfileNameStateCopyWith(_ProfileNameState value, $Res Function(_ProfileNameState) _then) = __$ProfileNameStateCopyWithImpl;
@override @useResult
$Res call({
 ProfileNameStatus status, NameError? invalid, Failure? failure, AppUser? user
});


@override $FailureCopyWith<$Res>? get failure;@override $AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class __$ProfileNameStateCopyWithImpl<$Res>
    implements _$ProfileNameStateCopyWith<$Res> {
  __$ProfileNameStateCopyWithImpl(this._self, this._then);

  final _ProfileNameState _self;
  final $Res Function(_ProfileNameState) _then;

/// Create a copy of ProfileNameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? invalid = freezed,Object? failure = freezed,Object? user = freezed,}) {
  return _then(_ProfileNameState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileNameStatus,invalid: freezed == invalid ? _self.invalid : invalid // ignore: cast_nullable_to_non_nullable
as NameError?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,
  ));
}

/// Create a copy of ProfileNameState
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
}/// Create a copy of ProfileNameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AppUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
