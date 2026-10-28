// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PushMessage {

 String? get jobId;/// Set only when the transcript is ready.
 String? get transcriptId;
/// Create a copy of PushMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushMessageCopyWith<PushMessage> get copyWith => _$PushMessageCopyWithImpl<PushMessage>(this as PushMessage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PushMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushMessage&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.transcriptId, _this.transcriptId) || other.transcriptId == _this.transcriptId));
}


@override
int get hashCode {
  final _this = this as PushMessage;
  return Object.hash(runtimeType,_this.jobId,_this.transcriptId);
}

@override
String toString() {
  final _this = this as PushMessage;
  return 'PushMessage(jobId: ${_this.jobId}, transcriptId: ${_this.transcriptId})';
}


}

/// @nodoc
abstract mixin class $PushMessageCopyWith<$Res>  {
  factory $PushMessageCopyWith(PushMessage value, $Res Function(PushMessage) _then) = _$PushMessageCopyWithImpl;
@useResult
$Res call({
 String? jobId, String? transcriptId
});




}
/// @nodoc
class _$PushMessageCopyWithImpl<$Res>
    implements $PushMessageCopyWith<$Res> {
  _$PushMessageCopyWithImpl(this._self, this._then);

  final PushMessage _self;
  final $Res Function(PushMessage) _then;

/// Create a copy of PushMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobId = freezed,Object? transcriptId = freezed,}) {
  return _then(PushMessage(
jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PushMessage].
extension PushMessagePatterns on PushMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushMessage value)  $default,){
final _that = this;
switch (_that) {
case _PushMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushMessage value)?  $default,){
final _that = this;
switch (_that) {
case _PushMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? jobId,  String? transcriptId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushMessage() when $default != null:
return $default(_that.jobId,_that.transcriptId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? jobId,  String? transcriptId)  $default,) {final _that = this;
switch (_that) {
case _PushMessage():
return $default(_that.jobId,_that.transcriptId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? jobId,  String? transcriptId)?  $default,) {final _that = this;
switch (_that) {
case _PushMessage() when $default != null:
return $default(_that.jobId,_that.transcriptId);case _:
  return null;

}
}

}

/// @nodoc


class _PushMessage extends PushMessage {
  const _PushMessage({this.jobId, this.transcriptId}): super._();
  

@override final  String? jobId;
/// Set only when the transcript is ready.
@override final  String? transcriptId;

/// Create a copy of PushMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushMessageCopyWith<_PushMessage> get copyWith => __$PushMessageCopyWithImpl<_PushMessage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushMessage&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.transcriptId, transcriptId) || other.transcriptId == transcriptId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,jobId,transcriptId);
}

@override
String toString() {
    return 'PushMessage(jobId: $jobId, transcriptId: $transcriptId)';
}


}

/// @nodoc
abstract mixin class _$PushMessageCopyWith<$Res> implements $PushMessageCopyWith<$Res> {
  factory _$PushMessageCopyWith(_PushMessage value, $Res Function(_PushMessage) _then) = __$PushMessageCopyWithImpl;
@override @useResult
$Res call({
 String? jobId, String? transcriptId
});




}
/// @nodoc
class __$PushMessageCopyWithImpl<$Res>
    implements _$PushMessageCopyWith<$Res> {
  __$PushMessageCopyWithImpl(this._self, this._then);

  final _PushMessage _self;
  final $Res Function(_PushMessage) _then;

/// Create a copy of PushMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobId = freezed,Object? transcriptId = freezed,}) {
  return _then(_PushMessage(
jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,transcriptId: freezed == transcriptId ? _self.transcriptId : transcriptId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
