// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'url_import_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UrlImportState {

 UrlImportStatus get status; bool get urlInvalid;/// A YouTube/Drive/Dropbox link: the page hands it to the link flow
/// and calls [UrlImportCubit.consumed].
 String? get platformUrl; String? get jobId; Failure? get failure;
/// Create a copy of UrlImportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UrlImportStateCopyWith<UrlImportState> get copyWith => _$UrlImportStateCopyWithImpl<UrlImportState>(this as UrlImportState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UrlImportState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UrlImportState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.urlInvalid, _this.urlInvalid) || other.urlInvalid == _this.urlInvalid)&&(identical(other.platformUrl, _this.platformUrl) || other.platformUrl == _this.platformUrl)&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as UrlImportState;
  return Object.hash(runtimeType,_this.status,_this.urlInvalid,_this.platformUrl,_this.jobId,_this.failure);
}

@override
String toString() {
  final _this = this as UrlImportState;
  return 'UrlImportState(status: ${_this.status}, urlInvalid: ${_this.urlInvalid}, platformUrl: ${_this.platformUrl}, jobId: ${_this.jobId}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $UrlImportStateCopyWith<$Res>  {
  factory $UrlImportStateCopyWith(UrlImportState value, $Res Function(UrlImportState) _then) = _$UrlImportStateCopyWithImpl;
@useResult
$Res call({
 UrlImportStatus status, bool urlInvalid, String? platformUrl, String? jobId, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$UrlImportStateCopyWithImpl<$Res>
    implements $UrlImportStateCopyWith<$Res> {
  _$UrlImportStateCopyWithImpl(this._self, this._then);

  final UrlImportState _self;
  final $Res Function(UrlImportState) _then;

/// Create a copy of UrlImportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? urlInvalid = null,Object? platformUrl = freezed,Object? jobId = freezed,Object? failure = freezed,}) {
  return _then(UrlImportState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UrlImportStatus,urlInvalid: null == urlInvalid ? _self.urlInvalid : urlInvalid // ignore: cast_nullable_to_non_nullable
as bool,platformUrl: freezed == platformUrl ? _self.platformUrl : platformUrl // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of UrlImportState
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


/// Adds pattern-matching-related methods to [UrlImportState].
extension UrlImportStatePatterns on UrlImportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UrlImportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UrlImportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UrlImportState value)  $default,){
final _that = this;
switch (_that) {
case _UrlImportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UrlImportState value)?  $default,){
final _that = this;
switch (_that) {
case _UrlImportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UrlImportStatus status,  bool urlInvalid,  String? platformUrl,  String? jobId,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UrlImportState() when $default != null:
return $default(_that.status,_that.urlInvalid,_that.platformUrl,_that.jobId,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UrlImportStatus status,  bool urlInvalid,  String? platformUrl,  String? jobId,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _UrlImportState():
return $default(_that.status,_that.urlInvalid,_that.platformUrl,_that.jobId,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UrlImportStatus status,  bool urlInvalid,  String? platformUrl,  String? jobId,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _UrlImportState() when $default != null:
return $default(_that.status,_that.urlInvalid,_that.platformUrl,_that.jobId,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _UrlImportState implements UrlImportState {
  const _UrlImportState({this.status = UrlImportStatus.initial, this.urlInvalid = false, this.platformUrl, this.jobId, this.failure});
  

@override@JsonKey() final  UrlImportStatus status;
@override@JsonKey() final  bool urlInvalid;
/// A YouTube/Drive/Dropbox link: the page hands it to the link flow
/// and calls [UrlImportCubit.consumed].
@override final  String? platformUrl;
@override final  String? jobId;
@override final  Failure? failure;

/// Create a copy of UrlImportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UrlImportStateCopyWith<_UrlImportState> get copyWith => __$UrlImportStateCopyWithImpl<_UrlImportState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UrlImportState&&(identical(other.status, status) || other.status == status)&&(identical(other.urlInvalid, urlInvalid) || other.urlInvalid == urlInvalid)&&(identical(other.platformUrl, platformUrl) || other.platformUrl == platformUrl)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,urlInvalid,platformUrl,jobId,failure);
}

@override
String toString() {
    return 'UrlImportState(status: $status, urlInvalid: $urlInvalid, platformUrl: $platformUrl, jobId: $jobId, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$UrlImportStateCopyWith<$Res> implements $UrlImportStateCopyWith<$Res> {
  factory _$UrlImportStateCopyWith(_UrlImportState value, $Res Function(_UrlImportState) _then) = __$UrlImportStateCopyWithImpl;
@override @useResult
$Res call({
 UrlImportStatus status, bool urlInvalid, String? platformUrl, String? jobId, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$UrlImportStateCopyWithImpl<$Res>
    implements _$UrlImportStateCopyWith<$Res> {
  __$UrlImportStateCopyWithImpl(this._self, this._then);

  final _UrlImportState _self;
  final $Res Function(_UrlImportState) _then;

/// Create a copy of UrlImportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? urlInvalid = null,Object? platformUrl = freezed,Object? jobId = freezed,Object? failure = freezed,}) {
  return _then(_UrlImportState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UrlImportStatus,urlInvalid: null == urlInvalid ? _self.urlInvalid : urlInvalid // ignore: cast_nullable_to_non_nullable
as bool,platformUrl: freezed == platformUrl ? _self.platformUrl : platformUrl // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of UrlImportState
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
