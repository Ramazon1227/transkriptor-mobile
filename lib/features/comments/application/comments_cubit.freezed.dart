// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comments_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommentsState {

 CommentsStatus get status; List<Comment> get comments; Failure? get failure; CommentActionStatus get actionStatus; Failure? get actionFailure;
/// Create a copy of CommentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentsStateCopyWith<CommentsState> get copyWith => _$CommentsStateCopyWithImpl<CommentsState>(this as CommentsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CommentsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.comments, _this.comments)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.actionStatus, _this.actionStatus) || other.actionStatus == _this.actionStatus)&&(identical(other.actionFailure, _this.actionFailure) || other.actionFailure == _this.actionFailure));
}


@override
int get hashCode {
  final _this = this as CommentsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.comments),_this.failure,_this.actionStatus,_this.actionFailure);
}

@override
String toString() {
  final _this = this as CommentsState;
  return 'CommentsState(status: ${_this.status}, comments: ${_this.comments}, failure: ${_this.failure}, actionStatus: ${_this.actionStatus}, actionFailure: ${_this.actionFailure})';
}


}

/// @nodoc
abstract mixin class $CommentsStateCopyWith<$Res>  {
  factory $CommentsStateCopyWith(CommentsState value, $Res Function(CommentsState) _then) = _$CommentsStateCopyWithImpl;
@useResult
$Res call({
 CommentsStatus status, List<Comment> comments, Failure? failure, CommentActionStatus actionStatus, Failure? actionFailure
});


$FailureCopyWith<$Res>? get failure;$FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class _$CommentsStateCopyWithImpl<$Res>
    implements $CommentsStateCopyWith<$Res> {
  _$CommentsStateCopyWithImpl(this._self, this._then);

  final CommentsState _self;
  final $Res Function(CommentsState) _then;

/// Create a copy of CommentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? comments = null,Object? failure = freezed,Object? actionStatus = null,Object? actionFailure = freezed,}) {
  return _then(CommentsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CommentsStatus,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as CommentActionStatus,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of CommentsState
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
}/// Create a copy of CommentsState
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


/// Adds pattern-matching-related methods to [CommentsState].
extension CommentsStatePatterns on CommentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentsState value)  $default,){
final _that = this;
switch (_that) {
case _CommentsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentsState value)?  $default,){
final _that = this;
switch (_that) {
case _CommentsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommentsStatus status,  List<Comment> comments,  Failure? failure,  CommentActionStatus actionStatus,  Failure? actionFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentsState() when $default != null:
return $default(_that.status,_that.comments,_that.failure,_that.actionStatus,_that.actionFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommentsStatus status,  List<Comment> comments,  Failure? failure,  CommentActionStatus actionStatus,  Failure? actionFailure)  $default,) {final _that = this;
switch (_that) {
case _CommentsState():
return $default(_that.status,_that.comments,_that.failure,_that.actionStatus,_that.actionFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommentsStatus status,  List<Comment> comments,  Failure? failure,  CommentActionStatus actionStatus,  Failure? actionFailure)?  $default,) {final _that = this;
switch (_that) {
case _CommentsState() when $default != null:
return $default(_that.status,_that.comments,_that.failure,_that.actionStatus,_that.actionFailure);case _:
  return null;

}
}

}

/// @nodoc


class _CommentsState extends CommentsState {
  const _CommentsState({this.status = CommentsStatus.initial,  List<Comment> comments = const <Comment>[], this.failure, this.actionStatus = CommentActionStatus.idle, this.actionFailure}): _comments = comments,super._();
  

@override@JsonKey() final  CommentsStatus status;
 final  List<Comment> _comments;
@override@JsonKey() List<Comment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override final  Failure? failure;
@override@JsonKey() final  CommentActionStatus actionStatus;
@override final  Failure? actionFailure;

/// Create a copy of CommentsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentsStateCopyWith<_CommentsState> get copyWith => __$CommentsStateCopyWithImpl<_CommentsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.comments, _comments)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.actionStatus, actionStatus) || other.actionStatus == actionStatus)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_comments),failure,actionStatus,actionFailure);
}

@override
String toString() {
    return 'CommentsState(status: $status, comments: $comments, failure: $failure, actionStatus: $actionStatus, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class _$CommentsStateCopyWith<$Res> implements $CommentsStateCopyWith<$Res> {
  factory _$CommentsStateCopyWith(_CommentsState value, $Res Function(_CommentsState) _then) = __$CommentsStateCopyWithImpl;
@override @useResult
$Res call({
 CommentsStatus status, List<Comment> comments, Failure? failure, CommentActionStatus actionStatus, Failure? actionFailure
});


@override $FailureCopyWith<$Res>? get failure;@override $FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class __$CommentsStateCopyWithImpl<$Res>
    implements _$CommentsStateCopyWith<$Res> {
  __$CommentsStateCopyWithImpl(this._self, this._then);

  final _CommentsState _self;
  final $Res Function(_CommentsState) _then;

/// Create a copy of CommentsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? comments = null,Object? failure = freezed,Object? actionStatus = null,Object? actionFailure = freezed,}) {
  return _then(_CommentsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CommentsStatus,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,actionStatus: null == actionStatus ? _self.actionStatus : actionStatus // ignore: cast_nullable_to_non_nullable
as CommentActionStatus,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of CommentsState
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
}/// Create a copy of CommentsState
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
