// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_actions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FileActionsState {

 FileActionStatus get status;/// The row as the server returned it after the change.
 LibraryItem? get item; Failure? get failure;
/// Create a copy of FileActionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileActionsStateCopyWith<FileActionsState> get copyWith => _$FileActionsStateCopyWithImpl<FileActionsState>(this as FileActionsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FileActionsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileActionsState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.item, _this.item) || other.item == _this.item)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as FileActionsState;
  return Object.hash(runtimeType,_this.status,_this.item,_this.failure);
}

@override
String toString() {
  final _this = this as FileActionsState;
  return 'FileActionsState(status: ${_this.status}, item: ${_this.item}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $FileActionsStateCopyWith<$Res>  {
  factory $FileActionsStateCopyWith(FileActionsState value, $Res Function(FileActionsState) _then) = _$FileActionsStateCopyWithImpl;
@useResult
$Res call({
 FileActionStatus status, LibraryItem? item, Failure? failure
});


$LibraryItemCopyWith<$Res>? get item;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$FileActionsStateCopyWithImpl<$Res>
    implements $FileActionsStateCopyWith<$Res> {
  _$FileActionsStateCopyWithImpl(this._self, this._then);

  final FileActionsState _self;
  final $Res Function(FileActionsState) _then;

/// Create a copy of FileActionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? item = freezed,Object? failure = freezed,}) {
  return _then(FileActionsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FileActionStatus,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as LibraryItem?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of FileActionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LibraryItemCopyWith<$Res>? get item {
    if (_self.item == null) {
    return null;
  }

  return $LibraryItemCopyWith<$Res>(_self.item!, (value) {
    return _then(_self.copyWith(item: value));
  });
}/// Create a copy of FileActionsState
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


/// Adds pattern-matching-related methods to [FileActionsState].
extension FileActionsStatePatterns on FileActionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileActionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileActionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileActionsState value)  $default,){
final _that = this;
switch (_that) {
case _FileActionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileActionsState value)?  $default,){
final _that = this;
switch (_that) {
case _FileActionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FileActionStatus status,  LibraryItem? item,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileActionsState() when $default != null:
return $default(_that.status,_that.item,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FileActionStatus status,  LibraryItem? item,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _FileActionsState():
return $default(_that.status,_that.item,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FileActionStatus status,  LibraryItem? item,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _FileActionsState() when $default != null:
return $default(_that.status,_that.item,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _FileActionsState implements FileActionsState {
  const _FileActionsState({this.status = FileActionStatus.idle, this.item, this.failure});
  

@override@JsonKey() final  FileActionStatus status;
/// The row as the server returned it after the change.
@override final  LibraryItem? item;
@override final  Failure? failure;

/// Create a copy of FileActionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileActionsStateCopyWith<_FileActionsState> get copyWith => __$FileActionsStateCopyWithImpl<_FileActionsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileActionsState&&(identical(other.status, status) || other.status == status)&&(identical(other.item, item) || other.item == item)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,item,failure);
}

@override
String toString() {
    return 'FileActionsState(status: $status, item: $item, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FileActionsStateCopyWith<$Res> implements $FileActionsStateCopyWith<$Res> {
  factory _$FileActionsStateCopyWith(_FileActionsState value, $Res Function(_FileActionsState) _then) = __$FileActionsStateCopyWithImpl;
@override @useResult
$Res call({
 FileActionStatus status, LibraryItem? item, Failure? failure
});


@override $LibraryItemCopyWith<$Res>? get item;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$FileActionsStateCopyWithImpl<$Res>
    implements _$FileActionsStateCopyWith<$Res> {
  __$FileActionsStateCopyWithImpl(this._self, this._then);

  final _FileActionsState _self;
  final $Res Function(_FileActionsState) _then;

/// Create a copy of FileActionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? item = freezed,Object? failure = freezed,}) {
  return _then(_FileActionsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FileActionStatus,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as LibraryItem?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of FileActionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LibraryItemCopyWith<$Res>? get item {
    if (_self.item == null) {
    return null;
  }

  return $LibraryItemCopyWith<$Res>(_self.item!, (value) {
    return _then(_self.copyWith(item: value));
  });
}/// Create a copy of FileActionsState
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
