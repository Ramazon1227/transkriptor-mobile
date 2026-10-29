// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentiment_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SentimentState {

 SentimentViewStatus get status;/// Null on success: never requested.
 SentimentAnalysis? get analysis;/// The first load failed: nothing to show but a retry.
 Failure? get failure;/// The start request is on its way.
 bool get starting;/// Starting failed (403 VIEWER, 409, 503…); the panel stays as it was.
 Failure? get startFailure;/// Asking about a pending analysis failed; retried when transient.
 Failure? get pollFailure;
/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentimentStateCopyWith<SentimentState> get copyWith => _$SentimentStateCopyWithImpl<SentimentState>(this as SentimentState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SentimentState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentimentState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.analysis, _this.analysis) || other.analysis == _this.analysis)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.starting, _this.starting) || other.starting == _this.starting)&&(identical(other.startFailure, _this.startFailure) || other.startFailure == _this.startFailure)&&(identical(other.pollFailure, _this.pollFailure) || other.pollFailure == _this.pollFailure));
}


@override
int get hashCode {
  final _this = this as SentimentState;
  return Object.hash(runtimeType,_this.status,_this.analysis,_this.failure,_this.starting,_this.startFailure,_this.pollFailure);
}

@override
String toString() {
  final _this = this as SentimentState;
  return 'SentimentState(status: ${_this.status}, analysis: ${_this.analysis}, failure: ${_this.failure}, starting: ${_this.starting}, startFailure: ${_this.startFailure}, pollFailure: ${_this.pollFailure})';
}


}

/// @nodoc
abstract mixin class $SentimentStateCopyWith<$Res>  {
  factory $SentimentStateCopyWith(SentimentState value, $Res Function(SentimentState) _then) = _$SentimentStateCopyWithImpl;
@useResult
$Res call({
 SentimentViewStatus status, SentimentAnalysis? analysis, Failure? failure, bool starting, Failure? startFailure, Failure? pollFailure
});


$SentimentAnalysisCopyWith<$Res>? get analysis;$FailureCopyWith<$Res>? get failure;$FailureCopyWith<$Res>? get startFailure;$FailureCopyWith<$Res>? get pollFailure;

}
/// @nodoc
class _$SentimentStateCopyWithImpl<$Res>
    implements $SentimentStateCopyWith<$Res> {
  _$SentimentStateCopyWithImpl(this._self, this._then);

  final SentimentState _self;
  final $Res Function(SentimentState) _then;

/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? analysis = freezed,Object? failure = freezed,Object? starting = null,Object? startFailure = freezed,Object? pollFailure = freezed,}) {
  return _then(SentimentState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SentimentViewStatus,analysis: freezed == analysis ? _self.analysis : analysis // ignore: cast_nullable_to_non_nullable
as SentimentAnalysis?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,starting: null == starting ? _self.starting : starting // ignore: cast_nullable_to_non_nullable
as bool,startFailure: freezed == startFailure ? _self.startFailure : startFailure // ignore: cast_nullable_to_non_nullable
as Failure?,pollFailure: freezed == pollFailure ? _self.pollFailure : pollFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentAnalysisCopyWith<$Res>? get analysis {
    if (_self.analysis == null) {
    return null;
  }

  return $SentimentAnalysisCopyWith<$Res>(_self.analysis!, (value) {
    return _then(_self.copyWith(analysis: value));
  });
}/// Create a copy of SentimentState
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
}/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get startFailure {
    if (_self.startFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.startFailure!, (value) {
    return _then(_self.copyWith(startFailure: value));
  });
}/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get pollFailure {
    if (_self.pollFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.pollFailure!, (value) {
    return _then(_self.copyWith(pollFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [SentimentState].
extension SentimentStatePatterns on SentimentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentimentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentimentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentimentState value)  $default,){
final _that = this;
switch (_that) {
case _SentimentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentimentState value)?  $default,){
final _that = this;
switch (_that) {
case _SentimentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SentimentViewStatus status,  SentimentAnalysis? analysis,  Failure? failure,  bool starting,  Failure? startFailure,  Failure? pollFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentimentState() when $default != null:
return $default(_that.status,_that.analysis,_that.failure,_that.starting,_that.startFailure,_that.pollFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SentimentViewStatus status,  SentimentAnalysis? analysis,  Failure? failure,  bool starting,  Failure? startFailure,  Failure? pollFailure)  $default,) {final _that = this;
switch (_that) {
case _SentimentState():
return $default(_that.status,_that.analysis,_that.failure,_that.starting,_that.startFailure,_that.pollFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SentimentViewStatus status,  SentimentAnalysis? analysis,  Failure? failure,  bool starting,  Failure? startFailure,  Failure? pollFailure)?  $default,) {final _that = this;
switch (_that) {
case _SentimentState() when $default != null:
return $default(_that.status,_that.analysis,_that.failure,_that.starting,_that.startFailure,_that.pollFailure);case _:
  return null;

}
}

}

/// @nodoc


class _SentimentState extends SentimentState {
  const _SentimentState({this.status = SentimentViewStatus.initial, this.analysis, this.failure, this.starting = false, this.startFailure, this.pollFailure}): super._();
  

@override@JsonKey() final  SentimentViewStatus status;
/// Null on success: never requested.
@override final  SentimentAnalysis? analysis;
/// The first load failed: nothing to show but a retry.
@override final  Failure? failure;
/// The start request is on its way.
@override@JsonKey() final  bool starting;
/// Starting failed (403 VIEWER, 409, 503…); the panel stays as it was.
@override final  Failure? startFailure;
/// Asking about a pending analysis failed; retried when transient.
@override final  Failure? pollFailure;

/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentimentStateCopyWith<_SentimentState> get copyWith => __$SentimentStateCopyWithImpl<_SentimentState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentimentState&&(identical(other.status, status) || other.status == status)&&(identical(other.analysis, analysis) || other.analysis == analysis)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.starting, starting) || other.starting == starting)&&(identical(other.startFailure, startFailure) || other.startFailure == startFailure)&&(identical(other.pollFailure, pollFailure) || other.pollFailure == pollFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,analysis,failure,starting,startFailure,pollFailure);
}

@override
String toString() {
    return 'SentimentState(status: $status, analysis: $analysis, failure: $failure, starting: $starting, startFailure: $startFailure, pollFailure: $pollFailure)';
}


}

/// @nodoc
abstract mixin class _$SentimentStateCopyWith<$Res> implements $SentimentStateCopyWith<$Res> {
  factory _$SentimentStateCopyWith(_SentimentState value, $Res Function(_SentimentState) _then) = __$SentimentStateCopyWithImpl;
@override @useResult
$Res call({
 SentimentViewStatus status, SentimentAnalysis? analysis, Failure? failure, bool starting, Failure? startFailure, Failure? pollFailure
});


@override $SentimentAnalysisCopyWith<$Res>? get analysis;@override $FailureCopyWith<$Res>? get failure;@override $FailureCopyWith<$Res>? get startFailure;@override $FailureCopyWith<$Res>? get pollFailure;

}
/// @nodoc
class __$SentimentStateCopyWithImpl<$Res>
    implements _$SentimentStateCopyWith<$Res> {
  __$SentimentStateCopyWithImpl(this._self, this._then);

  final _SentimentState _self;
  final $Res Function(_SentimentState) _then;

/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? analysis = freezed,Object? failure = freezed,Object? starting = null,Object? startFailure = freezed,Object? pollFailure = freezed,}) {
  return _then(_SentimentState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SentimentViewStatus,analysis: freezed == analysis ? _self.analysis : analysis // ignore: cast_nullable_to_non_nullable
as SentimentAnalysis?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,starting: null == starting ? _self.starting : starting // ignore: cast_nullable_to_non_nullable
as bool,startFailure: freezed == startFailure ? _self.startFailure : startFailure // ignore: cast_nullable_to_non_nullable
as Failure?,pollFailure: freezed == pollFailure ? _self.pollFailure : pollFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentAnalysisCopyWith<$Res>? get analysis {
    if (_self.analysis == null) {
    return null;
  }

  return $SentimentAnalysisCopyWith<$Res>(_self.analysis!, (value) {
    return _then(_self.copyWith(analysis: value));
  });
}/// Create a copy of SentimentState
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
}/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get startFailure {
    if (_self.startFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.startFailure!, (value) {
    return _then(_self.copyWith(startFailure: value));
  });
}/// Create a copy of SentimentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get pollFailure {
    if (_self.pollFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.pollFailure!, (value) {
    return _then(_self.copyWith(pollFailure: value));
  });
}
}

// dart format on
