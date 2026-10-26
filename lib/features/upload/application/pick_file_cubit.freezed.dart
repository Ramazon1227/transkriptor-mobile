// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pick_file_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PickFileState {

 PickFileStatus get status; PendingFile? get file; Failure? get failure;
/// Create a copy of PickFileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PickFileStateCopyWith<PickFileState> get copyWith => _$PickFileStateCopyWithImpl<PickFileState>(this as PickFileState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PickFileState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PickFileState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.file, _this.file) || other.file == _this.file)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as PickFileState;
  return Object.hash(runtimeType,_this.status,_this.file,_this.failure);
}

@override
String toString() {
  final _this = this as PickFileState;
  return 'PickFileState(status: ${_this.status}, file: ${_this.file}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $PickFileStateCopyWith<$Res>  {
  factory $PickFileStateCopyWith(PickFileState value, $Res Function(PickFileState) _then) = _$PickFileStateCopyWithImpl;
@useResult
$Res call({
 PickFileStatus status, PendingFile? file, Failure? failure
});


$PendingFileCopyWith<$Res>? get file;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$PickFileStateCopyWithImpl<$Res>
    implements $PickFileStateCopyWith<$Res> {
  _$PickFileStateCopyWithImpl(this._self, this._then);

  final PickFileState _self;
  final $Res Function(PickFileState) _then;

/// Create a copy of PickFileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? file = freezed,Object? failure = freezed,}) {
  return _then(PickFileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PickFileStatus,file: freezed == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as PendingFile?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of PickFileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingFileCopyWith<$Res>? get file {
    if (_self.file == null) {
    return null;
  }

  return $PendingFileCopyWith<$Res>(_self.file!, (value) {
    return _then(_self.copyWith(file: value));
  });
}/// Create a copy of PickFileState
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


/// Adds pattern-matching-related methods to [PickFileState].
extension PickFileStatePatterns on PickFileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PickFileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PickFileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PickFileState value)  $default,){
final _that = this;
switch (_that) {
case _PickFileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PickFileState value)?  $default,){
final _that = this;
switch (_that) {
case _PickFileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PickFileStatus status,  PendingFile? file,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PickFileState() when $default != null:
return $default(_that.status,_that.file,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PickFileStatus status,  PendingFile? file,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _PickFileState():
return $default(_that.status,_that.file,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PickFileStatus status,  PendingFile? file,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _PickFileState() when $default != null:
return $default(_that.status,_that.file,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _PickFileState implements PickFileState {
  const _PickFileState({this.status = PickFileStatus.initial, this.file, this.failure});
  

@override@JsonKey() final  PickFileStatus status;
@override final  PendingFile? file;
@override final  Failure? failure;

/// Create a copy of PickFileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PickFileStateCopyWith<_PickFileState> get copyWith => __$PickFileStateCopyWithImpl<_PickFileState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PickFileState&&(identical(other.status, status) || other.status == status)&&(identical(other.file, file) || other.file == file)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,file,failure);
}

@override
String toString() {
    return 'PickFileState(status: $status, file: $file, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$PickFileStateCopyWith<$Res> implements $PickFileStateCopyWith<$Res> {
  factory _$PickFileStateCopyWith(_PickFileState value, $Res Function(_PickFileState) _then) = __$PickFileStateCopyWithImpl;
@override @useResult
$Res call({
 PickFileStatus status, PendingFile? file, Failure? failure
});


@override $PendingFileCopyWith<$Res>? get file;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$PickFileStateCopyWithImpl<$Res>
    implements _$PickFileStateCopyWith<$Res> {
  __$PickFileStateCopyWithImpl(this._self, this._then);

  final _PickFileState _self;
  final $Res Function(_PickFileState) _then;

/// Create a copy of PickFileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? file = freezed,Object? failure = freezed,}) {
  return _then(_PickFileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PickFileStatus,file: freezed == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as PendingFile?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of PickFileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingFileCopyWith<$Res>? get file {
    if (_self.file == null) {
    return null;
  }

  return $PendingFileCopyWith<$Res>(_self.file!, (value) {
    return _then(_self.copyWith(file: value));
  });
}/// Create a copy of PickFileState
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
