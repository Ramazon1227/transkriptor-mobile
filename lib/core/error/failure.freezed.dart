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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( TimeoutFailure value)?  timeout,TResult Function( UnauthorizedFailure value)?  unauthorized,TResult Function( ServerFailure value)?  server,TResult Function( PendingLimitFailure value)?  pendingLimit,TResult Function( JobActiveFailure value)?  jobActive,TResult Function( IdempotencyMismatchFailure value)?  idempotencyMismatch,TResult Function( SoleOwnerFailure value)?  soleOwner,TResult Function( LastAdminFailure value)?  lastAdmin,TResult Function( ParsingFailure value)?  parsing,TResult Function( CancelledFailure value)?  cancelled,TResult Function( PermissionDeniedFailure value)?  permissionDenied,TResult Function( StorageFailure value)?  storage,TResult Function( CaptureFailure value)?  capture,TResult Function( UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case ServerFailure() when server != null:
return server(_that);case PendingLimitFailure() when pendingLimit != null:
return pendingLimit(_that);case JobActiveFailure() when jobActive != null:
return jobActive(_that);case IdempotencyMismatchFailure() when idempotencyMismatch != null:
return idempotencyMismatch(_that);case SoleOwnerFailure() when soleOwner != null:
return soleOwner(_that);case LastAdminFailure() when lastAdmin != null:
return lastAdmin(_that);case ParsingFailure() when parsing != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( TimeoutFailure value)  timeout,required TResult Function( UnauthorizedFailure value)  unauthorized,required TResult Function( ServerFailure value)  server,required TResult Function( PendingLimitFailure value)  pendingLimit,required TResult Function( JobActiveFailure value)  jobActive,required TResult Function( IdempotencyMismatchFailure value)  idempotencyMismatch,required TResult Function( SoleOwnerFailure value)  soleOwner,required TResult Function( LastAdminFailure value)  lastAdmin,required TResult Function( ParsingFailure value)  parsing,required TResult Function( CancelledFailure value)  cancelled,required TResult Function( PermissionDeniedFailure value)  permissionDenied,required TResult Function( StorageFailure value)  storage,required TResult Function( CaptureFailure value)  capture,required TResult Function( UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case TimeoutFailure():
return timeout(_that);case UnauthorizedFailure():
return unauthorized(_that);case ServerFailure():
return server(_that);case PendingLimitFailure():
return pendingLimit(_that);case JobActiveFailure():
return jobActive(_that);case IdempotencyMismatchFailure():
return idempotencyMismatch(_that);case SoleOwnerFailure():
return soleOwner(_that);case LastAdminFailure():
return lastAdmin(_that);case ParsingFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( TimeoutFailure value)?  timeout,TResult? Function( UnauthorizedFailure value)?  unauthorized,TResult? Function( ServerFailure value)?  server,TResult? Function( PendingLimitFailure value)?  pendingLimit,TResult? Function( JobActiveFailure value)?  jobActive,TResult? Function( IdempotencyMismatchFailure value)?  idempotencyMismatch,TResult? Function( SoleOwnerFailure value)?  soleOwner,TResult? Function( LastAdminFailure value)?  lastAdmin,TResult? Function( ParsingFailure value)?  parsing,TResult? Function( CancelledFailure value)?  cancelled,TResult? Function( PermissionDeniedFailure value)?  permissionDenied,TResult? Function( StorageFailure value)?  storage,TResult? Function( CaptureFailure value)?  capture,TResult? Function( UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case ServerFailure() when server != null:
return server(_that);case PendingLimitFailure() when pendingLimit != null:
return pendingLimit(_that);case JobActiveFailure() when jobActive != null:
return jobActive(_that);case IdempotencyMismatchFailure() when idempotencyMismatch != null:
return idempotencyMismatch(_that);case SoleOwnerFailure() when soleOwner != null:
return soleOwner(_that);case LastAdminFailure() when lastAdmin != null:
return lastAdmin(_that);case ParsingFailure() when parsing != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  network,TResult Function()?  timeout,TResult Function()?  unauthorized,TResult Function( int? statusCode,  String? message)?  server,TResult Function( List<HeldFile> held)?  pendingLimit,TResult Function()?  jobActive,TResult Function()?  idempotencyMismatch,TResult Function( List<String> workspaces)?  soleOwner,TResult Function()?  lastAdmin,TResult Function()?  parsing,TResult Function()?  cancelled,TResult Function()?  permissionDenied,TResult Function()?  storage,TResult Function( CaptureError reason)?  capture,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case TimeoutFailure() when timeout != null:
return timeout();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case ServerFailure() when server != null:
return server(_that.statusCode,_that.message);case PendingLimitFailure() when pendingLimit != null:
return pendingLimit(_that.held);case JobActiveFailure() when jobActive != null:
return jobActive();case IdempotencyMismatchFailure() when idempotencyMismatch != null:
return idempotencyMismatch();case SoleOwnerFailure() when soleOwner != null:
return soleOwner(_that.workspaces);case LastAdminFailure() when lastAdmin != null:
return lastAdmin();case ParsingFailure() when parsing != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  network,required TResult Function()  timeout,required TResult Function()  unauthorized,required TResult Function( int? statusCode,  String? message)  server,required TResult Function( List<HeldFile> held)  pendingLimit,required TResult Function()  jobActive,required TResult Function()  idempotencyMismatch,required TResult Function( List<String> workspaces)  soleOwner,required TResult Function()  lastAdmin,required TResult Function()  parsing,required TResult Function()  cancelled,required TResult Function()  permissionDenied,required TResult Function()  storage,required TResult Function( CaptureError reason)  capture,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network();case TimeoutFailure():
return timeout();case UnauthorizedFailure():
return unauthorized();case ServerFailure():
return server(_that.statusCode,_that.message);case PendingLimitFailure():
return pendingLimit(_that.held);case JobActiveFailure():
return jobActive();case IdempotencyMismatchFailure():
return idempotencyMismatch();case SoleOwnerFailure():
return soleOwner(_that.workspaces);case LastAdminFailure():
return lastAdmin();case ParsingFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  network,TResult? Function()?  timeout,TResult? Function()?  unauthorized,TResult? Function( int? statusCode,  String? message)?  server,TResult? Function( List<HeldFile> held)?  pendingLimit,TResult? Function()?  jobActive,TResult? Function()?  idempotencyMismatch,TResult? Function( List<String> workspaces)?  soleOwner,TResult? Function()?  lastAdmin,TResult? Function()?  parsing,TResult? Function()?  cancelled,TResult? Function()?  permissionDenied,TResult? Function()?  storage,TResult? Function( CaptureError reason)?  capture,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case TimeoutFailure() when timeout != null:
return timeout();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case ServerFailure() when server != null:
return server(_that.statusCode,_that.message);case PendingLimitFailure() when pendingLimit != null:
return pendingLimit(_that.held);case JobActiveFailure() when jobActive != null:
return jobActive();case IdempotencyMismatchFailure() when idempotencyMismatch != null:
return idempotencyMismatch();case SoleOwnerFailure() when soleOwner != null:
return soleOwner(_that.workspaces);case LastAdminFailure() when lastAdmin != null:
return lastAdmin();case ParsingFailure() when parsing != null:
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


class PendingLimitFailure implements Failure {
  const PendingLimitFailure({ List<HeldFile> held = const <HeldFile>[]}): _held = held;
  

 final  List<HeldFile> _held;
@JsonKey() List<HeldFile> get held {
  if (_held is EqualUnmodifiableListView) return _held;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_held);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingLimitFailureCopyWith<PendingLimitFailure> get copyWith => _$PendingLimitFailureCopyWithImpl<PendingLimitFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingLimitFailure&&const DeepCollectionEquality().equals(other.held, _held));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_held));
}

@override
String toString() {
    return 'Failure.pendingLimit(held: $held)';
}


}

/// @nodoc
abstract mixin class $PendingLimitFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $PendingLimitFailureCopyWith(PendingLimitFailure value, $Res Function(PendingLimitFailure) _then) = _$PendingLimitFailureCopyWithImpl;
@useResult
$Res call({
 List<HeldFile> held
});




}
/// @nodoc
class _$PendingLimitFailureCopyWithImpl<$Res>
    implements $PendingLimitFailureCopyWith<$Res> {
  _$PendingLimitFailureCopyWithImpl(this._self, this._then);

  final PendingLimitFailure _self;
  final $Res Function(PendingLimitFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? held = null,}) {
  return _then(PendingLimitFailure(
held: null == held ? _self._held : held // ignore: cast_nullable_to_non_nullable
as List<HeldFile>,
  ));
}


}

/// @nodoc


class JobActiveFailure implements Failure {
  const JobActiveFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JobActiveFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.jobActive()';
}


}




/// @nodoc


class IdempotencyMismatchFailure implements Failure {
  const IdempotencyMismatchFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is IdempotencyMismatchFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.idempotencyMismatch()';
}


}




/// @nodoc


class SoleOwnerFailure implements Failure {
  const SoleOwnerFailure( List<String> workspaces): _workspaces = workspaces;
  

 final  List<String> _workspaces;
 List<String> get workspaces {
  if (_workspaces is EqualUnmodifiableListView) return _workspaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workspaces);
}


/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SoleOwnerFailureCopyWith<SoleOwnerFailure> get copyWith => _$SoleOwnerFailureCopyWithImpl<SoleOwnerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SoleOwnerFailure&&const DeepCollectionEquality().equals(other.workspaces, _workspaces));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_workspaces));
}

@override
String toString() {
    return 'Failure.soleOwner(workspaces: $workspaces)';
}


}

/// @nodoc
abstract mixin class $SoleOwnerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $SoleOwnerFailureCopyWith(SoleOwnerFailure value, $Res Function(SoleOwnerFailure) _then) = _$SoleOwnerFailureCopyWithImpl;
@useResult
$Res call({
 List<String> workspaces
});




}
/// @nodoc
class _$SoleOwnerFailureCopyWithImpl<$Res>
    implements $SoleOwnerFailureCopyWith<$Res> {
  _$SoleOwnerFailureCopyWithImpl(this._self, this._then);

  final SoleOwnerFailure _self;
  final $Res Function(SoleOwnerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? workspaces = null,}) {
  return _then(SoleOwnerFailure(
null == workspaces ? _self._workspaces : workspaces // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class LastAdminFailure implements Failure {
  const LastAdminFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LastAdminFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.lastAdmin()';
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
