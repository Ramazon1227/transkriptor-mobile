// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folders_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FoldersState {

 FoldersStatus get status; List<Folder> get folders; Failure? get failure; FolderActionStatus get actionStatus; Failure? get actionFailure;
/// Create a copy of FoldersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoldersStateCopyWith<FoldersState> get copyWith => _$FoldersStateCopyWithImpl<FoldersState>(this as FoldersState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FoldersState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoldersState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.folders, _this.folders)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionFailure, _this.actionFailure) || other.actionFailure == _this.actionFailure));
}


@override
int get hashCode {
  final _this = this as FoldersState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.folders),_this.failure,_this.actionStatus,_this.actionFailure);
}

@override
String toString() {
  final _this = this as FoldersState;
  return 'FoldersState(status: ${_this.status}, folders: ${_this.folders}, failure: ${_this.failure}, actionStatus: ${_this.actionStatus}, actionFailure: ${_this.actionFailure})';
}


}

/// @nodoc
abstract mixin class $FoldersStateCopyWith<$Res>  {
  factory $FoldersStateCopyWith(FoldersState value, $Res Function(FoldersState) _then) = _$FoldersStateCopyWithImpl;
@useResult
$Res call({
 FoldersStatus status, List<Folder> folders, Failure? failure, FolderActionStatus actionStatus, Failure? actionFailure
});


$FailureCopyWith<$Res>? get failure;$FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class _$FoldersStateCopyWithImpl<$Res>
    implements $FoldersStateCopyWith<$Res> {
  _$FoldersStateCopyWithImpl(this._self, this._then);

  final FoldersState _self;
  final $Res Function(FoldersState) _then;

/// Create a copy of FoldersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? folders = null,Object? failure = freezed,Object? actionStatus = null,Object? actionFailure = freezed,}) {
  return _then(FoldersState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FoldersStatus,folders: null == folders ? _self.folders : folders // ignore: cast_nullable_to_non_nullable
as List<Folder>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as FolderActionStatus,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of FoldersState
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
}/// Create a copy of FoldersState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [FoldersState].
extension FoldersStatePatterns on FoldersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoldersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoldersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoldersState value)  $default,){
final _that = this;
switch (_that) {
case _FoldersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoldersState value)?  $default,){
final _that = this;
switch (_that) {
case _FoldersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FoldersStatus status,  List<Folder> folders,  Failure? failure,  FolderActionStatus actionStatus,  Failure? actionFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoldersState() when $default != null:
return $default(_that.status,_that.folders,_that.failure,_that.actionStatus,_that.actionFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FoldersStatus status,  List<Folder> folders,  Failure? failure,  FolderActionStatus actionStatus,  Failure? actionFailure)  $default,) {final _that = this;
switch (_that) {
case _FoldersState():
return $default(_that.status,_that.folders,_that.failure,_that.actionStatus,_that.actionFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FoldersStatus status,  List<Folder> folders,  Failure? failure,  FolderActionStatus actionStatus,  Failure? actionFailure)?  $default,) {final _that = this;
switch (_that) {
case _FoldersState() when $default != null:
return $default(_that.status,_that.folders,_that.failure,_that.actionStatus,_that.actionFailure);case _:
  return null;

}
}

}

/// @nodoc


class _FoldersState implements FoldersState {
  const _FoldersState({this.status = FoldersStatus.initial,  List<Folder> folders = const <Folder>[], this.failure, this.actionStatus = FolderActionStatus.idle, this.actionFailure}): _folders = folders;
  

@override@JsonKey() final  FoldersStatus status;
 final  List<Folder> _folders;
@override@JsonKey() List<Folder> get folders {
  if (_folders is EqualUnmodifiableListView) return _folders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_folders);
}

@override final  Failure? failure;
@override@JsonKey() final  FolderActionStatus actionStatus;
@override final  Failure? actionFailure;

/// Create a copy of FoldersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoldersStateCopyWith<_FoldersState> get copyWith => __$FoldersStateCopyWithImpl<_FoldersState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoldersState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.folders, _folders)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_folders),failure,actionStatus,actionFailure);
}

@override
String toString() {
    return 'FoldersState(status: $status, folders: $folders, failure: $failure, actionStatus: $actionStatus, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class _$FoldersStateCopyWith<$Res> implements $FoldersStateCopyWith<$Res> {
  factory _$FoldersStateCopyWith(_FoldersState value, $Res Function(_FoldersState) _then) = __$FoldersStateCopyWithImpl;
@override @useResult
$Res call({
 FoldersStatus status, List<Folder> folders, Failure? failure, FolderActionStatus actionStatus, Failure? actionFailure
});


@override $FailureCopyWith<$Res>? get failure;@override $FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class __$FoldersStateCopyWithImpl<$Res>
    implements _$FoldersStateCopyWith<$Res> {
  __$FoldersStateCopyWithImpl(this._self, this._then);

  final _FoldersState _self;
  final $Res Function(_FoldersState) _then;

/// Create a copy of FoldersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? folders = null,Object? failure = freezed,Object? actionStatus = null,Object? actionFailure = freezed,}) {
  return _then(_FoldersState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FoldersStatus,folders: null == folders ? _self._folders : folders // ignore: cast_nullable_to_non_nullable
as List<Folder>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as FolderActionStatus,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of FoldersState
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
}/// Create a copy of FoldersState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}
}

// dart format on
