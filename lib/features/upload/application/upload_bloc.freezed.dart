// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UploadState {

 UploadStatus get status;/// 0–1, bytes sent of the file.
 double get progress; String? get mediaId;/// Set when transcription was started.
 Job? get job;/// The link is not one the backend can fetch.
 bool get linkInvalid; Failure? get failure;
/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadStateCopyWith<UploadState> get copyWith => _$UploadStateCopyWithImpl<UploadState>(this as UploadState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UploadState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.job, _this.job) || other.job == _this.job)&&(identical(other.linkInvalid, _this.linkInvalid) || other.linkInvalid == _this.linkInvalid)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as UploadState;
  return Object.hash(runtimeType,_this.status,_this.progress,_this.mediaId,_this.job,_this.linkInvalid,_this.failure);
}

@override
String toString() {
  final _this = this as UploadState;
  return 'UploadState(status: ${_this.status}, progress: ${_this.progress}, mediaId: ${_this.mediaId}, job: ${_this.job}, linkInvalid: ${_this.linkInvalid}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $UploadStateCopyWith<$Res>  {
  factory $UploadStateCopyWith(UploadState value, $Res Function(UploadState) _then) = _$UploadStateCopyWithImpl;
@useResult
$Res call({
 UploadStatus status, double progress, String? mediaId, Job? job, bool linkInvalid, Failure? failure
});


$JobCopyWith<$Res>? get job;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$UploadStateCopyWithImpl<$Res>
    implements $UploadStateCopyWith<$Res> {
  _$UploadStateCopyWithImpl(this._self, this._then);

  final UploadState _self;
  final $Res Function(UploadState) _then;

/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? progress = null,Object? mediaId = freezed,Object? job = freezed,Object? linkInvalid = null,Object? failure = freezed,}) {
  return _then(UploadState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UploadStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,mediaId: freezed == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job?,linkInvalid: null == linkInvalid ? _self.linkInvalid : linkInvalid // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of UploadState
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
}/// Create a copy of UploadState
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


/// Adds pattern-matching-related methods to [UploadState].
extension UploadStatePatterns on UploadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadState value)  $default,){
final _that = this;
switch (_that) {
case _UploadState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadState value)?  $default,){
final _that = this;
switch (_that) {
case _UploadState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UploadStatus status,  double progress,  String? mediaId,  Job? job,  bool linkInvalid,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadState() when $default != null:
return $default(_that.status,_that.progress,_that.mediaId,_that.job,_that.linkInvalid,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UploadStatus status,  double progress,  String? mediaId,  Job? job,  bool linkInvalid,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _UploadState():
return $default(_that.status,_that.progress,_that.mediaId,_that.job,_that.linkInvalid,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UploadStatus status,  double progress,  String? mediaId,  Job? job,  bool linkInvalid,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _UploadState() when $default != null:
return $default(_that.status,_that.progress,_that.mediaId,_that.job,_that.linkInvalid,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _UploadState implements UploadState {
  const _UploadState({this.status = UploadStatus.initial, this.progress = 0, this.mediaId, this.job, this.linkInvalid = false, this.failure});
  

@override@JsonKey() final  UploadStatus status;
/// 0–1, bytes sent of the file.
@override@JsonKey() final  double progress;
@override final  String? mediaId;
/// Set when transcription was started.
@override final  Job? job;
/// The link is not one the backend can fetch.
@override@JsonKey() final  bool linkInvalid;
@override final  Failure? failure;

/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadStateCopyWith<_UploadState> get copyWith => __$UploadStateCopyWithImpl<_UploadState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadState&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.job, job) || other.job == job)&&(identical(other.linkInvalid, linkInvalid) || other.linkInvalid == linkInvalid)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,progress,mediaId,job,linkInvalid,failure);
}

@override
String toString() {
    return 'UploadState(status: $status, progress: $progress, mediaId: $mediaId, job: $job, linkInvalid: $linkInvalid, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$UploadStateCopyWith<$Res> implements $UploadStateCopyWith<$Res> {
  factory _$UploadStateCopyWith(_UploadState value, $Res Function(_UploadState) _then) = __$UploadStateCopyWithImpl;
@override @useResult
$Res call({
 UploadStatus status, double progress, String? mediaId, Job? job, bool linkInvalid, Failure? failure
});


@override $JobCopyWith<$Res>? get job;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$UploadStateCopyWithImpl<$Res>
    implements _$UploadStateCopyWith<$Res> {
  __$UploadStateCopyWithImpl(this._self, this._then);

  final _UploadState _self;
  final $Res Function(_UploadState) _then;

/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? progress = null,Object? mediaId = freezed,Object? job = freezed,Object? linkInvalid = null,Object? failure = freezed,}) {
  return _then(_UploadState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UploadStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,mediaId: freezed == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job?,linkInvalid: null == linkInvalid ? _self.linkInvalid : linkInvalid // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of UploadState
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
}/// Create a copy of UploadState
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
