// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiChatState {

 AiChatStatus get status; List<AiMessage> get items;/// The first load failed: nothing to show but a retry.
 Failure? get failure;/// A question is on its way to the server.
 bool get sending; bool get clearing;/// A send or clear failed; the chat stays as it was.
 Failure? get actionFailure;/// Asking about the pending answer failed; still retried when it is
/// transient.
 Failure? get pollFailure;
/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiChatStateCopyWith<AiChatState> get copyWith => _$AiChatStateCopyWithImpl<AiChatState>(this as AiChatState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AiChatState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiChatState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.sending, _this.sending) || other.sending == _this.sending)&&(identical(other.clearing, _this.clearing) || other.clearing == _this.clearing)&&(identical(other.actionFailure, _this.actionFailure) || other.actionFailure == _this.actionFailure)&&(identical(other.pollFailure, _this.pollFailure) || other.pollFailure == _this.pollFailure));
}


@override
int get hashCode {
  final _this = this as AiChatState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.items),_this.failure,_this.sending,_this.clearing,_this.actionFailure,_this.pollFailure);
}

@override
String toString() {
  final _this = this as AiChatState;
  return 'AiChatState(status: ${_this.status}, items: ${_this.items}, failure: ${_this.failure}, sending: ${_this.sending}, clearing: ${_this.clearing}, actionFailure: ${_this.actionFailure}, pollFailure: ${_this.pollFailure})';
}


}

/// @nodoc
abstract mixin class $AiChatStateCopyWith<$Res>  {
  factory $AiChatStateCopyWith(AiChatState value, $Res Function(AiChatState) _then) = _$AiChatStateCopyWithImpl;
@useResult
$Res call({
 AiChatStatus status, List<AiMessage> items, Failure? failure, bool sending, bool clearing, Failure? actionFailure, Failure? pollFailure
});


$FailureCopyWith<$Res>? get failure;$FailureCopyWith<$Res>? get actionFailure;$FailureCopyWith<$Res>? get pollFailure;

}
/// @nodoc
class _$AiChatStateCopyWithImpl<$Res>
    implements $AiChatStateCopyWith<$Res> {
  _$AiChatStateCopyWithImpl(this._self, this._then);

  final AiChatState _self;
  final $Res Function(AiChatState) _then;

/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? failure = freezed,Object? sending = null,Object? clearing = null,Object? actionFailure = freezed,Object? pollFailure = freezed,}) {
  return _then(AiChatState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiChatStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AiMessage>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool,clearing: null == clearing ? _self.clearing : clearing // ignore: cast_nullable_to_non_nullable
as bool,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,pollFailure: freezed == pollFailure ? _self.pollFailure : pollFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of AiChatState
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
}/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}/// Create a copy of AiChatState
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


/// Adds pattern-matching-related methods to [AiChatState].
extension AiChatStatePatterns on AiChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiChatState value)  $default,){
final _that = this;
switch (_that) {
case _AiChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiChatState value)?  $default,){
final _that = this;
switch (_that) {
case _AiChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiChatStatus status,  List<AiMessage> items,  Failure? failure,  bool sending,  bool clearing,  Failure? actionFailure,  Failure? pollFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiChatState() when $default != null:
return $default(_that.status,_that.items,_that.failure,_that.sending,_that.clearing,_that.actionFailure,_that.pollFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiChatStatus status,  List<AiMessage> items,  Failure? failure,  bool sending,  bool clearing,  Failure? actionFailure,  Failure? pollFailure)  $default,) {final _that = this;
switch (_that) {
case _AiChatState():
return $default(_that.status,_that.items,_that.failure,_that.sending,_that.clearing,_that.actionFailure,_that.pollFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiChatStatus status,  List<AiMessage> items,  Failure? failure,  bool sending,  bool clearing,  Failure? actionFailure,  Failure? pollFailure)?  $default,) {final _that = this;
switch (_that) {
case _AiChatState() when $default != null:
return $default(_that.status,_that.items,_that.failure,_that.sending,_that.clearing,_that.actionFailure,_that.pollFailure);case _:
  return null;

}
}

}

/// @nodoc


class _AiChatState extends AiChatState {
  const _AiChatState({this.status = AiChatStatus.initial,  List<AiMessage> items = const <AiMessage>[], this.failure, this.sending = false, this.clearing = false, this.actionFailure, this.pollFailure}): _items = items,super._();
  

@override@JsonKey() final  AiChatStatus status;
 final  List<AiMessage> _items;
@override@JsonKey() List<AiMessage> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// The first load failed: nothing to show but a retry.
@override final  Failure? failure;
/// A question is on its way to the server.
@override@JsonKey() final  bool sending;
@override@JsonKey() final  bool clearing;
/// A send or clear failed; the chat stays as it was.
@override final  Failure? actionFailure;
/// Asking about the pending answer failed; still retried when it is
/// transient.
@override final  Failure? pollFailure;

/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiChatStateCopyWith<_AiChatState> get copyWith => __$AiChatStateCopyWithImpl<_AiChatState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.clearing, clearing) || other.clearing == clearing)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure)&&(identical(other.pollFailure, pollFailure) || other.pollFailure == pollFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),failure,sending,clearing,actionFailure,pollFailure);
}

@override
String toString() {
    return 'AiChatState(status: $status, items: $items, failure: $failure, sending: $sending, clearing: $clearing, actionFailure: $actionFailure, pollFailure: $pollFailure)';
}


}

/// @nodoc
abstract mixin class _$AiChatStateCopyWith<$Res> implements $AiChatStateCopyWith<$Res> {
  factory _$AiChatStateCopyWith(_AiChatState value, $Res Function(_AiChatState) _then) = __$AiChatStateCopyWithImpl;
@override @useResult
$Res call({
 AiChatStatus status, List<AiMessage> items, Failure? failure, bool sending, bool clearing, Failure? actionFailure, Failure? pollFailure
});


@override $FailureCopyWith<$Res>? get failure;@override $FailureCopyWith<$Res>? get actionFailure;@override $FailureCopyWith<$Res>? get pollFailure;

}
/// @nodoc
class __$AiChatStateCopyWithImpl<$Res>
    implements _$AiChatStateCopyWith<$Res> {
  __$AiChatStateCopyWithImpl(this._self, this._then);

  final _AiChatState _self;
  final $Res Function(_AiChatState) _then;

/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? failure = freezed,Object? sending = null,Object? clearing = null,Object? actionFailure = freezed,Object? pollFailure = freezed,}) {
  return _then(_AiChatState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiChatStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AiMessage>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool,clearing: null == clearing ? _self.clearing : clearing // ignore: cast_nullable_to_non_nullable
as bool,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,pollFailure: freezed == pollFailure ? _self.pollFailure : pollFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of AiChatState
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
}/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}/// Create a copy of AiChatState
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
