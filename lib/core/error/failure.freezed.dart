// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( TimeoutFailure value)?  timeout,TResult Function( UnauthorizedFailure value)?  unauthorized,TResult Function( ServerFailure value)?  server,TResult Function( ParsingFailure value)?  parsing,TResult Function( CancelledFailure value)?  cancelled,TResult Function( PermissionDeniedFailure value)?  permissionDenied,TResult Function( StorageFailure value)?  storage,TResult Function( CaptureFailure value)?  capture,TResult Function( UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case ServerFailure() when server != null:
return server(_that);case ParsingFailure() when parsing != null:
return parsing(_that);case CancelledFailure() when cancelled != null:
return cancelled(_that);case PermissionDeniedFailure() when permissionDenied != null:
return permissionDenied(_that);case StorageFailure() when storage != null:
return storage(_that);case CaptureFailure() when capture != null:
return capture(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( TimeoutFailure value)  timeout,required TResult Function( UnauthorizedFailure value)  unauthorized,required TResult Function( ServerFailure value)  server,required TResult Function( ParsingFailure value)  parsing,required TResult Function( CancelledFailure value)  cancelled,required TResult Function( PermissionDeniedFailure value)  permissionDenied,required TResult Function( StorageFailure value)  storage,required TResult Function( CaptureFailure value)  capture,required TResult Function( UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case TimeoutFailure():
return timeout(_that);case UnauthorizedFailure():
return unauthorized(_that);case ServerFailure():
return server(_that);case ParsingFailure():
return parsing(_that);case CancelledFailure():
return cancelled(_that);case PermissionDeniedFailure():
return permissionDenied(_that);case StorageFailure():
return storage(_that);case CaptureFailure():
return capture(_that);case UnknownFailure():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( TimeoutFailure value)?  timeout,TResult? Function( UnauthorizedFailure value)?  unauthorized,TResult? Function( ServerFailure value)?  server,TResult? Function( ParsingFailure value)?  parsing,TResult? Function( CancelledFailure value)?  cancelled,TResult? Function( PermissionDeniedFailure value)?  permissionDenied,TResult? Function( StorageFailure value)?  storage,TResult? Function( CaptureFailure value)?  capture,TResult? Function( UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case ServerFailure() when server != null:
return server(_that);case ParsingFailure() when parsing != null:
return parsing(_that);case CancelledFailure() when cancelled != null:
return cancelled(_that);case PermissionDeniedFailure() when permissionDenied != null:
return permissionDenied(_that);case StorageFailure() when storage != null:
return storage(_that);case CaptureFailure() when capture != null:
return capture(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  network,TResult Function()?  timeout,TResult Function()?  unauthorized,TResult Function( int? statusCode,  String? message)?  server,TResult Function()?  parsing,TResult Function()?  cancelled,TResult Function()?  permissionDenied,TResult Function()?  storage,TResult Function( CaptureError reason)?  capture,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case TimeoutFailure() when timeout != null:
return timeout();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case ServerFailure() when server != null:
return server(_that.statusCode,_that.message);case ParsingFailure() when parsing != null:
return parsing();case CancelledFailure() when cancelled != null:
return cancelled();case PermissionDeniedFailure() when permissionDenied != null:
return permissionDenied();case StorageFailure() when storage != null:
return storage();case CaptureFailure() when capture != null:
return capture(_that.reason);case UnknownFailure() when unknown != null:
return unknown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  network,required TResult Function()  timeout,required TResult Function()  unauthorized,required TResult Function( int? statusCode,  String? message)  server,required TResult Function()  parsing,required TResult Function()  cancelled,required TResult Function()  permissionDenied,required TResult Function()  storage,required TResult Function( CaptureError reason)  capture,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network();case TimeoutFailure():
return timeout();case UnauthorizedFailure():
return unauthorized();case ServerFailure():
return server(_that.statusCode,_that.message);case ParsingFailure():
return parsing();case CancelledFailure():
return cancelled();case PermissionDeniedFailure():
return permissionDenied();case StorageFailure():
return storage();case CaptureFailure():
return capture(_that.reason);case UnknownFailure():
return unknown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  network,TResult? Function()?  timeout,TResult? Function()?  unauthorized,TResult? Function( int? statusCode,  String? message)?  server,TResult? Function()?  parsing,TResult? Function()?  cancelled,TResult? Function()?  permissionDenied,TResult? Function()?  storage,TResult? Function( CaptureError reason)?  capture,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case TimeoutFailure() when timeout != null:
return timeout();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case ServerFailure() when server != null:
return server(_that.statusCode,_that.message);case ParsingFailure() when parsing != null:
return parsing();case CancelledFailure() when cancelled != null:
return cancelled();case PermissionDeniedFailure() when permissionDenied != null:
return permissionDenied();case StorageFailure() when storage != null:
return storage();case CaptureFailure() when capture != null:
return capture(_that.reason);case UnknownFailure() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc


class NetworkFailure implements Failure {
  const NetworkFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.network()';
}


}




/// @nodoc


class TimeoutFailure implements Failure {
  const TimeoutFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.timeout()';
}


}




/// @nodoc


class UnauthorizedFailure implements Failure {
  const UnauthorizedFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.unauthorized()';
}


}




/// @nodoc


class ServerFailure implements Failure {
  const ServerFailure({this.statusCode, this.message});
  

 final  int? statusCode;
 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,statusCode,message);
}

@override
String toString() {
    return 'Failure.server(statusCode: $statusCode, message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 int? statusCode, String? message
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? statusCode = freezed,Object? message = freezed,}) {
  return _then(ServerFailure(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ParsingFailure implements Failure {
  const ParsingFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsingFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.parsing()';
}


}




/// @nodoc


class CancelledFailure implements Failure {
  const CancelledFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelledFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.cancelled()';
}


}




/// @nodoc


class PermissionDeniedFailure implements Failure {
  const PermissionDeniedFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PermissionDeniedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.permissionDenied()';
}


}




/// @nodoc


class StorageFailure implements Failure {
  const StorageFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.storage()';
}


}




/// @nodoc


class CaptureFailure implements Failure {
  const CaptureFailure(this.reason);
  

 final  CaptureError reason;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptureFailureCopyWith<CaptureFailure> get copyWith => _$CaptureFailureCopyWithImpl<CaptureFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptureFailure&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reason);
}

@override
String toString() {
    return 'Failure.capture(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CaptureFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $CaptureFailureCopyWith(CaptureFailure value, $Res Function(CaptureFailure) _then) = _$CaptureFailureCopyWithImpl;
@useResult
$Res call({
 CaptureError reason
});




}
/// @nodoc
class _$CaptureFailureCopyWithImpl<$Res>
    implements $CaptureFailureCopyWith<$Res> {
  _$CaptureFailureCopyWithImpl(this._self, this._then);

  final CaptureFailure _self;
  final $Res Function(CaptureFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(CaptureFailure(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as CaptureError,
  ));
}


}

/// @nodoc


class UnknownFailure implements Failure {
  const UnknownFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.unknown()';
}


}




// dart format on
