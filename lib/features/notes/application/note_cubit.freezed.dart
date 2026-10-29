// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoteState {

 NoteStatus get status; String? get noteId; Note? get note; Failure? get failure; NoteActionStatus get actionStatus; Failure? get actionFailure;/// Renamed or deleted here: the list behind reloads on the way back.
 bool get changed;/// Deleted: the page closes.
 bool get deleted;
/// Create a copy of NoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteStateCopyWith<NoteState> get copyWith => _$NoteStateCopyWithImpl<NoteState>(this as NoteState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NoteState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.noteId, _this.noteId) || other.noteId == _this.noteId)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionFailure, _this.actionFailure) || other.actionFailure == _this.actionFailure)&&(identical(other.changed, _this.changed) || other.changed == _this.changed)&&(identical(other.deleted, _this.deleted) || other.deleted == _this.deleted));
}


@override
int get hashCode {
  final _this = this as NoteState;
  return Object.hash(runtimeType,_this.status,_this.noteId,_this.note,_this.failure,_this.actionStatus,_this.actionFailure,_this.changed,_this.deleted);
}

@override
String toString() {
  final _this = this as NoteState;
  return 'NoteState(status: ${_this.status}, noteId: ${_this.noteId}, note: ${_this.note}, failure: ${_this.failure}, actionStatus: ${_this.actionStatus}, actionFailure: ${_this.actionFailure}, changed: ${_this.changed}, deleted: ${_this.deleted})';
}


}

/// @nodoc
abstract mixin class $NoteStateCopyWith<$Res>  {
  factory $NoteStateCopyWith(NoteState value, $Res Function(NoteState) _then) = _$NoteStateCopyWithImpl;
@useResult
$Res call({
 NoteStatus status, String? noteId, Note? note, Failure? failure, NoteActionStatus actionStatus, Failure? actionFailure, bool changed, bool deleted
});


$NoteCopyWith<$Res>? get note;$FailureCopyWith<$Res>? get failure;$FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class _$NoteStateCopyWithImpl<$Res>
    implements $NoteStateCopyWith<$Res> {
  _$NoteStateCopyWithImpl(this._self, this._then);

  final NoteState _self;
  final $Res Function(NoteState) _then;

/// Create a copy of NoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? noteId = freezed,Object? note = freezed,Object? failure = freezed,Object? actionStatus = null,Object? actionFailure = freezed,Object? changed = null,Object? deleted = null,}) {
  return _then(NoteState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NoteStatus,noteId: freezed == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as Note?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as NoteActionStatus,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,changed: null == changed ? _self.changed : changed // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of NoteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteCopyWith<$Res>? get note {
    if (_self.note == null) {
    return null;
  }

  return $NoteCopyWith<$Res>(_self.note!, (value) {
    return _then(_self.copyWith(note: value));
  });
}/// Create a copy of NoteState
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
}/// Create a copy of NoteState
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


/// Adds pattern-matching-related methods to [NoteState].
extension NoteStatePatterns on NoteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteState value)  $default,){
final _that = this;
switch (_that) {
case _NoteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteState value)?  $default,){
final _that = this;
switch (_that) {
case _NoteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NoteStatus status,  String? noteId,  Note? note,  Failure? failure,  NoteActionStatus actionStatus,  Failure? actionFailure,  bool changed,  bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteState() when $default != null:
return $default(_that.status,_that.noteId,_that.note,_that.failure,_that.actionStatus,_that.actionFailure,_that.changed,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NoteStatus status,  String? noteId,  Note? note,  Failure? failure,  NoteActionStatus actionStatus,  Failure? actionFailure,  bool changed,  bool deleted)  $default,) {final _that = this;
switch (_that) {
case _NoteState():
return $default(_that.status,_that.noteId,_that.note,_that.failure,_that.actionStatus,_that.actionFailure,_that.changed,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NoteStatus status,  String? noteId,  Note? note,  Failure? failure,  NoteActionStatus actionStatus,  Failure? actionFailure,  bool changed,  bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _NoteState() when $default != null:
return $default(_that.status,_that.noteId,_that.note,_that.failure,_that.actionStatus,_that.actionFailure,_that.changed,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc


class _NoteState implements NoteState {
  const _NoteState({this.status = NoteStatus.initial, this.noteId, this.note, this.failure, this.actionStatus = NoteActionStatus.idle, this.actionFailure, this.changed = false, this.deleted = false});
  

@override@JsonKey() final  NoteStatus status;
@override final  String? noteId;
@override final  Note? note;
@override final  Failure? failure;
@override@JsonKey() final  NoteActionStatus actionStatus;
@override final  Failure? actionFailure;
/// Renamed or deleted here: the list behind reloads on the way back.
@override@JsonKey() final  bool changed;
/// Deleted: the page closes.
@override@JsonKey() final  bool deleted;

/// Create a copy of NoteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteStateCopyWith<_NoteState> get copyWith => __$NoteStateCopyWithImpl<_NoteState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteState&&(identical(other.status, status) || other.status == status)&&(identical(other.noteId, noteId) || other.noteId == noteId)&&(identical(other.note, note) || other.note == note)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure)&&(identical(other.changed, changed) || other.changed == changed)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,noteId,note,failure,actionStatus,actionFailure,changed,deleted);
}

@override
String toString() {
    return 'NoteState(status: $status, noteId: $noteId, note: $note, failure: $failure, actionStatus: $actionStatus, actionFailure: $actionFailure, changed: $changed, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$NoteStateCopyWith<$Res> implements $NoteStateCopyWith<$Res> {
  factory _$NoteStateCopyWith(_NoteState value, $Res Function(_NoteState) _then) = __$NoteStateCopyWithImpl;
@override @useResult
$Res call({
 NoteStatus status, String? noteId, Note? note, Failure? failure, NoteActionStatus actionStatus, Failure? actionFailure, bool changed, bool deleted
});


@override $NoteCopyWith<$Res>? get note;@override $FailureCopyWith<$Res>? get failure;@override $FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class __$NoteStateCopyWithImpl<$Res>
    implements _$NoteStateCopyWith<$Res> {
  __$NoteStateCopyWithImpl(this._self, this._then);

  final _NoteState _self;
  final $Res Function(_NoteState) _then;

/// Create a copy of NoteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? noteId = freezed,Object? note = freezed,Object? failure = freezed,Object? actionStatus = null,Object? actionFailure = freezed,Object? changed = null,Object? deleted = null,}) {
  return _then(_NoteState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NoteStatus,noteId: freezed == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as Note?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as NoteActionStatus,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,changed: null == changed ? _self.changed : changed // ignore: cast_nullable_to_non_nullable
as bool,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of NoteState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteCopyWith<$Res>? get note {
    if (_self.note == null) {
    return null;
  }

  return $NoteCopyWith<$Res>(_self.note!, (value) {
    return _then(_self.copyWith(note: value));
  });
}/// Create a copy of NoteState
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
}/// Create a copy of NoteState
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
