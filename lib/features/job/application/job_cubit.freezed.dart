// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobState {

 JobViewStatus get status; String? get jobId; Job? get job;/// A cancel or retry request is in flight.
 bool get busy; Failure? get failure;
/// Create a copy of JobState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobStateCopyWith<JobState> get copyWith => _$JobStateCopyWithImpl<JobState>(this as JobState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JobState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.job, _this.job) || other.job == _this.job)&&(identical(other.busy, _this.busy) || other.busy == _this.busy)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as JobState;
  return Object.hash(runtimeType,_this.status,_this.jobId,_this.job,_this.busy,_this.failure);
}

@override
String toString() {
  final _this = this as JobState;
  return 'JobState(status: ${_this.status}, jobId: ${_this.jobId}, job: ${_this.job}, busy: ${_this.busy}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $JobStateCopyWith<$Res>  {
  factory $JobStateCopyWith(JobState value, $Res Function(JobState) _then) = _$JobStateCopyWithImpl;
@useResult
$Res call({
 JobViewStatus status, String? jobId, Job? job, bool busy, Failure? failure
});


$JobCopyWith<$Res>? get job;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$JobStateCopyWithImpl<$Res>
    implements $JobStateCopyWith<$Res> {
  _$JobStateCopyWithImpl(this._self, this._then);

  final JobState _self;
  final $Res Function(JobState) _then;

/// Create a copy of JobState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? jobId = freezed,Object? job = freezed,Object? busy = null,Object? failure = freezed,}) {
  return _then(JobState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobViewStatus,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job?,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of JobState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}/// Create a copy of JobState
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


/// Adds pattern-matching-related methods to [JobState].
extension JobStatePatterns on JobState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobState value)  $default,){
final _that = this;
switch (_that) {
case _JobState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobState value)?  $default,){
final _that = this;
switch (_that) {
case _JobState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JobViewStatus status,  String? jobId,  Job? job,  bool busy,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobState() when $default != null:
return $default(_that.status,_that.jobId,_that.job,_that.busy,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JobViewStatus status,  String? jobId,  Job? job,  bool busy,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _JobState():
return $default(_that.status,_that.jobId,_that.job,_that.busy,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JobViewStatus status,  String? jobId,  Job? job,  bool busy,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _JobState() when $default != null:
return $default(_that.status,_that.jobId,_that.job,_that.busy,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _JobState implements JobState {
  const _JobState({this.status = JobViewStatus.initial, this.jobId, this.job, this.busy = false, this.failure});
  

@override@JsonKey() final  JobViewStatus status;
@override final  String? jobId;
@override final  Job? job;
/// A cancel or retry request is in flight.
@override@JsonKey() final  bool busy;
@override final  Failure? failure;

/// Create a copy of JobState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobStateCopyWith<_JobState> get copyWith => __$JobStateCopyWithImpl<_JobState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobState&&(identical(other.status, status) || other.status == status)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.job, job) || other.job == job)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,jobId,job,busy,failure);
}

@override
String toString() {
    return 'JobState(status: $status, jobId: $jobId, job: $job, busy: $busy, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$JobStateCopyWith<$Res> implements $JobStateCopyWith<$Res> {
  factory _$JobStateCopyWith(_JobState value, $Res Function(_JobState) _then) = __$JobStateCopyWithImpl;
@override @useResult
$Res call({
 JobViewStatus status, String? jobId, Job? job, bool busy, Failure? failure
});


@override $JobCopyWith<$Res>? get job;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$JobStateCopyWithImpl<$Res>
    implements _$JobStateCopyWith<$Res> {
  __$JobStateCopyWithImpl(this._self, this._then);

  final _JobState _self;
  final $Res Function(_JobState) _then;

/// Create a copy of JobState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? jobId = freezed,Object? job = freezed,Object? busy = null,Object? failure = freezed,}) {
  return _then(_JobState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobViewStatus,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job?,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of JobState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}/// Create a copy of JobState
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
