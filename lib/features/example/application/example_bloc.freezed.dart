// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExampleState {

 ExampleStatus get status; List<Post> get posts; int? get userId; Failure? get failure;
/// Create a copy of ExampleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleStateCopyWith<ExampleState> get copyWith => _$ExampleStateCopyWithImpl<ExampleState>(this as ExampleState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExampleState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.posts, _this.posts)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as ExampleState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.posts),_this.userId,_this.failure);
}

@override
String toString() {
  final _this = this as ExampleState;
  return 'ExampleState(status: ${_this.status}, posts: ${_this.posts}, userId: ${_this.userId}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $ExampleStateCopyWith<$Res>  {
  factory $ExampleStateCopyWith(ExampleState value, $Res Function(ExampleState) _then) = _$ExampleStateCopyWithImpl;
@useResult
$Res call({
 ExampleStatus status, List<Post> posts, int? userId, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ExampleStateCopyWithImpl<$Res>
    implements $ExampleStateCopyWith<$Res> {
  _$ExampleStateCopyWithImpl(this._self, this._then);

  final ExampleState _self;
  final $Res Function(ExampleState) _then;

/// Create a copy of ExampleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? posts = null,Object? userId = freezed,Object? failure = freezed,}) {
  return _then(ExampleState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExampleStatus,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of ExampleState
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


/// Adds pattern-matching-related methods to [ExampleState].
extension ExampleStatePatterns on ExampleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExampleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExampleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExampleState value)  $default,){
final _that = this;
switch (_that) {
case _ExampleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExampleState value)?  $default,){
final _that = this;
switch (_that) {
case _ExampleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExampleStatus status,  List<Post> posts,  int? userId,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExampleState() when $default != null:
return $default(_that.status,_that.posts,_that.userId,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExampleStatus status,  List<Post> posts,  int? userId,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _ExampleState():
return $default(_that.status,_that.posts,_that.userId,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExampleStatus status,  List<Post> posts,  int? userId,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _ExampleState() when $default != null:
return $default(_that.status,_that.posts,_that.userId,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _ExampleState implements ExampleState {
  const _ExampleState({this.status = ExampleStatus.initial,  List<Post> posts = const <Post>[], this.userId, this.failure}): _posts = posts;
  

@override@JsonKey() final  ExampleStatus status;
 final  List<Post> _posts;
@override@JsonKey() List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override final  int? userId;
@override final  Failure? failure;

/// Create a copy of ExampleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExampleStateCopyWith<_ExampleState> get copyWith => __$ExampleStateCopyWithImpl<_ExampleState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExampleState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.posts, _posts)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_posts),userId,failure);
}

@override
String toString() {
    return 'ExampleState(status: $status, posts: $posts, userId: $userId, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ExampleStateCopyWith<$Res> implements $ExampleStateCopyWith<$Res> {
  factory _$ExampleStateCopyWith(_ExampleState value, $Res Function(_ExampleState) _then) = __$ExampleStateCopyWithImpl;
@override @useResult
$Res call({
 ExampleStatus status, List<Post> posts, int? userId, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ExampleStateCopyWithImpl<$Res>
    implements _$ExampleStateCopyWith<$Res> {
  __$ExampleStateCopyWithImpl(this._self, this._then);

  final _ExampleState _self;
  final $Res Function(_ExampleState) _then;

/// Create a copy of ExampleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? posts = null,Object? userId = freezed,Object? failure = freezed,}) {
  return _then(_ExampleState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExampleStatus,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of ExampleState
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
