// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_account_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeleteAccountState {

 DeleteAccountStatus get status;/// The confirmation field was left empty; nothing was sent.
 bool get confirmationMissing; Failure? get failure;
/// Create a copy of DeleteAccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteAccountStateCopyWith<DeleteAccountState> get copyWith => _$DeleteAccountStateCopyWithImpl<DeleteAccountState>(this as DeleteAccountState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DeleteAccountState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteAccountState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.confirmationMissing, _this.confirmationMissing) || other.confirmationMissing == _this.confirmationMissing)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as DeleteAccountState;
  return Object.hash(runtimeType,_this.status,_this.confirmationMissing,_this.failure);
}

@override
String toString() {
  final _this = this as DeleteAccountState;
  return 'DeleteAccountState(status: ${_this.status}, confirmationMissing: ${_this.confirmationMissing}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $DeleteAccountStateCopyWith<$Res>  {
  factory $DeleteAccountStateCopyWith(DeleteAccountState value, $Res Function(DeleteAccountState) _then) = _$DeleteAccountStateCopyWithImpl;
@useResult
$Res call({
 DeleteAccountStatus status, bool confirmationMissing, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$DeleteAccountStateCopyWithImpl<$Res>
    implements $DeleteAccountStateCopyWith<$Res> {
  _$DeleteAccountStateCopyWithImpl(this._self, this._then);

  final DeleteAccountState _self;
  final $Res Function(DeleteAccountState) _then;

/// Create a copy of DeleteAccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? confirmationMissing = null,Object? failure = freezed,}) {
  return _then(DeleteAccountState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeleteAccountStatus,confirmationMissing: null == confirmationMissing ? _self.confirmationMissing : confirmationMissing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of DeleteAccountState
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


/// Adds pattern-matching-related methods to [DeleteAccountState].
extension DeleteAccountStatePatterns on DeleteAccountState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteAccountState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteAccountState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteAccountState value)  $default,){
final _that = this;
switch (_that) {
case _DeleteAccountState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteAccountState value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteAccountState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeleteAccountStatus status,  bool confirmationMissing,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeleteAccountState() when $default != null:
return $default(_that.status,_that.confirmationMissing,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeleteAccountStatus status,  bool confirmationMissing,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _DeleteAccountState():
return $default(_that.status,_that.confirmationMissing,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeleteAccountStatus status,  bool confirmationMissing,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _DeleteAccountState() when $default != null:
return $default(_that.status,_that.confirmationMissing,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _DeleteAccountState implements DeleteAccountState {
  const _DeleteAccountState({this.status = DeleteAccountStatus.initial, this.confirmationMissing = false, this.failure});
  

@override@JsonKey() final  DeleteAccountStatus status;
/// The confirmation field was left empty; nothing was sent.
@override@JsonKey() final  bool confirmationMissing;
@override final  Failure? failure;

/// Create a copy of DeleteAccountState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteAccountStateCopyWith<_DeleteAccountState> get copyWith => __$DeleteAccountStateCopyWithImpl<_DeleteAccountState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteAccountState&&(identical(other.status, status) || other.status == status)&&(identical(other.confirmationMissing, confirmationMissing) || other.confirmationMissing == confirmationMissing)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,confirmationMissing,failure);
}

@override
String toString() {
    return 'DeleteAccountState(status: $status, confirmationMissing: $confirmationMissing, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$DeleteAccountStateCopyWith<$Res> implements $DeleteAccountStateCopyWith<$Res> {
  factory _$DeleteAccountStateCopyWith(_DeleteAccountState value, $Res Function(_DeleteAccountState) _then) = __$DeleteAccountStateCopyWithImpl;
@override @useResult
$Res call({
 DeleteAccountStatus status, bool confirmationMissing, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$DeleteAccountStateCopyWithImpl<$Res>
    implements _$DeleteAccountStateCopyWith<$Res> {
  __$DeleteAccountStateCopyWithImpl(this._self, this._then);

  final _DeleteAccountState _self;
  final $Res Function(_DeleteAccountState) _then;

/// Create a copy of DeleteAccountState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? confirmationMissing = null,Object? failure = freezed,}) {
  return _then(_DeleteAccountState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeleteAccountStatus,confirmationMissing: null == confirmationMissing ? _self.confirmationMissing : confirmationMissing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of DeleteAccountState
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
