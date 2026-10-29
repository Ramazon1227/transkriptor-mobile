// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RatingState {

 RatingStatus get status;/// Null: not rated yet.
 Rating? get rating; Failure? get failure; RatingSaveStatus get saveStatus; Failure? get saveFailure;
/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingStateCopyWith<RatingState> get copyWith => _$RatingStateCopyWithImpl<RatingState>(this as RatingState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RatingState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.saveStatus, _this.saveStatus) || other.saveStatus == _this.saveStatus)&&(identical(other.saveFailure, _this.saveFailure) || other.saveFailure == _this.saveFailure));
}


@override
int get hashCode {
  final _this = this as RatingState;
  return Object.hash(runtimeType,_this.status,_this.rating,_this.failure,_this.saveStatus,_this.saveFailure);
}

@override
String toString() {
  final _this = this as RatingState;
  return 'RatingState(status: ${_this.status}, rating: ${_this.rating}, failure: ${_this.failure}, saveStatus: ${_this.saveStatus}, saveFailure: ${_this.saveFailure})';
}


}

/// @nodoc
abstract mixin class $RatingStateCopyWith<$Res>  {
  factory $RatingStateCopyWith(RatingState value, $Res Function(RatingState) _then) = _$RatingStateCopyWithImpl;
@useResult
$Res call({
 RatingStatus status, Rating? rating, Failure? failure, RatingSaveStatus saveStatus, Failure? saveFailure
});


$RatingCopyWith<$Res>? get rating;$FailureCopyWith<$Res>? get failure;$FailureCopyWith<$Res>? get saveFailure;

}
/// @nodoc
class _$RatingStateCopyWithImpl<$Res>
    implements $RatingStateCopyWith<$Res> {
  _$RatingStateCopyWithImpl(this._self, this._then);

  final RatingState _self;
  final $Res Function(RatingState) _then;

/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? rating = freezed,Object? failure = freezed,Object? saveStatus = null,Object? saveFailure = freezed,}) {
  return _then(RatingState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RatingStatus,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as Rating?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as RatingSaveStatus,saveFailure: freezed == saveFailure ? _self.saveFailure : saveFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RatingCopyWith<$Res>? get rating {
    if (_self.rating == null) {
    return null;
  }

  return $RatingCopyWith<$Res>(_self.rating!, (value) {
    return _then(_self.copyWith(rating: value));
  });
}/// Create a copy of RatingState
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
}/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get saveFailure {
    if (_self.saveFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.saveFailure!, (value) {
    return _then(_self.copyWith(saveFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [RatingState].
extension RatingStatePatterns on RatingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingState value)  $default,){
final _that = this;
switch (_that) {
case _RatingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingState value)?  $default,){
final _that = this;
switch (_that) {
case _RatingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RatingStatus status,  Rating? rating,  Failure? failure,  RatingSaveStatus saveStatus,  Failure? saveFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingState() when $default != null:
return $default(_that.status,_that.rating,_that.failure,_that.saveStatus,_that.saveFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RatingStatus status,  Rating? rating,  Failure? failure,  RatingSaveStatus saveStatus,  Failure? saveFailure)  $default,) {final _that = this;
switch (_that) {
case _RatingState():
return $default(_that.status,_that.rating,_that.failure,_that.saveStatus,_that.saveFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RatingStatus status,  Rating? rating,  Failure? failure,  RatingSaveStatus saveStatus,  Failure? saveFailure)?  $default,) {final _that = this;
switch (_that) {
case _RatingState() when $default != null:
return $default(_that.status,_that.rating,_that.failure,_that.saveStatus,_that.saveFailure);case _:
  return null;

}
}

}

/// @nodoc


class _RatingState implements RatingState {
  const _RatingState({this.status = RatingStatus.initial, this.rating, this.failure, this.saveStatus = RatingSaveStatus.idle, this.saveFailure});
  

@override@JsonKey() final  RatingStatus status;
/// Null: not rated yet.
@override final  Rating? rating;
@override final  Failure? failure;
@override@JsonKey() final  RatingSaveStatus saveStatus;
@override final  Failure? saveFailure;

/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingStateCopyWith<_RatingState> get copyWith => __$RatingStateCopyWithImpl<_RatingState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingState&&(identical(other.status, status) || other.status == status)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.saveFailure, saveFailure) || other.saveFailure == saveFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,rating,failure,saveStatus,saveFailure);
}

@override
String toString() {
    return 'RatingState(status: $status, rating: $rating, failure: $failure, saveStatus: $saveStatus, saveFailure: $saveFailure)';
}


}

/// @nodoc
abstract mixin class _$RatingStateCopyWith<$Res> implements $RatingStateCopyWith<$Res> {
  factory _$RatingStateCopyWith(_RatingState value, $Res Function(_RatingState) _then) = __$RatingStateCopyWithImpl;
@override @useResult
$Res call({
 RatingStatus status, Rating? rating, Failure? failure, RatingSaveStatus saveStatus, Failure? saveFailure
});


@override $RatingCopyWith<$Res>? get rating;@override $FailureCopyWith<$Res>? get failure;@override $FailureCopyWith<$Res>? get saveFailure;

}
/// @nodoc
class __$RatingStateCopyWithImpl<$Res>
    implements _$RatingStateCopyWith<$Res> {
  __$RatingStateCopyWithImpl(this._self, this._then);

  final _RatingState _self;
  final $Res Function(_RatingState) _then;

/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? rating = freezed,Object? failure = freezed,Object? saveStatus = null,Object? saveFailure = freezed,}) {
  return _then(_RatingState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RatingStatus,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as Rating?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as RatingSaveStatus,saveFailure: freezed == saveFailure ? _self.saveFailure : saveFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RatingCopyWith<$Res>? get rating {
    if (_self.rating == null) {
    return null;
  }

  return $RatingCopyWith<$Res>(_self.rating!, (value) {
    return _then(_self.copyWith(rating: value));
  });
}/// Create a copy of RatingState
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
}/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get saveFailure {
    if (_self.saveFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.saveFailure!, (value) {
    return _then(_self.copyWith(saveFailure: value));
  });
}
}

// dart format on
