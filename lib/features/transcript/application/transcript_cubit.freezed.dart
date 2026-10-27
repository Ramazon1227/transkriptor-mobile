// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcript_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TranscriptState {

 TranscriptStatus get status; Transcript? get transcript;/// Null shows every speaker.
 String? get speakerFilter; Failure? get failure; EditStatus get editStatus; Failure? get editFailure;
/// Create a copy of TranscriptState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptStateCopyWith<TranscriptState> get copyWith => _$TranscriptStateCopyWithImpl<TranscriptState>(this as TranscriptState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TranscriptState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.transcript, _this.transcript) || other.transcript == _this.transcript)&&(identical(other.speakerFilter, _this.speakerFilter) || other.speakerFilter == _this.speakerFilter)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.editStatus, _this.editStatus) || other.editStatus == _this.editStatus)&&(identical(other.editFailure, _this.editFailure) || other.editFailure == _this.editFailure));
}


@override
int get hashCode {
  final _this = this as TranscriptState;
  return Object.hash(runtimeType,_this.status,_this.transcript,_this.speakerFilter,_this.failure,_this.editStatus,_this.editFailure);
}

@override
String toString() {
  final _this = this as TranscriptState;
  return 'TranscriptState(status: ${_this.status}, transcript: ${_this.transcript}, speakerFilter: ${_this.speakerFilter}, failure: ${_this.failure}, editStatus: ${_this.editStatus}, editFailure: ${_this.editFailure})';
}


}

/// @nodoc
abstract mixin class $TranscriptStateCopyWith<$Res>  {
  factory $TranscriptStateCopyWith(TranscriptState value, $Res Function(TranscriptState) _then) = _$TranscriptStateCopyWithImpl;
@useResult
$Res call({
 TranscriptStatus status, Transcript? transcript, String? speakerFilter, Failure? failure, EditStatus editStatus, Failure? editFailure
});


$TranscriptCopyWith<$Res>? get transcript;$FailureCopyWith<$Res>? get failure;$FailureCopyWith<$Res>? get editFailure;

}
/// @nodoc
class _$TranscriptStateCopyWithImpl<$Res>
    implements $TranscriptStateCopyWith<$Res> {
  _$TranscriptStateCopyWithImpl(this._self, this._then);

  final TranscriptState _self;
  final $Res Function(TranscriptState) _then;

/// Create a copy of TranscriptState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? transcript = freezed,Object? speakerFilter = freezed,Object? failure = freezed,Object? editStatus = null,Object? editFailure = freezed,}) {
  return _then(TranscriptState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TranscriptStatus,transcript: freezed == transcript ? _self.transcript : transcript // ignore: cast_nullable_to_non_nullable
as Transcript?,speakerFilter: freezed == speakerFilter ? _self.speakerFilter : speakerFilter // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,editStatus: null == editStatus ? _self.editStatus : editStatus // ignore: cast_nullable_to_non_nullable
as EditStatus,editFailure: freezed == editFailure ? _self.editFailure : editFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of TranscriptState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranscriptCopyWith<$Res>? get transcript {
    if (_self.transcript == null) {
    return null;
  }

  return $TranscriptCopyWith<$Res>(_self.transcript!, (value) {
    return _then(_self.copyWith(transcript: value));
  });
}/// Create a copy of TranscriptState
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
}/// Create a copy of TranscriptState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get editFailure {
    if (_self.editFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.editFailure!, (value) {
    return _then(_self.copyWith(editFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [TranscriptState].
extension TranscriptStatePatterns on TranscriptState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranscriptState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranscriptState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranscriptState value)  $default,){
final _that = this;
switch (_that) {
case _TranscriptState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranscriptState value)?  $default,){
final _that = this;
switch (_that) {
case _TranscriptState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TranscriptStatus status,  Transcript? transcript,  String? speakerFilter,  Failure? failure,  EditStatus editStatus,  Failure? editFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranscriptState() when $default != null:
return $default(_that.status,_that.transcript,_that.speakerFilter,_that.failure,_that.editStatus,_that.editFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TranscriptStatus status,  Transcript? transcript,  String? speakerFilter,  Failure? failure,  EditStatus editStatus,  Failure? editFailure)  $default,) {final _that = this;
switch (_that) {
case _TranscriptState():
return $default(_that.status,_that.transcript,_that.speakerFilter,_that.failure,_that.editStatus,_that.editFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TranscriptStatus status,  Transcript? transcript,  String? speakerFilter,  Failure? failure,  EditStatus editStatus,  Failure? editFailure)?  $default,) {final _that = this;
switch (_that) {
case _TranscriptState() when $default != null:
return $default(_that.status,_that.transcript,_that.speakerFilter,_that.failure,_that.editStatus,_that.editFailure);case _:
  return null;

}
}

}

/// @nodoc


class _TranscriptState extends TranscriptState {
  const _TranscriptState({this.status = TranscriptStatus.initial, this.transcript, this.speakerFilter, this.failure, this.editStatus = EditStatus.idle, this.editFailure}): super._();
  

@override@JsonKey() final  TranscriptStatus status;
@override final  Transcript? transcript;
/// Null shows every speaker.
@override final  String? speakerFilter;
@override final  Failure? failure;
@override@JsonKey() final  EditStatus editStatus;
@override final  Failure? editFailure;

/// Create a copy of TranscriptState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptStateCopyWith<_TranscriptState> get copyWith => __$TranscriptStateCopyWithImpl<_TranscriptState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranscriptState&&(identical(other.status, status) || other.status == status)&&(identical(other.transcript, transcript) || other.transcript == transcript)&&(identical(other.speakerFilter, speakerFilter) || other.speakerFilter == speakerFilter)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.editStatus, editStatus) || other.editStatus == editStatus)&&(identical(other.editFailure, editFailure) || other.editFailure == editFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,transcript,speakerFilter,failure,editStatus,editFailure);
}

@override
String toString() {
    return 'TranscriptState(status: $status, transcript: $transcript, speakerFilter: $speakerFilter, failure: $failure, editStatus: $editStatus, editFailure: $editFailure)';
}


}

/// @nodoc
abstract mixin class _$TranscriptStateCopyWith<$Res> implements $TranscriptStateCopyWith<$Res> {
  factory _$TranscriptStateCopyWith(_TranscriptState value, $Res Function(_TranscriptState) _then) = __$TranscriptStateCopyWithImpl;
@override @useResult
$Res call({
 TranscriptStatus status, Transcript? transcript, String? speakerFilter, Failure? failure, EditStatus editStatus, Failure? editFailure
});


@override $TranscriptCopyWith<$Res>? get transcript;@override $FailureCopyWith<$Res>? get failure;@override $FailureCopyWith<$Res>? get editFailure;

}
/// @nodoc
class __$TranscriptStateCopyWithImpl<$Res>
    implements _$TranscriptStateCopyWith<$Res> {
  __$TranscriptStateCopyWithImpl(this._self, this._then);

  final _TranscriptState _self;
  final $Res Function(_TranscriptState) _then;

/// Create a copy of TranscriptState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? transcript = freezed,Object? speakerFilter = freezed,Object? failure = freezed,Object? editStatus = null,Object? editFailure = freezed,}) {
  return _then(_TranscriptState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TranscriptStatus,transcript: freezed == transcript ? _self.transcript : transcript // ignore: cast_nullable_to_non_nullable
as Transcript?,speakerFilter: freezed == speakerFilter ? _self.speakerFilter : speakerFilter // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,editStatus: null == editStatus ? _self.editStatus : editStatus // ignore: cast_nullable_to_non_nullable
as EditStatus,editFailure: freezed == editFailure ? _self.editFailure : editFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of TranscriptState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranscriptCopyWith<$Res>? get transcript {
    if (_self.transcript == null) {
    return null;
  }

  return $TranscriptCopyWith<$Res>(_self.transcript!, (value) {
    return _then(_self.copyWith(transcript: value));
  });
}/// Create a copy of TranscriptState
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
}/// Create a copy of TranscriptState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get editFailure {
    if (_self.editFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.editFailure!, (value) {
    return _then(_self.copyWith(editFailure: value));
  });
}
}

// dart format on
