// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recovery_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecoveryState {

 RecoveryStatus get status; List<RecoverableRecording> get items;/// The item being recovered or deleted; its row shows progress.
 String? get busyPath;/// Set once a recovery succeeded; the page sends it to the send page
/// and calls [RecoveryCubit.consumed].
 PendingFile? get recovered;/// Of the last load, recover or discard. Items stay on screen.
 Failure? get failure;
/// Create a copy of RecoveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecoveryStateCopyWith<RecoveryState> get copyWith => _$RecoveryStateCopyWithImpl<RecoveryState>(this as RecoveryState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecoveryState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoveryState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.busyPath, _this.busyPath) || other.busyPath == _this.busyPath)&&(identical(other.recovered, _this.recovered) || other.recovered == _this.recovered)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as RecoveryState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.items),_this.busyPath,_this.recovered,_this.failure);
}

@override
String toString() {
  final _this = this as RecoveryState;
  return 'RecoveryState(status: ${_this.status}, items: ${_this.items}, busyPath: ${_this.busyPath}, recovered: ${_this.recovered}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $RecoveryStateCopyWith<$Res>  {
  factory $RecoveryStateCopyWith(RecoveryState value, $Res Function(RecoveryState) _then) = _$RecoveryStateCopyWithImpl;
@useResult
$Res call({
 RecoveryStatus status, List<RecoverableRecording> items, String? busyPath, PendingFile? recovered, Failure? failure
});


$PendingFileCopyWith<$Res>? get recovered;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$RecoveryStateCopyWithImpl<$Res>
    implements $RecoveryStateCopyWith<$Res> {
  _$RecoveryStateCopyWithImpl(this._self, this._then);

  final RecoveryState _self;
  final $Res Function(RecoveryState) _then;

/// Create a copy of RecoveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? busyPath = freezed,Object? recovered = freezed,Object? failure = freezed,}) {
  return _then(RecoveryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecoveryStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<RecoverableRecording>,busyPath: freezed == busyPath ? _self.busyPath : busyPath // ignore: cast_nullable_to_non_nullable
as String?,recovered: freezed == recovered ? _self.recovered : recovered // ignore: cast_nullable_to_non_nullable
as PendingFile?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of RecoveryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingFileCopyWith<$Res>? get recovered {
    if (_self.recovered == null) {
    return null;
  }

  return $PendingFileCopyWith<$Res>(_self.recovered!, (value) {
    return _then(_self.copyWith(recovered: value));
  });
}/// Create a copy of RecoveryState
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


/// Adds pattern-matching-related methods to [RecoveryState].
extension RecoveryStatePatterns on RecoveryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecoveryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecoveryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecoveryState value)  $default,){
final _that = this;
switch (_that) {
case _RecoveryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecoveryState value)?  $default,){
final _that = this;
switch (_that) {
case _RecoveryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecoveryStatus status,  List<RecoverableRecording> items,  String? busyPath,  PendingFile? recovered,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecoveryState() when $default != null:
return $default(_that.status,_that.items,_that.busyPath,_that.recovered,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecoveryStatus status,  List<RecoverableRecording> items,  String? busyPath,  PendingFile? recovered,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _RecoveryState():
return $default(_that.status,_that.items,_that.busyPath,_that.recovered,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecoveryStatus status,  List<RecoverableRecording> items,  String? busyPath,  PendingFile? recovered,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RecoveryState() when $default != null:
return $default(_that.status,_that.items,_that.busyPath,_that.recovered,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RecoveryState implements RecoveryState {
  const _RecoveryState({this.status = RecoveryStatus.initial,  List<RecoverableRecording> items = const <RecoverableRecording>[], this.busyPath, this.recovered, this.failure}): _items = items;
  

@override@JsonKey() final  RecoveryStatus status;
 final  List<RecoverableRecording> _items;
@override@JsonKey() List<RecoverableRecording> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// The item being recovered or deleted; its row shows progress.
@override final  String? busyPath;
/// Set once a recovery succeeded; the page sends it to the send page
/// and calls [RecoveryCubit.consumed].
@override final  PendingFile? recovered;
/// Of the last load, recover or discard. Items stay on screen.
@override final  Failure? failure;

/// Create a copy of RecoveryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecoveryStateCopyWith<_RecoveryState> get copyWith => __$RecoveryStateCopyWithImpl<_RecoveryState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecoveryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.busyPath, busyPath) || other.busyPath == busyPath)&&(identical(other.recovered, recovered) || other.recovered == recovered)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),busyPath,recovered,failure);
}

@override
String toString() {
    return 'RecoveryState(status: $status, items: $items, busyPath: $busyPath, recovered: $recovered, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RecoveryStateCopyWith<$Res> implements $RecoveryStateCopyWith<$Res> {
  factory _$RecoveryStateCopyWith(_RecoveryState value, $Res Function(_RecoveryState) _then) = __$RecoveryStateCopyWithImpl;
@override @useResult
$Res call({
 RecoveryStatus status, List<RecoverableRecording> items, String? busyPath, PendingFile? recovered, Failure? failure
});


@override $PendingFileCopyWith<$Res>? get recovered;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$RecoveryStateCopyWithImpl<$Res>
    implements _$RecoveryStateCopyWith<$Res> {
  __$RecoveryStateCopyWithImpl(this._self, this._then);

  final _RecoveryState _self;
  final $Res Function(_RecoveryState) _then;

/// Create a copy of RecoveryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? busyPath = freezed,Object? recovered = freezed,Object? failure = freezed,}) {
  return _then(_RecoveryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecoveryStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RecoverableRecording>,busyPath: freezed == busyPath ? _self.busyPath : busyPath // ignore: cast_nullable_to_non_nullable
as String?,recovered: freezed == recovered ? _self.recovered : recovered // ignore: cast_nullable_to_non_nullable
as PendingFile?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of RecoveryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingFileCopyWith<$Res>? get recovered {
    if (_self.recovered == null) {
    return null;
  }

  return $PendingFileCopyWith<$Res>(_self.recovered!, (value) {
    return _then(_self.copyWith(recovered: value));
  });
}/// Create a copy of RecoveryState
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
