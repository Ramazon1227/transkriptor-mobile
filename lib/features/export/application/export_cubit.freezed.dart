// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExportState {

 ExportFormat get format; ExportOptions get options; ExportStatus get status; Failure? get failure;
/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportStateCopyWith<ExportState> get copyWith => _$ExportStateCopyWithImpl<ExportState>(this as ExportState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExportState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportState&&(identical(other.format, _this.format) || other.format == _this.format)&&(identical(other.options, _this.options) || other.options == _this.options)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as ExportState;
  return Object.hash(runtimeType,_this.format,_this.options,_this.status,_this.failure);
}

@override
String toString() {
  final _this = this as ExportState;
  return 'ExportState(format: ${_this.format}, options: ${_this.options}, status: ${_this.status}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $ExportStateCopyWith<$Res>  {
  factory $ExportStateCopyWith(ExportState value, $Res Function(ExportState) _then) = _$ExportStateCopyWithImpl;
@useResult
$Res call({
 ExportFormat format, ExportOptions options, ExportStatus status, Failure? failure
});


$ExportOptionsCopyWith<$Res> get options;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ExportStateCopyWithImpl<$Res>
    implements $ExportStateCopyWith<$Res> {
  _$ExportStateCopyWithImpl(this._self, this._then);

  final ExportState _self;
  final $Res Function(ExportState) _then;

/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? format = null,Object? options = null,Object? status = null,Object? failure = freezed,}) {
  return _then(ExportState(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as ExportFormat,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as ExportOptions,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExportStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExportOptionsCopyWith<$Res> get options {
  
  return $ExportOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of ExportState
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


/// Adds pattern-matching-related methods to [ExportState].
extension ExportStatePatterns on ExportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExportState value)  $default,){
final _that = this;
switch (_that) {
case _ExportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExportState value)?  $default,){
final _that = this;
switch (_that) {
case _ExportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExportFormat format,  ExportOptions options,  ExportStatus status,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportState() when $default != null:
return $default(_that.format,_that.options,_that.status,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExportFormat format,  ExportOptions options,  ExportStatus status,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _ExportState():
return $default(_that.format,_that.options,_that.status,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExportFormat format,  ExportOptions options,  ExportStatus status,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _ExportState() when $default != null:
return $default(_that.format,_that.options,_that.status,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _ExportState implements ExportState {
  const _ExportState({this.format = ExportFormat.txt, this.options = const ExportOptions(), this.status = ExportStatus.idle, this.failure});
  

@override@JsonKey() final  ExportFormat format;
@override@JsonKey() final  ExportOptions options;
@override@JsonKey() final  ExportStatus status;
@override final  Failure? failure;

/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportStateCopyWith<_ExportState> get copyWith => __$ExportStateCopyWithImpl<_ExportState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportState&&(identical(other.format, format) || other.format == format)&&(identical(other.options, options) || other.options == options)&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,format,options,status,failure);
}

@override
String toString() {
    return 'ExportState(format: $format, options: $options, status: $status, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ExportStateCopyWith<$Res> implements $ExportStateCopyWith<$Res> {
  factory _$ExportStateCopyWith(_ExportState value, $Res Function(_ExportState) _then) = __$ExportStateCopyWithImpl;
@override @useResult
$Res call({
 ExportFormat format, ExportOptions options, ExportStatus status, Failure? failure
});


@override $ExportOptionsCopyWith<$Res> get options;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ExportStateCopyWithImpl<$Res>
    implements _$ExportStateCopyWith<$Res> {
  __$ExportStateCopyWithImpl(this._self, this._then);

  final _ExportState _self;
  final $Res Function(_ExportState) _then;

/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? format = null,Object? options = null,Object? status = null,Object? failure = freezed,}) {
  return _then(_ExportState(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as ExportFormat,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as ExportOptions,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExportStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExportOptionsCopyWith<$Res> get options {
  
  return $ExportOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of ExportState
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
